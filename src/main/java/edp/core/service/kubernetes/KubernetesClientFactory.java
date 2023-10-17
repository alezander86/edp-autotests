package edp.core.service.kubernetes;

import com.fasterxml.jackson.core.JsonProcessingException;
import edp.core.config.TestsConfig;
import edp.core.model.autotestintegration.Cluster;
import io.fabric8.kubernetes.api.model.DeletionPropagation;
import io.fabric8.kubernetes.api.model.Pod;
import io.fabric8.kubernetes.api.model.Secret;
import io.fabric8.kubernetes.api.model.networking.v1.Ingress;
import io.fabric8.kubernetes.client.*;
import io.fabric8.kubernetes.client.dsl.Resource;
import lombok.Getter;
import lombok.extern.log4j.Log4j;
import org.awaitility.core.ConditionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;
import java.util.function.UnaryOperator;
import java.util.stream.Collectors;

import static edp.utils.wait.WaitingUtils.pollingCrUpdate;
import static edp.utils.wait.WaitingUtils.pollingCrCreation;

@Getter
@Log4j
@Service
public class KubernetesClientFactory {

    private DefaultKubernetesClient sourceClient;
    private DefaultKubernetesClient targetClient;

    @Autowired
    private SecretsProvider secretsProvider;
    @Autowired
    private TestsConfig testsConfig;

    @PostConstruct
    public void init() throws JsonProcessingException {
        log.info("init kubernetes client by agents' sa");
        sourceClient = new DefaultKubernetesClient();
        targetClient = initKubernetesClient();
    }

    private DefaultKubernetesClient initKubernetesClient() throws JsonProcessingException {
        Secret secret = secretsProvider.getSecret(testsConfig.getSecretName());
        Cluster cluster = Cluster.getCluster(secret, testsConfig.getCluster());

        log.info(String.format("init kubernetes client for {%s} server", cluster.getServer()));
        Config kubeConfig = new ConfigBuilder()
                .withMasterUrl(cluster.getServer())
                .withTrustCerts(true)
                .withOauthToken(cluster.getBearerToken().replaceAll("(\\r|\\n)", ""))
                .withNamespace(testsConfig.getNamespace())
                .build();
        return new DefaultKubernetesClient(kubeConfig);
    }

    public <T extends CustomResource> void createCustomResource(Class<T> resourceType, T resource) {
        String name = resource.getMetadata().getName();
        log.info(String.format("Creation %s %s", resourceType, name));
        log.info(resource.toString());
        targetClient.customResources(resourceType).create(resource);
        pollingCrCreation().until(() -> getCustomResource(resourceType, name).get() != null);
    }

    public <T extends CustomResource> void verifyCustomResource(Class<T> resourceType,
                                                                String name,
                                                                Predicate<T> condition) {
        verifyCustomResource(resourceType, name, condition, pollingCrUpdate());
    }

    public <T extends CustomResource> void verifyCustomResourceStartsWithName(Class<T> resourceType,
                                                                String name,
                                                                Predicate<T> condition) {
        verifyCustomResourceStartsWithName(resourceType, name, condition, pollingCrUpdate());
    }

    public <T extends CustomResource> void verifyCustomResource(Class<T> resourceType,
                                                                String name,
                                                                Predicate<T> condition,
                                                                ConditionFactory waiter) {
        log.info(String.format("Verification %s %s", resourceType.getName(), name));
        waiter.until(() -> getCustomResource(resourceType, name).get(), condition);
    }

    public <T extends CustomResource> void verifyCustomResourceStartsWithName(Class<T> resourceType,
                                                                String name,
                                                                Predicate<T> condition,
                                                                ConditionFactory waiter) {
        log.info(String.format("Verification %s %s", resourceType.getName(), name));
        waiter.until(() -> getCustomResourceStartsWithName(resourceType, name), condition);
    }

    public void deleteCustomResource(Class<? extends CustomResource> resourceType, String name) {
        log.info(String.format("Deleting %s %s", resourceType.getName(), name));
        targetClient.customResources(resourceType).withName(name).edit(clearFinalizers());
        getCustomResource(resourceType, name).withPropagationPolicy(DeletionPropagation.FOREGROUND).delete();
    }

    public void deleteCustomResources(Class<? extends CustomResource> resourceType) {
        try {
            getCustomResourcesList(resourceType).forEach(cr -> deleteCustomResource(resourceType, cr.getMetadata().getName()));
        } catch (KubernetesClientException e) {
            log.warn(e.getMessage());
        }
    }

    public <T extends CustomResource> void deleteCustomResources(Class<T> resourceType, Predicate<T> condition) {
        getCustomResourcesList(resourceType, condition).forEach(cr -> deleteCustomResource(resourceType, cr.getMetadata().getName()));
    }

    public <T extends CustomResource> List<T> getCustomResourcesList(Class<T> resourceType) {
        return targetClient.customResources(resourceType).list().getItems();
    }

    public <T extends CustomResource> List<T> getCustomResourcesList(Class<T> resourceType, Predicate<T> condition) {
        return targetClient.customResources(resourceType).list().getItems().stream().filter(condition).collect(Collectors.toList());
    }

    public <T extends CustomResource> List<T> getCustomResourcesList(Class<T> resourceType, Map<String, String> labels) {
        return targetClient.customResources(resourceType).withLabels(labels).list().getItems();
    }

    public <T extends CustomResource> Resource<T> getCustomResource(Class<T> resourceType, String name) {
        Resource<T> resource = targetClient.customResources(resourceType).withName(name);
        log.info("Getting " + resource.get());
        return resource;
    }

    public <T extends CustomResource> T getCustomResourceStartsWithName(Class<T> resourceType, String name) {
        T resource = targetClient.customResources(resourceType)
                .inNamespace(testsConfig.getNamespace())
                .list().getItems()
                .stream().filter(item -> item.getMetadata().getName().startsWith(name))
                .findFirst().get();
        log.info("Getting " + resource);
        return resource;
    }

    public List<Ingress> getIngressList() {
        return targetClient.network().v1().ingresses().inNamespace(testsConfig.getNamespace()).list().getItems();
    }

    public List<Pod> getPodListInNamespace(String namespace) {
        return targetClient.pods().inNamespace(namespace).list().getItems();
    }

    public <T extends CustomResource> boolean isCustomResourceWithNameExists(Class<T> resourceType, String crName) {
        return targetClient.customResources(resourceType).list().getItems()
                .stream().anyMatch(item -> item.getMetadata().getName().equals(crName));
    }

    private <T extends CustomResource> UnaryOperator<T> clearFinalizers() {
        return cr -> {
            cr.getMetadata().setFinalizers(null);
            return cr;
        };
    }
}
