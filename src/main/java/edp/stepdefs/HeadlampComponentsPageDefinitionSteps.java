package edp.stepdefs;

import edp.core.enums.testdata.CodeLanguage;
import edp.core.enums.testdata.CodebaseLanguageUI;
import edp.steps.HeadlampComponentsPageSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;

public class HeadlampComponentsPageDefinitionSteps {

    @Autowired
    private HeadlampComponentsPageSteps headlampComponentsPageSteps;

    @And("User {word}s codebase using {word} versioning type on {word}")
    public void createApplication(String codebaseStrategy, String versioningType,
                                  String gitProvider, DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", codebaseStrategy);
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("gitProvider", gitProvider);
        headlampComponentsPageSteps.createApplication(codebaseData);
    }

    @Then("User sees success status and correct values in fields for {word} application")
    public void checkApplicationStatusAndFields(String componentName, DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        CodebaseLanguageUI codeLanguage =
                CodeLanguage.valueOf(codebaseData.get("codeLanguage").toUpperCase()).getCodebaseLanguageUI();

        List<String> dataToCheck = List.of(componentName, codeLanguage.getCodebaseType(), codeLanguage.getLanguage(),
                codeLanguage.getFramework(), codeLanguage.getBuildTool(), codebaseData.get("ciTool"));
        headlampComponentsPageSteps.checkIsComponentCreatedWithCorrectPArameters(dataToCheck);
    }

    @When("User select created application {word} name")
    public void selectCreatedComponent(String componentName) {
        headlampComponentsPageSteps.clickOnTheCreatedComponent();
    }

    @Then("User sees created {word} branch as {word}")
    public void checkDefaultBranch(String branchName, String branchType) {
        headlampComponentsPageSteps.checkDefaultBranch(branchName, branchType);
    }

    @Then("User deletes application with name {word}")
    public void deleteApplication(String applicationName) {
        headlampComponentsPageSteps.deleteApplicationByName(applicationName);
    }

    @When("User creates new branch with {word} versioning type in {word} application")
    public void createNewBranchDependsOnVersioningType(String versioningType, String application, DataTable table) {
        Map<String, String> newBranchData = new HashMap<>(table.asMap(String.class, String.class));
        newBranchData.put("versioningType", versioningType);
        newBranchData.put("applicationName", application);
        headlampComponentsPageSteps.createNewBranch(newBranchData);
    }

    @Then("User deletes {word} branch")
    public void deleteBranch(String branchName) {
        headlampComponentsPageSteps.deleteBranchByName(branchName);
    }

    @When("User triggers build pipeline for {word} branch name")
    public void triggerBuildPipeline(String branchName) {
        headlampComponentsPageSteps.triggerBuildPipeline(branchName);
    }

    @Then("User checks {word} pipeline status in headlamp for {word} branch in {word} codebase")
    public void checkPipelineStatus(String pipelineType, String branchName, String codeBaseName) {
        headlampComponentsPageSteps.checkPipelineStatusOnUI(pipelineType, branchName, codeBaseName);
    }

    @When("User saves the image version in memory for {word} application")
    public void saveImageVersionInTestSession(String applicationName) {
        headlampComponentsPageSteps.saveImageVersionInTestSession(applicationName);
    }

    @And("User searches created application by {word} name")
    public void searchApplicationByName(String applicationName) {
        headlampComponentsPageSteps.searchApplicationByName(applicationName);
    }

    @When("User edits {word} application with parameters")
    public void editApplicationWithParameters(String applicationName, DataTable table) {
        Map<String, String> paramsForEdit = new HashMap<>(table.asMap(String.class, String.class));
        paramsForEdit.put("applicationName", applicationName);
        headlampComponentsPageSteps.editApplicationWithParameters(paramsForEdit);
    }

    @When("User click on the Edit button for the selected application")
    public void clickOnTheEditButtonForTheSelectedApp() {
        headlampComponentsPageSteps.clickOnTheEditButtonForTheSelectedApp();
    }

    @Then("User checks entered data on the edit application popup")
    public void checkDataOnTheEditApplicationPopup(DataTable table) {
        Map<String, String> paramsForEdit = new HashMap<>(table.asMap(String.class, String.class));
        headlampComponentsPageSteps.checkDataOnTheEditApplicationPopup(paramsForEdit);
    }

}
