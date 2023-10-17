package edp.steps;

import edp.core.annotations.Page;
import edp.core.config.EdpComponentsConfig;
import edp.core.crd.JiraServerSpec;
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
@Scope("prototype")
@Log4j
public class JiraServerSteps {

    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private KubernetesClientFactory factory;

    public void createJiraServerWithFollowingValues(DataTable table) {
        KubernetesClient kubernetesClient = factory.getTargetClient();
        List<Map<String, String>> listRows = table.asMaps();

        for (Map<String, String> row : listRows) {
            JiraServerSpec spec = new JiraServerSpec();
            spec.setApiUrl(row.get("apiUrl"));
            spec.setRootUrl(row.get("rootUrl"));
            spec.setCredentialName(row.get("credentialName"));

            ObjectMeta metadata = new ObjectMeta();
            metadata.setName(row.get("jiraServerName"));
            metadata.setNamespace(edpComponentsConfig.getNamespace());

            edp.core.crd.JiraServer jiraServer = new edp.core.crd.JiraServer();
            jiraServer.setMetadata(metadata);
            jiraServer.setSpec(spec);

            kubernetesClient.customResources(edp.core.crd.JiraServer.class)
                    .inNamespace(edpComponentsConfig.getNamespace()).create(jiraServer);
            log.info("Jira server " + metadata.getName() + " added to " + edpComponentsConfig.getNamespace()
                    + " namespace");

            pollingCustomResource()
                    .untilAsserted(() -> {
                        KubernetesResourceList jiraServer1 =
                                kubernetesClient.customResources(edp.core.crd.JiraServer.class)
                                        .inNamespace(edpComponentsConfig.getNamespace())
                                        .list();

                        Assertions.assertTrue(jiraServer1.getItems().stream()
                                        .anyMatch(item -> StringUtils.equals(((edp.core.crd.JiraServer) item)
                                                .getMetadata()
                                                .getName(), metadata.getName())),
                                String.format("Waiting for Jira server to be available: %s", metadata.getName()));
                        log.info("Jira server " + metadata.getName() + " is available in "
                                + edpComponentsConfig.getNamespace() + " namespace");
                    });
        }
    }

    public void checkJiraServerStatus(String jiraServerName) throws InterruptedException {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        kubernetesClient.customResources(edp.core.crd.JiraServer.class).inNamespace(edpComponentsConfig.getNamespace())
                .withName(jiraServerName)
                .waitUntilCondition(jiraServer -> jiraServer.getStatus().isAvailable(), 15, TimeUnit.MINUTES);
        log.info("Git server " + jiraServerName + " has status 'available'");
    }
}
