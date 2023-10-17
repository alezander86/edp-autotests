package edp.steps;

import static io.vavr.API.$;
import static io.vavr.API.Case;
import static io.vavr.API.Match;

import edp.core.config.EdpComponentsConfig;
import edp.core.config.TestsConfig;
import edp.core.crd.argocd.application.Application;
import edp.core.crd.argocd.application.ApplicationSpec;
import edp.core.crd.codebase.gitserver.GitServer;
import edp.core.crd.tekton.task_run.TaskRun;
import edp.core.crd.tekton.task_run.TaskRunSpec;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import java.util.Arrays;
import java.util.Map;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class ApplicationSteps {

    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private TestsConfig testsConfig;
    private static final String REPO_URL_GERRIT = "ssh://argocd@%s.%s:%s/%s";
    private static final String REPO_URL_GITHUB = "ssh://git@%s.com:%s/edp-robot/%s-%s";
    private static final String REPO_URL_GITLAB = "ssh://git@git.epam.com:%s/epmd-edp/temp/repos-for-autotests/fork/%s";
    private static final String IMAGE_REPOSITORY = "registry.eks-sandbox.aws.main.edp.projects.epam.com/%s/%s";

    public void createApplication(Map<String, String> applicationParameters) {
        createApplication(getApplicationFromMap(applicationParameters));
    }

    private Application getApplicationFromMap(Map<String, String> applicationData) {
        ApplicationSpec spec = new ApplicationSpec();
        String destinationNamespaceName = edpComponentsConfig.getNamespace()
                .concat("-").concat(applicationData.get("pipelineNane"))
                .concat("-").concat(applicationData.get("stageName"));
        spec.setDestination(destinationNamespaceName, "in-cluster");
        spec.setProject(edpComponentsConfig.getNamespace());
        String imageRepository = String.format(IMAGE_REPOSITORY, edpComponentsConfig.getNamespace(),
                applicationData.get("applicationName"));
        String imageVersion =
                applicationData.get("versioningType").equals("edp") ? applicationData.get("imageVersion") :
                        getBuildVersion(applicationData.get("applicationName"));
        String targetRevision =
                applicationData.get("versioningType").equals("edp") ? "build/" + imageVersion : imageVersion;
        spec.setSource("deploy-templates", getRepoURLDependsOnGitServer(applicationData.get("applicationName")),
                targetRevision, applicationData.get("applicationName"), imageVersion, imageRepository);
        spec.setSyncPolicy(true, true);

        ObjectMeta metadata = new ObjectMeta();
        metadata.setName(applicationData.get("applicationName"));
        metadata.setNamespace(edpComponentsConfig.getNamespace());

        return new Application(spec, metadata);
    }

    private void createApplication(Application application) {
        factory.createCustomResource(Application.class, application);
        factory.verifyCustomResource(Application.class, application.getMetadata().getName(),
                app -> app.isSynced() && app.isHealthy());
    }

    private String getBuildVersion(String applicationName) {
        TaskRunSpec taskRunSpec = factory.getTargetClient().customResources(TaskRun.class)
                .inNamespace(edpComponentsConfig.getNamespace())
                .list().getItems()
                .stream().filter(item -> item.getMetadata().getName().endsWith("update-cbis") &&
                        item.getMetadata().getName().startsWith(applicationName))
                .findFirst().get().getSpec();
        return (String) Arrays.stream(taskRunSpec.getParams())
                .filter(p -> p.getName().equals("IMAGE_TAG"))
                .findFirst().get().getValue();
    }

    private String getPort() {
        return String.valueOf(factory.getTargetClient().customResources(GitServer.class)
                .inNamespace(edpComponentsConfig.getNamespace()).list().getItems()
                .stream().filter(item -> item.getMetadata().getName().equals(testsConfig.getGitProvider()))
                .findFirst().get().getSpec().getSshPort());
    }

    private String getRepoURLDependsOnGitServer(String applicationName) {
        return Match(testsConfig.getGitProvider()).of(
                Case($("gerrit"), String.format(REPO_URL_GERRIT, testsConfig.getGitProvider(),
                        edpComponentsConfig.getNamespace(), getPort(), applicationName)),
                Case($("github"), String.format(REPO_URL_GITHUB, testsConfig.getGitProvider(), getPort(),
                        edpComponentsConfig.getNamespace(), applicationName)),
                Case($("gitlab"), String.format(REPO_URL_GITLAB, getPort(),
                        testsConfig.getProjectName(applicationName)))
        );
    }
}
