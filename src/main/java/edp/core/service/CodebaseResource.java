package edp.core.service;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import edp.core.config.EdpComponentsConfig;
import edp.core.crd.*;
import edp.core.crd.codebase.codebase_branch.CodebaseBranch;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.fabric8.kubernetes.api.model.KubernetesResourceList;
import io.fabric8.kubernetes.client.KubernetesClient;
import io.fabric8.kubernetes.client.dsl.MixedOperation;
import io.fabric8.kubernetes.client.dsl.Resource;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Assertions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

import static edp.utils.wait.WaitingUtils.pollingBranch;
import static edp.utils.wait.WaitingUtils.pollingCustomResource;

@Log4j
@Service
@JsonIgnoreProperties(ignoreUnknown = true)
public class CodebaseResource {

    @Autowired
    private EdpComponentsConfig edpComponentsConfig;

    @Autowired
    private KubernetesClientFactory factory;
    @Setter
    private int BRANCH_BUILD_STATUS_WAIT = 4;

    public void checkBranchBuildStatus(String codebaseBranchName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        kubernetesClient.customResources(CodebaseBranch.class).inNamespace(edpComponentsConfig.getNamespace()).withName(codebaseBranchName)
                .waitUntilCondition(codebaseBranch -> codebaseBranch.getStatus().getBuild().equals("1"), BRANCH_BUILD_STATUS_WAIT, TimeUnit.MINUTES);
        log.info("Codebase branch " + codebaseBranchName + " build status updated to '1'");
    }

    public void checkBranchLastSuccessfulBuildStatus(String codebaseBranchName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        MixedOperation<CodebaseBranch, KubernetesResourceList<CodebaseBranch>, Resource<CodebaseBranch>>
                codebaseBranchClient = kubernetesClient.customResources(CodebaseBranch.class);

        pollingBranch()
                .ignoreExceptionsInstanceOf(NullPointerException.class)
                .untilAsserted(() -> {

                    CodebaseBranch branch = codebaseBranchClient.inNamespace(edpComponentsConfig.getNamespace()).withName(codebaseBranchName).get();

                    Assertions.assertNotNull(branch.getStatus().getLastSuccessfulBuild());

                });

        kubernetesClient.customResources(CodebaseBranch.class).inNamespace(edpComponentsConfig.getNamespace()).withName(codebaseBranchName)
                .waitUntilCondition(codebaseBranch -> codebaseBranch.getStatus().getLastSuccessfulBuild().equals("1"), 2, TimeUnit.MINUTES);
        log.info("Codebase branch " + codebaseBranchName + " last successful build status updated to '1'");
    }

    public void userChecksAdminConsoleCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList adminConsoles = kubernetesClient.customResources(AdminConsole.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(adminConsoles.getItems().stream().anyMatch(item -> StringUtils.equals(((AdminConsole) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for admin console resource to be available: %s", crName));
                    log.info("Admin Console resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(AdminConsole.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(adminConsole -> adminConsole.getStatus().getStatus().equals("ready"), 15, TimeUnit.MINUTES);
        log.info("Admin Console resource " + crName + " has status 'ready'");


    }

    public void userChecksSonarCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList sonars = kubernetesClient.customResources(Sonar.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(sonars.getItems().stream().anyMatch(item -> StringUtils.equals(((Sonar) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for sonar resource to be available: %s", crName));
                    log.info("Sonar resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(Sonar.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(sonar -> sonar.getStatus().getStatus().equals("ready"), 15, TimeUnit.MINUTES);
        log.info("Sonar resource " + crName + " has status 'ready'");
    }

    public void userChecksNexusCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList nexuses = kubernetesClient.customResources(Nexus.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(nexuses.getItems().stream().anyMatch(item -> StringUtils.equals(((Nexus) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for nexus resource to be available: %s", crName));
                    log.info("Nexus resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(Nexus.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(nexus -> nexus.getStatus().getStatus().equals("ready"), 15, TimeUnit.MINUTES);
        log.info("Nexus resource " + crName + " has status 'ready'");
    }

    public void userChecksGerritCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList gerrits = kubernetesClient.customResources(Gerrit.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(gerrits.getItems().stream().anyMatch(item -> StringUtils.equals(((Gerrit) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for gerrit resource to be available: %s", crName));
                    log.info("Gerit resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(Gerrit.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(gerrit -> gerrit.getStatus().getStatus().equals("ready"), 15, TimeUnit.MINUTES);
        log.info("Gerrit resource " + crName + " has status 'ready'");
    }

    public void userChecksJenkinsCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList jenkinses = kubernetesClient.customResources(Jenkins.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(jenkinses.getItems().stream().anyMatch(item -> StringUtils.equals(((Jenkins) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for jenkins resource to be available: %s", crName));
                    log.info("Jenkins resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(Jenkins.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(jenkins -> jenkins.getStatus().getStatus().equals("ready"), 15, TimeUnit.MINUTES);
        log.info("Jenkins resource " + crName + " has status 'ready'");
    }

    public void userChecksKeycloakClientCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList keycloakClients = kubernetesClient.customResources(KeycloakClient.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(keycloakClients.getItems().stream().anyMatch(item -> StringUtils.equals(((KeycloakClient) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for Keycloak client resource to be available: %s", crName));
                    log.info("Keycloak client resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(KeycloakClient.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(keycloakClient -> keycloakClient.getStatus().getValue().equals("OK"), 15, TimeUnit.MINUTES);
        log.info("Keycloak client resource " + crName + " has status 'OK'");
    }

    public void userChecksKeycloakRealmRoleBatchCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList keycloakRealmRoleBatches = kubernetesClient.customResources(KeycloakRealmRoleBatch.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(keycloakRealmRoleBatches.getItems().stream().anyMatch(item -> StringUtils.equals(((KeycloakRealmRoleBatch) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for KeycloakRealmRoleBatch resource to be available: %s", crName));
                    log.info("KeycloakRealmRoleBatch resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(KeycloakRealmRoleBatch.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(keycloakRealmRoleBatch -> keycloakRealmRoleBatch.getStatus().getValue().equals("OK"), 15, TimeUnit.MINUTES);
        log.info("KeycloakRealmRoleBatch resource " + crName + " has status 'OK'");
    }

    public void userChecksKeycloakRealmRoleCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList keycloakRealmRoles = kubernetesClient.customResources(KeycloakRealmRole.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(keycloakRealmRoles.getItems().stream().anyMatch(item -> StringUtils.equals(((KeycloakRealmRole) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for KeycloakRealmRole resource to be available: %s", crName));
                    log.info("KeycloakRealmRole resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(KeycloakRealmRole.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(keycloakRealmRole -> keycloakRealmRole.getStatus().getValue().equals("OK"), 15, TimeUnit.MINUTES);
        log.info("KeycloakRealmRole resource " + crName + " has status 'OK'");
    }

    public void userChecksKeycloakRealmCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList keycloakRealms = kubernetesClient.customResources(KeycloakRealm.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(keycloakRealms.getItems().stream().anyMatch(item -> StringUtils.equals(((KeycloakRealm) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for KeycloakRealm resource to be available: %s", crName));
                    log.info("KeycloakRealm resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(KeycloakRealm.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(keycloakRealm -> keycloakRealm.getStatus().getValue().equals("OK"), 15, TimeUnit.MINUTES);
        log.info("KeycloakRealm resource " + crName + " has status 'OK'");
    }

    public void userChecksKeycloakCrStatus(String crName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        pollingCustomResource()
                .untilAsserted(() -> {
                    KubernetesResourceList keycloaks = kubernetesClient.customResources(Keycloak.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .list();

                    Assertions.assertTrue(keycloaks.getItems().stream().anyMatch(item -> StringUtils.equals(((Keycloak) item)
                            .getMetadata()
                            .getName(), crName)), String.format("Waiting for Keycloak resource to be available: %s", crName));
                    log.info("Keycloak resource " + crName + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                });

        kubernetesClient.customResources(Keycloak.class).inNamespace(edpComponentsConfig.getNamespace()).withName(crName)
                .waitUntilCondition(keycloak -> keycloak.getStatus().getConnected().equals(true), 15, TimeUnit.MINUTES);
        log.info("Keycloak resource " + crName + " has status 'OK'");
    }
}
