package edp.steps;

import static edp.utils.consts.Constants.ICON_RED_SQUARE_BASE64;
import static edp.utils.strings.StringsHelper.getRandomStringWithLength;

import edp.core.cache.TestCache;
import edp.core.crd.EDPComponent;
import edp.core.crd.codebase.codebase.Codebase;
import edp.core.crd.codebase.gitserver.GitServer;
import edp.core.crd.external_secrets.ExternalSecret;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.pageobject.pages.HeadlampConfigurationPage;
import io.fabric8.kubernetes.api.model.Secret;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class HeadlampConfigurationPageSteps {

    @Autowired
    private HeadlampConfigurationPage headlampConfigurationPage;
    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private SecretsSteps secretsSteps;

    private static final String CREATE_SERVICE_ACCOUNT = "Create service account";
    private static final String CREATE_GIT_SERVER = "Create Git Server";
    private static final String ADD_GITOPS_REPOSITORY = "Add GitOps Repository";
    private static final String ADD_CLUSTER = "Add Cluster";
    private static final String CREATE_COMPONENT = "Create Component";
    private static final String NO_SECRET_FOUND = "No %s secrets found";
    private static final String NO_INTEGRATION_SECRET_FOUND = "No %s integration secrets found";
    private static final String NO_CUSTOM_VALUE_FOUND = "No Custom Values found";
    private static final String NO_GIT_SERVERS_FOUND = "No Git Servers found";
    private static final String NO_COMPONENTS_FOUND = "No Components found";
    private static final String NO_ECR_SERVICE_ACCOUNT_FOUND = "No ECR Service Accounts found";
    private static final String GIT_SERVERS = "Git Servers";
    private static final String CLUSTERS = "Clusters";
    private static final String CLUSTER = "Cluster";
    private static final String REGISTRY = "Registry";
    private static final String GITOPS = "GitOps";
    private static final String LINKS = "Links";
    private static final String REGISTRY_READ_WRIGHT_SECRET = "kaniko-docker-config";
    private static final String REGISTRY_READ_ONLY_SECRET = "regcred";
    private static final String READ_WRIGHT = "kaniko-docker-config (Read / Write)";
    private static final String READ_ONLY = "regcred (Read Only)";

    public void checkGitServersConfiguration() {
        headlampConfigurationPage.userClickOnTConfigurationButtonByName(GIT_SERVERS);
        headlampConfigurationPage.userSeesConfigurationScreenLabelBaseOnType(GIT_SERVERS);
        List<GitServer> listGitServers = factory.getCustomResourcesList(GitServer.class);
        if (listGitServers.size() > 0) {
            for (GitServer gitServer : listGitServers) {
                headlampConfigurationPage.isCreateServiceAccountNotEditable(CREATE_GIT_SERVER);
                headlampConfigurationPage.isGitServerWithNameDisplayed(gitServer.getMetadata().getName());
                headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(gitServer.getMetadata().getName());
            }
        } else {
            headlampConfigurationPage.isCreateServiceAccountEditable(CREATE_GIT_SERVER);
            headlampConfigurationPage.noIntegrationSecretFoundMessageIsDisplayed(NO_GIT_SERVERS_FOUND);
        }
        log.info(GIT_SERVERS + " configuration has been checked.");
    }

    public void checkClustersConfiguration() {
        Map<String, String> labels = new HashMap<>();
        labels.put("argocd.argoproj.io/secret-type", "cluster");
        headlampConfigurationPage.userClickOnTConfigurationButtonByName(CLUSTERS);
        headlampConfigurationPage.userSeesConfigurationScreenLabelBaseOnType(CLUSTERS);
        headlampConfigurationPage.isCreateServiceAccountEditable(ADD_CLUSTER);
        List<Secret> listSecrets = secretsSteps.getSecretsWithLabel(labels);
        if (listSecrets.size() > 0) {
            for (Secret secret : listSecrets) {
                headlampConfigurationPage.isSecretWithNameDisplayed(secret.getMetadata().getName());
                headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(secret.getMetadata().getName());
            }
        } else {
            headlampConfigurationPage.noIntegrationSecretFoundMessageIsDisplayed(
                    String.format(NO_SECRET_FOUND, CLUSTER));
        }
        log.info(CLUSTERS + " configuration has been checked.");
    }

    public void checkRegistryConfiguration() {
        headlampConfigurationPage.userClickOnTConfigurationButtonByName(REGISTRY);
        headlampConfigurationPage.userSeesConfigurationScreenLabelBaseOnType(REGISTRY);
        headlampConfigurationPage.userClickOnECRButtonInRegistryTab();
        boolean isTektonServiceAccountExists = factory.getTargetClient().serviceAccounts().list().getItems()
                .stream().anyMatch(e -> e.getMetadata().getName().equals("tekton"));
        if(isTektonServiceAccountExists) {
            headlampConfigurationPage.isSecretWithNameDisplayed("tekton");
        } else {
            headlampConfigurationPage.noIntegrationSecretFoundMessageIsDisplayed(NO_ECR_SERVICE_ACCOUNT_FOUND);
        }

        boolean isExternalSecretExistsForRegistryReadWrite =
                factory.isCustomResourceWithNameExists(ExternalSecret.class, REGISTRY_READ_WRIGHT_SECRET);
        boolean isExternalSecretExistsForRegistryReadOnly =
                factory.isCustomResourceWithNameExists(ExternalSecret.class, REGISTRY_READ_ONLY_SECRET);
        boolean isCustomSecretExistsForRegistryReadWrite =
                secretsSteps.isSecretWithNameExists(REGISTRY_READ_WRIGHT_SECRET);
        boolean isCustomSecretExistsForRegistryReadOnly =
                secretsSteps.isSecretWithNameExists(REGISTRY_READ_ONLY_SECRET);
        headlampConfigurationPage.userClickOnHarborButtonInRegistryTab();
        if (isExternalSecretExistsForRegistryReadWrite
                && isExternalSecretExistsForRegistryReadOnly) { // Both external secret
            headlampConfigurationPage.isCreateServiceAccountNotEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_ONLY);
            headlampConfigurationPage.isManageByExternalSecretIconDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isManageByExternalSecretIconDisplayed(READ_ONLY);
        } else if (isExternalSecretExistsForRegistryReadWrite && !isExternalSecretExistsForRegistryReadOnly
                && isCustomSecretExistsForRegistryReadOnly) { // Read/Wright external, Read only custom
            headlampConfigurationPage.isCreateServiceAccountNotEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_ONLY);
            headlampConfigurationPage.isManageByExternalSecretIconDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_ONLY);
        } else if (isExternalSecretExistsForRegistryReadWrite && !isExternalSecretExistsForRegistryReadOnly
                && !isCustomSecretExistsForRegistryReadOnly) { // Read/Wright external, without Read only
            headlampConfigurationPage.isCreateServiceAccountEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isSecretWithNameNotDisplayed(READ_ONLY);
            headlampConfigurationPage.isManageByExternalSecretIconDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_ONLY);
        } else if (!isExternalSecretExistsForRegistryReadWrite && isExternalSecretExistsForRegistryReadOnly
                && isCustomSecretExistsForRegistryReadWrite) { // Read/Wright custom, Read only external
            headlampConfigurationPage.isCreateServiceAccountNotEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_ONLY);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isManageByExternalSecretIconDisplayed(READ_ONLY);
        } else if (!isExternalSecretExistsForRegistryReadWrite && !isExternalSecretExistsForRegistryReadOnly
                && isCustomSecretExistsForRegistryReadWrite && isCustomSecretExistsForRegistryReadOnly) { // Read/Wright custom, Read only custom
            headlampConfigurationPage.isCreateServiceAccountNotEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_ONLY);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_ONLY);
        } else if (!isExternalSecretExistsForRegistryReadWrite && !isExternalSecretExistsForRegistryReadOnly
                && isCustomSecretExistsForRegistryReadWrite && !isCustomSecretExistsForRegistryReadOnly) { // Read/Wright custom, without Read only
            headlampConfigurationPage.isCreateServiceAccountEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isSecretWithNameNotDisplayed(READ_ONLY);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_ONLY);
        } else if (!isExternalSecretExistsForRegistryReadWrite && isExternalSecretExistsForRegistryReadOnly
                && !isCustomSecretExistsForRegistryReadWrite && !isCustomSecretExistsForRegistryReadOnly) { // Without Read/Wright , Read only external
            headlampConfigurationPage.isCreateServiceAccountEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameNotDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_ONLY);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isManageByExternalSecretIconDisplayed(READ_ONLY);
        } else if (!isExternalSecretExistsForRegistryReadWrite && !isExternalSecretExistsForRegistryReadOnly
                && !isCustomSecretExistsForRegistryReadWrite && isCustomSecretExistsForRegistryReadOnly) { // Without Read/Wright , Read only custom
            headlampConfigurationPage.isCreateServiceAccountEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameNotDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isSecretWithNameDisplayed(READ_ONLY);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_WRIGHT);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(READ_ONLY);
        } else { // Without both
            headlampConfigurationPage.isCreateServiceAccountEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.noIntegrationSecretFoundMessageIsDisplayed(
                    String.format(NO_SECRET_FOUND, REGISTRY));
        }
        log.info(REGISTRY + " configuration has been checked.");
    }

    public void checkServiceAccountSecret(String typeName, String secretName) {
        headlampConfigurationPage.userClickOnTConfigurationButtonByName(typeName);
        headlampConfigurationPage.userSeesConfigurationScreenLabelBaseOnType(typeName);
        if (factory.isCustomResourceWithNameExists(ExternalSecret.class, secretName)) {
            headlampConfigurationPage.isCreateServiceAccountNotEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameDisplayed(secretName);
            headlampConfigurationPage.isManageByExternalSecretIconDisplayed(secretName);
        } else if (secretsSteps.isSecretWithNameExists(secretName)) {
            headlampConfigurationPage.isCreateServiceAccountNotEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.isSecretWithNameDisplayed(secretName);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(secretName);
        } else {
            headlampConfigurationPage.isCreateServiceAccountEditable(CREATE_SERVICE_ACCOUNT);
            headlampConfigurationPage.noIntegrationSecretFoundMessageIsDisplayed(
                    String.format(NO_INTEGRATION_SECRET_FOUND, typeName));
        }
        log.info(typeName + " configuration has been checked with " + secretName + " secret.");
    }

    public void checkGitOpsConfiguration() {
        headlampConfigurationPage.userClickOnTConfigurationButtonByName(GITOPS);
        headlampConfigurationPage.userSeesConfigurationScreenLabelBaseOnType(GITOPS);

        Map<String, String> labels = new HashMap<>();
        labels.put("app.edp.epam.com/codebaseType", "system");
        labels.put("app.edp.epam.com/systemType", "gitops");
        List<Codebase> list = factory.getCustomResourcesList(Codebase.class, labels);

        if (!list.isEmpty()) {
            headlampConfigurationPage.isCreateServiceAccountNotEditable(ADD_GITOPS_REPOSITORY);
            headlampConfigurationPage.isGitOpsWithNameDisplayed(GITOPS);
            headlampConfigurationPage.isManageByExternalSecretIconNotDisplayed(GITOPS);
            log.info(GITOPS + " configuration has been checked with " + list.get(0).getMetadata().getName()
                    + " codebase.");
        } else {
            headlampConfigurationPage.isCreateServiceAccountEditable(ADD_GITOPS_REPOSITORY);
            headlampConfigurationPage.noIntegrationSecretFoundMessageIsDisplayed(NO_CUSTOM_VALUE_FOUND);
            log.info(GITOPS + " configuration tab has been checked without setting the system codebase.");
        }
    }

    public void checkLinksConfiguration() {
        headlampConfigurationPage.userClickOnTConfigurationButtonByName(LINKS);
        headlampConfigurationPage.userSeesConfigurationScreenLabelBaseOnType(LINKS);
        headlampConfigurationPage.isCreateServiceAccountEditable(CREATE_COMPONENT);
        List<EDPComponent> edpComponentList = factory.getCustomResourcesList(EDPComponent.class);
        if (edpComponentList.size() > 0) {
            for (EDPComponent edpComponent : edpComponentList) {
                headlampConfigurationPage.isLinkWithNameDisplayed(edpComponent.getMetadata().getName());
            }
        } else {
            headlampConfigurationPage.noIntegrationSecretFoundMessageIsDisplayed(NO_COMPONENTS_FOUND);
        }
        log.info(LINKS + " configuration has been checked.");
    }

    public void addNewLinkOnConfigurationScreen() {
        String randomName = getRandomStringWithLength(10).toLowerCase();
        TestCache.putDataInCache(TestCacheKey.LINK_NAME, randomName);
        TestCache.putDataInCache(TestCacheKey.LINK_URL, randomName.concat(".com"));
        headlampConfigurationPage.userClickOnTConfigurationButtonByName(LINKS);
        headlampConfigurationPage.userSeesConfigurationScreenLabelBaseOnType(LINKS);
        headlampConfigurationPage.userClickOnCreateButtonByName(CREATE_COMPONENT);
        headlampConfigurationPage.enterLinkName(randomName);
        headlampConfigurationPage.enterLinkUrl(randomName.concat(".com"));
        headlampConfigurationPage.enterLinkIcon(ICON_RED_SQUARE_BASE64);
        headlampConfigurationPage.userClickOnSaveLinkButton();
    }

}
