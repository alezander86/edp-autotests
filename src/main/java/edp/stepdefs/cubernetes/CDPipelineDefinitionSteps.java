package edp.stepdefs.cubernetes;

import edp.core.crd.codebase.cdpipeline.CDPipeline;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.steps.CDPipelineSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;

public class CDPipelineDefinitionSteps {

    @Autowired
    private CDPipelineSteps cdPipelineSteps;

    @Autowired
    private KubernetesClientFactory factory;

    @And("User creates cd pipeline {word} with deployment type {word}")
    public void createCDPipeline(String pipelineName, String deploymentType, DataTable table) {
        Map<String, String> cdPipelineStage = new HashMap<>(table.asMap(String.class, String.class));
        cdPipelineStage.put("deploymentType", deploymentType);
        cdPipelineStage.put("applicationsToPromote", cdPipelineStage.get("applications"));
        cdPipelineStage.put("name", pipelineName);

        cdPipelineSteps.createCDPipeline(cdPipelineStage);
    }

    @When("User deletes {word} cd pipeline resources")
    public void deleteCDPipeline(String pipelineName) {
        factory.deleteCustomResource(CDPipeline.class, pipelineName);
    }
}
