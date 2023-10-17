package edp.steps;

import edp.core.config.EdpComponentsConfig;
import edp.core.crd.JenkinsServiceAccount;
import edp.core.crd.JenkinsServiceAccountSpec;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.cucumber.datatable.DataTable;
import io.fabric8.kubernetes.api.model.KubernetesResourceList;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.client.KubernetesClient;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Assertions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static edp.utils.wait.WaitingUtils.pollingCustomResource;

@Log4j
@Service
public class JenkinsServiceAccountsSteps {
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private KubernetesClientFactory factory;

    public void createServiceAccount(final DataTable table) {
        KubernetesClient kubernetesClient = factory.getTargetClient();
        List<Map<String, String>> listRows = table.asMaps();

        for (Map<String, String> row : listRows) {
            JenkinsServiceAccountSpec spec = new JenkinsServiceAccountSpec();
            spec.setCredentials(row.get("credentialName"));
            spec.setType(row.get("credentialType"));
            spec.setOwnerName("");

            ObjectMeta metadata = new ObjectMeta();
            metadata.setName(row.get("credentialName"));
            metadata.setNamespace(edpComponentsConfig.getNamespace());

            JenkinsServiceAccount jenkinsServiceAccount = new JenkinsServiceAccount();
            jenkinsServiceAccount.setMetadata(metadata);
            jenkinsServiceAccount.setSpec(spec);

            kubernetesClient.customResources(JenkinsServiceAccount.class)
                    .inNamespace(edpComponentsConfig.getNamespace()).create(jenkinsServiceAccount);
            log.info("Jenkins service account " + metadata.getName() + " added to " + edpComponentsConfig.getNamespace()
                    + " namespace");

            pollingCustomResource()
                    .untilAsserted(() -> {
                        KubernetesResourceList serviceAccounts =
                                kubernetesClient.customResources(JenkinsServiceAccount.class)
                                        .inNamespace(edpComponentsConfig.getNamespace())
                                        .list();

                        Assertions.assertTrue(serviceAccounts.getItems().stream()
                                        .anyMatch(item -> StringUtils.equals(((JenkinsServiceAccount) item)
                                                .getMetadata()
                                                .getName(), metadata.getName())),
                                String.format("Waiting for service account to be available: %s", metadata.getName()));
                        log.info("Jenkins service account " + metadata.getName() + " is available in "
                                + edpComponentsConfig.getNamespace() + " namespace");
                    });
        }

    }

    public void checkJenkinsServiceAccountStatus(String credentialName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList serviceAccounts =
                            kubernetesClient.customResources(JenkinsServiceAccount.class)
                                    .inNamespace(edpComponentsConfig.getNamespace())
                                    .list();

                    Assertions.assertTrue(serviceAccounts.getItems().stream()
                                    .anyMatch(item -> StringUtils.equals(((JenkinsServiceAccount) item)
                                            .getMetadata()
                                            .getName(), credentialName)),
                            String.format("Waiting for service account to be available: %s", credentialName));
                    log.info("Jenkins service account " + credentialName + " is available in "
                            + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(JenkinsServiceAccount.class).inNamespace(edpComponentsConfig.getNamespace())
                .withName(credentialName)
                .waitUntilCondition(jenkinsServiceAccount -> jenkinsServiceAccount.getStatus().getAvailable(), 15,
                        TimeUnit.MINUTES);
        log.info("Jenkins service account " + credentialName + " has status 'available'");
    }
}
