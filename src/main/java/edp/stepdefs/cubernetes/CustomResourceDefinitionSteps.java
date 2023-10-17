package edp.stepdefs.cubernetes;

import edp.core.crd.codebase.cdpipeline.CDPipeline;
import edp.core.crd.codebase.stage.Stage;
import edp.core.crd.codebase.codebase.Codebase;
import edp.core.crd.codebase.codebase_branch.CodebaseBranch;
import edp.core.crd.codebase.codebase_image_stream.CodebaseImageStream;
import edp.core.crd.GerritProject;
import edp.core.crd.jenkins_folder.JenkinsFolder;
import edp.core.crd.tekton.pipeline_run.PipelineRun;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.cucumber.java.en.Given;
import org.springframework.beans.factory.annotation.Autowired;

public class CustomResourceDefinitionSteps {
    @Autowired
    private KubernetesClientFactory factory;
    @Given("User deletes custom resources")
    public void deleteCustomResources() {
        factory.deleteCustomResources(GerritProject.class);
        factory.deleteCustomResources(PipelineRun.class);
        factory.deleteCustomResources(CodebaseBranch.class);
        factory.deleteCustomResources(Codebase.class);
        factory.deleteCustomResources(CodebaseImageStream.class);
        factory.deleteCustomResources(JenkinsFolder.class);
        factory.deleteCustomResources(Stage.class);
        factory.deleteCustomResources(CDPipeline.class);
    }
}
