package edp.stepdefs;

import edp.steps.HeadlampCDPipelinesPageSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;

public class HeadlampCDPipelinePageDefinitionSteps {

    @Autowired
    private HeadlampCDPipelinesPageSteps headlampCDPipelinesPageSteps;

    @And("User creates pipeline {word} with deployment type {word}")
    public void createApplication(String pipelineName, String deploymentType, DataTable table) {
        Map<String, String> pipelineData = new HashMap<>(table.asMap(String.class, String.class));
        pipelineData.put("pipelineName", pipelineName);
        pipelineData.put("deploymentType", deploymentType);
        headlampCDPipelinesPageSteps.createCDPipeline(pipelineData);
    }

    @When("User waits till {word} pipeline with {word} stage will be created")
    public void waitTillPipelineWillBeCreated(String pipelineName, String stageName) {
        headlampCDPipelinesPageSteps.waitAndCheckPipelineStatus(pipelineName, stageName);
    }

    @Then("User sees success status for {word} pipeline")
    public void checkUIPipelineStatus(String pipelineName) {
        headlampCDPipelinesPageSteps.checkStatus(pipelineName);
    }

    @When("User opens {word} pipeline")
    public void openPipeline(String pipelineName) {
        headlampCDPipelinesPageSteps.openPipeline(pipelineName);
    }

    @Then("User sees success status for {word} stage")
    public void checkUIStageStatus(String stageName) {
        headlampCDPipelinesPageSteps.checkStageStatus(stageName);
    }

    @When("User opens {word} stage")
    public void openStage(String stageName) {
        headlampCDPipelinesPageSteps.openStage(stageName);
    }

    @When("User deploys {word} application with saved image version")
    public void deployApplication(String applicationName) {
        headlampCDPipelinesPageSteps.deployApplication(applicationName);
    }

    @When("User waits till {word} application will be deployed with success status")
    public void waitTillApplicationWillBeDeploy(String applicationName) {
        headlampCDPipelinesPageSteps.waitTillApplicationWillBeDeploy(applicationName);
        headlampCDPipelinesPageSteps.checkApplicationHealsStatusOnUI(applicationName);
        headlampCDPipelinesPageSteps.checkApplicationSynkStatusOnUI(applicationName);
    }

    @And("User uninstalls {word} application")
    public void uninstallApplication(String applicationName) {
        headlampCDPipelinesPageSteps.uninstallApplication(applicationName);
    }

    @And("User deletes {word} cd pipeline")
    public void deletePipelineWithName(String pipelineName) {
        headlampCDPipelinesPageSteps.deletePipeline(pipelineName);
    }
    @When("User promotes application using autotests")
    public void promoteApplication() {
        headlampCDPipelinesPageSteps.promoteApplicationUsingQG();
    }

    @And("User checks that promoted image available in image stream version popup for {word} application")
    public void checkPromotedImageOnTheScreen(String applicationName) {
        headlampCDPipelinesPageSteps.checkPromotedImage(applicationName);
    }

    @When("User edits {word} CD pipeline with parameters")
    public void editCDPipelineWithParameters(String pipelineName, DataTable table) {
        Map<String, String> pipelineEditData = new HashMap<>(table.asMap(String.class, String.class));
        pipelineEditData.put("pipelineName", pipelineName);
        headlampCDPipelinesPageSteps.editCDPipelineWithParameters(pipelineEditData);
    }

    @Then("User sees added applications in the applications field on environments screen")
    public void checkIsAddedApplicationIsDisplayedInApplicationField(DataTable table) {
        Map<String, String> applications = new HashMap<>(table.asMap(String.class, String.class));
        headlampCDPipelinesPageSteps.checkIsAddedApplicationIsDisplayedInApplicationField(applications);
    }

    @When("User click on the Edit button for the selected pipeline")
    public void clickOnTheEditButtonForTheSelectedPipeline() {
        headlampCDPipelinesPageSteps.clickOnTheEditButtonForTheSelectedPipeline();
    }

    @Then("User checks entered data on the edit pipeline popup")
    public void checkDataOnTheEditPipelinePopup(DataTable table) {
        Map<String, String> pipelineEditData = new HashMap<>(table.asMap(String.class, String.class));
        headlampCDPipelinesPageSteps.checkDataOnTheEditPipelinePopup(pipelineEditData);
    }

    @Then("User sees that {word} trigger type is displayed for {word} stage")
    public void checkTriggerTypeForStageByName(String triggerType, String stageName) {
        headlampCDPipelinesPageSteps.checkTriggerTypeForStageByName(triggerType, stageName);
    }

    @When("User edits {word} stage in {word} pipeline with parameters")
    public void editStageWithParameters(String stageName, String pipelineName, DataTable table) {
        Map<String, String> stageEditData = new HashMap<>(table.asMap(String.class, String.class));
        stageEditData.put("stageName", stageName);
        stageEditData.put("pipelineName", pipelineName);
        headlampCDPipelinesPageSteps.editStageWithParameters(stageEditData);
    }

    @When("User click on the Edit button for the selected stage")
    public void clickOnTheEditButtonForTheSelectedStage() {
        headlampCDPipelinesPageSteps.clickOnTheEditButtonForTheSelectedStage();
    }

    @Then("User checks entered data on the edit stage popup")
    public void checkDataOnTheEditStagePopup(DataTable table) {
        Map<String, String> stageEditData = new HashMap<>(table.asMap(String.class, String.class));
        headlampCDPipelinesPageSteps.checkDataOnTheEditStagePopup(stageEditData);
    }

    @Then("User sees added applications on the selected stage screen")
    public void checkAddedApplicationOnTheStageScreen(DataTable table) {
        Map<String, String> applications = new HashMap<>(table.asMap(String.class, String.class));
        headlampCDPipelinesPageSteps.checkAddedApplicationOnTheStageScreen(applications);
    }

    @Then("User checks logs and terminal popups for {word} application {word} pipeline {word} stage")
    public void checkLogsAndTerminalPopups(String applicationName, String pipelineName, String stageName) {
        headlampCDPipelinesPageSteps.checkLogsAndTerminalPopups(applicationName, pipelineName, stageName);
    }
}
