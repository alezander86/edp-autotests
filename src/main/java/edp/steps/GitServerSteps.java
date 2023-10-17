package edp.steps;

import edp.core.annotations.Page;
import edp.core.config.EdpComponentsConfig;
import edp.core.crd.codebase.gitserver.GitServer;
import edp.core.crd.codebase.gitserver.GitServerSpec;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.cucumber.datatable.DataTable;
import io.fabric8.kubernetes.api.model.KubernetesResourceList;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.client.KubernetesClient;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Assertions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static edp.utils.wait.WaitingUtils.pollingCustomResource;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class GitServerSteps {

    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private KubernetesClientFactory factory;

    public void createGithubGitServerWithFollowingValues(DataTable table) {
        KubernetesClient kubernetesClient = factory.getTargetClient();
        List<Map<String, String>> listRows = table.asMaps();

        for (Map<String, String> row : listRows) {
            GitServerSpec spec = new GitServerSpec();
            spec.setCreateCodeReviewPipeline(false);
            spec.setGitHost(row.get("gitHost"));
            spec.setGitProvider("github");
            spec.setGitUser(row.get("gitUser"));
            spec.setHttpsPort(443);
            spec.setNameSshKeySecret(row.get("nameSshKeySecret"));
            spec.setSshPort(22);

            ObjectMeta metadata = new ObjectMeta();
            metadata.setName(row.get("gitServerName"));
            metadata.setNamespace(edpComponentsConfig.getNamespace());

            GitServer gitServer = new GitServer();
            gitServer.setKind("JenkinsServiceAccount");
            gitServer.setMetadata(metadata);
            gitServer.setSpec(spec);

            kubernetesClient.customResources(GitServer.class).inNamespace(edpComponentsConfig.getNamespace()).create(gitServer);
            log.info("Git server " + metadata.getName() + " added to " + edpComponentsConfig.getNamespace() + " namespace");

            pollingCustomResource()
                    .untilAsserted(() -> {
                        KubernetesResourceList gitServers = kubernetesClient.customResources(GitServer.class)
                                .inNamespace(edpComponentsConfig.getNamespace())
                                .list();

                        Assertions.assertTrue(gitServers.getItems().stream().anyMatch(item -> StringUtils.equals(((GitServer) item)
                                .getMetadata()
                                .getName(), metadata.getName())), String.format("Waiting for git server to be available: %s", metadata.getName()));
                        log.info("Git server " + metadata.getName() + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                    });
        }
    }

    public void checkGitServerStatus(String gitServerName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        kubernetesClient.customResources(GitServer.class).inNamespace(edpComponentsConfig.getNamespace()).withName(gitServerName)
                .waitUntilCondition(gitServer -> gitServer.getStatus().getValue().equals("active"), 15, TimeUnit.MINUTES);
        log.info("Git server " + gitServerName + " has status 'active'");
    }

    public void createGitlabGitServerWithFollowingValues(DataTable table) {
        KubernetesClient kubernetesClient = factory.getTargetClient();
        List<Map<String, String>> listRows = table.asMaps();

        for (Map<String, String> row : listRows) {
            GitServerSpec spec = new GitServerSpec();
//            spec.setCreateCodeReviewPipeline(false);
            spec.setGitHost(row.get("gitHost"));
            spec.setGitProvider("gitlab");
            spec.setGitUser(row.get("gitUser"));
            spec.setHttpsPort(443);
            spec.setNameSshKeySecret(row.get("nameSshKeySecret"));
            spec.setSshPort(22);

            ObjectMeta metadata = new ObjectMeta();
            metadata.setName(row.get("gitServerName"));
            metadata.setNamespace(edpComponentsConfig.getNamespace());

            GitServer gitServer = new GitServer();
            gitServer.setKind("JenkinsServiceAccount");
            gitServer.setMetadata(metadata);
            gitServer.setSpec(spec);

            kubernetesClient.customResources(GitServer.class).inNamespace(edpComponentsConfig.getNamespace()).create(gitServer);
            log.info("Git server " + metadata.getName() + " added to " + edpComponentsConfig.getNamespace() + " namespace");

            pollingCustomResource()
                    .untilAsserted(() -> {
                        KubernetesResourceList gitServers = kubernetesClient.customResources(GitServer.class)
                                .inNamespace(edpComponentsConfig.getNamespace())
                                .list();

                        Assertions.assertTrue(gitServers.getItems().stream().anyMatch(item -> StringUtils.equals(((GitServer) item)
                                .getMetadata()
                                .getName(), metadata.getName())), String.format("Waiting for git server to be available: %s", metadata.getName()));
                        log.info("Git server " + metadata.getName() + " is available in " + edpComponentsConfig.getNamespace() + " namespace");
                    });
        }
    }

}
