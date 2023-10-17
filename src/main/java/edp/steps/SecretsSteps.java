package edp.steps;

import edp.core.config.*;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.fabric8.kubernetes.api.model.Secret;
import io.fabric8.kubernetes.api.model.SecretBuilder;
import io.fabric8.kubernetes.api.model.SecretList;
import io.fabric8.kubernetes.client.KubernetesClient;
import java.util.List;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Assertions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;

import static edp.utils.strings.StringsHelper.decode;
import static edp.utils.strings.StringsHelper.encode;
import static edp.utils.wait.WaitingUtils.pollingCustomResource;

@Log4j
@Service
public class SecretsSteps {
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private GitlabProviderConfig gitlabProviderConfig;
    @Autowired
    private GithubProviderConfig githubProviderConfig;
    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private SecretDataProviderConfig secretDataProviderConfig;

    public void createGithubSshSecretWithFollowingValues(final String secretName) {
        Secret secret = new SecretBuilder()
                .withNewMetadata().withName(secretName).endMetadata()
                .addToData("id_rsa", encode(githubProviderConfig.getIdRsa()))
                .addToData("username", encode(githubProviderConfig.getUsername()))
                .build();
        createSecret(secretName, secret);
    }

    public void createGitlabSshSecretWithFollowingValues(String secretName) {
        Secret secret = new SecretBuilder()
                .withNewMetadata().withName(secretName).endMetadata()
                .addToData("id_rsa", encode(gitlabProviderConfig.getIdRsa()))
                .addToData("id_rsa.pub", encode(gitlabProviderConfig.getIdRsaPub()))
                .addToData("username", encode(gitlabProviderConfig.getUsername()))
                .build();
        createSecret(secretName, secret);
    }

    public void createGithubApiTokenSecret(String secretName) {
        Secret secret = new SecretBuilder()
                .withNewMetadata().withName(secretName).endMetadata()
                .addToData("secret", encode(githubProviderConfig.getToken()))
                .build();
        createSecret(secretName, secret);
    }

    public void createGitlabApiTokenSecret(String secretName) {
        Secret secret = new SecretBuilder()
                .withNewMetadata().withName(secretName).endMetadata()
                .addToData("secret", encode(gitlabProviderConfig.getToken()))
                .build();
        createSecret(secretName, secret);
    }

    public void createEpamJiraUserSecretWithFollowingValues(String secretName) {
        Secret secret = new SecretBuilder()
                .withNewMetadata().withName(secretName).endMetadata()
                //TODO fix approach with jira credentials
                //                .addToData("password", repositoryPathsConfig.getJiraPassword())
                //                .addToData("username", repositoryPathsConfig.getJiraUserName())
                .build();
        createSecret(secretName, secret);
    }

    public void updateSecretData(String secretName) {
        KubernetesClient kubernetesClient = factory.getTargetClient();
        Map<String, String> params = new LinkedHashMap<>();
        params.put("config.json", encode(secretDataProviderConfig.getKanikoDockerConfig()));
        kubernetesClient.secrets().inNamespace(edpComponentsConfig.getNamespace())
                .withName(secretName).edit(s -> new SecretBuilder(s).withData(params).build());
    }

    public void createGithubCloneSecretWithFollowingValues(final String secretName) {
        if(!isSecretWithNameExists(secretName)) {
            Secret secret = new SecretBuilder()
                    .withNewMetadata().withName(secretName).endMetadata()
                    .addToData("username", encode(githubProviderConfig.getUsername()))
                    .addToData("password", encode(githubProviderConfig.getToken()))
                    .build();
            createSecret(secretName, secret);
        }
    }

    public String getSecretFieldValue(String secretName, String fieldName) {
        return decode(factory.getTargetClient()
                .secrets()
                .withName(secretName)
                .get()
                .getData()
                .get(fieldName));
    }

    public String getHeadlampAdminTokenForOKDCluster() {
        return decode(factory.getTargetClient()
                .secrets()
                .inAnyNamespace()
                .list().getItems()
                .stream()
                .filter(s -> s.getMetadata().getName().startsWith("headlamp-admin-token-"))
                .findFirst().get()
                .getData()
                .get("token"));
    }

    public boolean isSecretWithNameExists(String secretName) {
        return factory.getTargetClient().secrets().inNamespace(edpComponentsConfig.getNamespace())
                .list().getItems().stream().anyMatch(s -> secretName.equals(s.getMetadata().getName()));
    }

    public List<Secret> getSecretsWithLabel(Map<String, String> labels) {
        return factory.getTargetClient().secrets().inNamespace(edpComponentsConfig.getNamespace())
                .withLabels(labels).list().getItems();
    }

    private void createSecret(String secretName, Secret secret) {
        KubernetesClient kubernetesClient = factory.getTargetClient();
        kubernetesClient.secrets().inNamespace(edpComponentsConfig.getNamespace()).create(secret);
        log.info(String.format("Secret %s added to %s namespace", secretName, edpComponentsConfig.getNamespace()));
        waitUntilSecretWillBeCreated(secretName);
    }

    private void waitUntilSecretWillBeCreated(String secretName) {
        pollingCustomResource()
                .untilAsserted(() -> {
                    SecretList secretList =
                            factory.getTargetClient().secrets().inNamespace(edpComponentsConfig.getNamespace()).list();
                    Assertions.assertTrue(secretList.getItems()
                                    .stream()
                                    .anyMatch(item -> StringUtils.equals(item.getMetadata().getName(), secretName)),
                            String.format("Waiting for seret to be available: %s", secretName));
                    log.info(String.format("Secret %s is available in %s namespace", secretName,
                            edpComponentsConfig.getNamespace()));
                });
    }
}
