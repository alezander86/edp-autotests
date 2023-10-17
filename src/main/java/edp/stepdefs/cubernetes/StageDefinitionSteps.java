package edp.stepdefs.cubernetes;

import edp.core.crd.codebase.stage.Stage;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.steps.StageSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;

public class StageDefinitionSteps {

    @Autowired
    private StageSteps stageSteps;
    @Autowired
    private KubernetesClientFactory factory;

    @And("User creates stage {word} in cd pipeline {word}")
    public void createStage(String stageName, String pipelineName, DataTable table) {
        Map<String, String> stage = new HashMap<>(table.asMap(String.class, String.class));
        stage.put("cdPipelineName", pipelineName);
        stage.put("stageName", stageName);
        stageSteps.createStage(stage);
    }

    @When("User deletes {word}-{word} cd pipeline stage resources")
    public void deleteStage(String pipeline, String stage) {
        String stageName = pipeline.concat("-").concat(stage);
        factory.deleteCustomResource(Stage.class, stageName);
    }

    @And("User checks {string} annotation in {string} cd stage")
    public void checkAnnotationInCdStage(final String annotation, final String cdPipelineStageName)
            throws InterruptedException {
        stageSteps.checkAnnotationInCdStage(annotation, cdPipelineStageName);
    }
}
