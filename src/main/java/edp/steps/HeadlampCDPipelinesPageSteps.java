package edp.steps;

import static org.assertj.core.api.Assertions.assertThat;

import com.codeborne.selenide.Selenide;
import com.codeborne.selenide.SelenideElement;
import edp.core.cache.TestCache;
import edp.core.config.EdpComponentsConfig;
import edp.core.crd.argocd.application.Application;
import edp.core.crd.codebase.cdpipeline.CDPipeline;
import edp.core.crd.codebase.stage.Stage;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.exceptions.TAFRuntimeException;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.pageobject.pages.HeadlampCDPipelinePage;
import edp.pageobject.pages.HeadlampMainPage;
import edp.pageobject.popups.ConfirmDeletionPopup;
import edp.pageobject.popups.CreateCDPipelinePopup;
import edp.pageobject.popups.CreateStagePopup;
import edp.pageobject.popups.EditCDPipelinePopup;
import edp.pageobject.popups.EditStagePopup;
import edp.pageobject.popups.LogsPopup;
import edp.pageobject.popups.TerminalPopup;
import edp.utils.wait.FlexWait;
import java.util.Map;
import lombok.extern.log4j.Log4j;
import org.assertj.core.api.SoftAssertions;
import org.bouncycastle.util.test.TestFailedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class HeadlampCDPipelinesPageSteps {
    @Autowired
    private HeadlampCDPipelinePage headlampCDPipelinePage;
    @Autowired
    private CreateCDPipelinePopup createCDPipelinePopup;
    @Autowired
    private CreateStagePopup createStagePopup;
    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private HeadlampMainPage headlampMainPage;
    @Autowired
    private ConfirmDeletionPopup confirmDeletionPopup;
    @Autowired
    private EditCDPipelinePopup editCDPipelinePopup;
    @Autowired
    private EditStagePopup editStagePopup;
    @Autowired
    private LogsPopup logsPopup;
    @Autowired
    private TerminalPopup terminalPopup;

    public void createCDPipeline(Map<String, String> cdPipelineData) {
        headlampCDPipelinePage.clickOnAddCDPipelineButton();

        createCDPipelinePopup.createCDPipelinePopupIsOpened();
        createCDPipelinePopup.enterPipelineName(cdPipelineData.get("pipelineName"));
        createCDPipelinePopup.selectDeploymentType(cdPipelineData.get("deploymentType"));
        createCDPipelinePopup.clickOnProceedButton();

        createCDPipelinePopup.selectApplication(cdPipelineData.get("applicationName"));
        createCDPipelinePopup.selectBranch(cdPipelineData.get("applicationName"), cdPipelineData.get("newBranchName"));
        if (cdPipelineData.containsKey("qualityGates")) {
            createCDPipelinePopup.clickOnPromoteProjectCheckbox(cdPipelineData.get("applicationName"));
        }
        createCDPipelinePopup.clickOnProceedButton();

        createCDPipelinePopup.clickOnAddStageButton();
        createStagePopup.createStagePopupIsOpened(cdPipelineData.get("pipelineName"));
        createStagePopup.enterClusterName(cdPipelineData.get("clusterName"));
        createStagePopup.enterStageName(cdPipelineData.get("stageName"));
        createStagePopup.enterStageDescriptionName("Test Stage Description");
        if (!cdPipelineData.containsKey("qualityGates")) {
            createStagePopup.enterQGFirstStepName("manual");
        } else {
            createStagePopup.selectQGType("Autotests");
            createStagePopup.enterQGFirstStepName(cdPipelineData.get("qualityGatesName"));
            createStagePopup.selectAutotestProject(cdPipelineData.get("qualityGatesProject"));
            createStagePopup.selectAutotestProjectBranch(cdPipelineData.get("qualityGatesProjectBranch"));
        }
        createStagePopup.clickOnApplyButton();
        createStagePopup.createStagePopupIsClosed(cdPipelineData.get("pipelineName"));
        createCDPipelinePopup.createCDPipelinePopupIsOpened();
        createCDPipelinePopup.clickOnApplyButton();
    }

    public void waitAndCheckPipelineStatus(String pipelineName, String stageName) {
        factory.verifyCustomResource(CDPipeline.class, pipelineName, CDPipeline::isActive);
        factory.verifyCustomResource(Stage.class, pipelineName.concat("-").concat(stageName), Stage::isActive);
    }

    public void checkStatus(String pipelineName) {
        headlampCDPipelinePage.checkPipelineStatus(pipelineName);
    }

    public void openPipeline(String pipelineName) {
        headlampCDPipelinePage.clickOnCDPipelineName();
    }

    public void checkStageStatus(String stageName) {
        headlampCDPipelinePage.checkStageStatus(stageName);
    }

    public void openStage(String stageName) {
        headlampCDPipelinePage.clickOnStageName(stageName);
    }

    public void deployApplication(String applicationName) {
        headlampCDPipelinePage.selectApplicationByName(applicationName);
        headlampCDPipelinePage.selectImage(applicationName, TestCache.get(TestCacheKey.IMAGE_VERSION).toString());
        headlampCDPipelinePage.clickOnDeployButton();
    }

    public void waitTillApplicationWillBeDeploy(String applicationName) {
        factory.verifyCustomResourceStartsWithName(Application.class, applicationName,
                app -> app.isSynced() && app.isHealthy());
    }

    public void checkApplicationHealsStatusOnUI(String applicationName) {
        new FlexWait<SelenideElement>(String.format("Check deploy status for %s application", applicationName))
                .during(60000).tryTo(headlampCDPipelinePage.getHealsCheckCondition(applicationName))
                .every(1000).executeWithoutResult();
    }

    public void checkApplicationSynkStatusOnUI(String applicationName) {
        new FlexWait<SelenideElement>(String.format("Check deploy status for %s application", applicationName))
                .during(60000).tryTo(headlampCDPipelinePage.getSyncCheckCondition(applicationName))
                .every(1000).executeWithoutResult();
    }

    public void uninstallApplication(String applicationName) {
        headlampCDPipelinePage.selectApplicationByName(applicationName);
        headlampCDPipelinePage.clickOnUninstallButton();
    }

    public void deletePipeline(String pipelineName) {
        headlampMainPage.clickOnEDPTab();
        headlampMainPage.clickOnEnvironmentsTab();
        headlampCDPipelinePage.searchPipelineByName(pipelineName);
        headlampCDPipelinePage.clickOnDeleteButton();
        confirmDeletionPopup.enterApplicationName(pipelineName);
        confirmDeletionPopup.confirmDeletionButton();
        Selenide.sleep(1000);
    }

    public void promoteApplicationUsingQG() {
        headlampCDPipelinePage.clickOnCDQualityGate();
        headlampCDPipelinePage.clickOnPromoteButton();
    }

    public void checkPromotedImage(String applicationName) {
        headlampCDPipelinePage.clickOnCDApplications();
        Selenide.refresh();
        headlampCDPipelinePage.isPromotedImageAvailable(applicationName,
                "[STABLE] - ".concat(TestCache.get(TestCacheKey.IMAGE_VERSION).toString()));
        Selenide.refresh();
    }

    public void editCDPipelineWithParameters(Map<String, String> pipelineEditData) {
        headlampCDPipelinePage.clickOnEditButton();
        editCDPipelinePopup.editPipelinePopupIsOpened(pipelineEditData.get("pipelineName"));
        editCDPipelinePopup.addApplication(pipelineEditData.get("secondApplicationName"));
        editCDPipelinePopup.selectBranch(pipelineEditData.get("secondApplicationName"),
                pipelineEditData.get("secondDefaultBranch"));
        editCDPipelinePopup.clickOnPromoteProjectCheckbox(pipelineEditData.get("applicationName"));
        editCDPipelinePopup.clickOnApplyButton();
        editCDPipelinePopup.editPipelinePopupIsClosed(pipelineEditData.get("pipelineName"));

    }

    public void checkIsAddedApplicationIsDisplayedInApplicationField(Map<String, String> applications) {
        for (Map.Entry<String, String> formEntry : applications.entrySet()) {
            headlampCDPipelinePage.isApplicationsFieldForTheFirstRowContainsValue(formEntry.getValue());
        }
    }

    public void clickOnTheEditButtonForTheSelectedPipeline() {
        headlampCDPipelinePage.clickOnEditButtonInSelectedPipeline();
    }

    public void checkDataOnTheEditPipelinePopup(Map<String, String> pipelineEditData) {
        editCDPipelinePopup.editPipelinePopupIsOpened(pipelineEditData.get("pipelineName"));
        editCDPipelinePopup.isBranchFieldForApplicationContainsText(pipelineEditData.get("applicationName"),
                pipelineEditData.get("defaultBranch"));
        editCDPipelinePopup.isBranchFieldForApplicationContainsText(pipelineEditData.get("secondApplicationName"),
                pipelineEditData.get("secondDefaultBranch"));
        editCDPipelinePopup.isToPromoteCheckBoxSelectedForApplication(pipelineEditData.get("applicationName"));
        editCDPipelinePopup.isToPromoteCheckBoxNotSelectedForApplication(pipelineEditData.get("secondApplicationName"));
        editCDPipelinePopup.clickOnCancelButton();
        editCDPipelinePopup.editPipelinePopupIsClosed(pipelineEditData.get("pipelineName"));
        CDPipeline cdPipeline = factory.getCustomResource(CDPipeline.class, pipelineEditData.get("pipelineName")).get();
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(
                        new String[]{pipelineEditData.get("applicationName"), pipelineEditData.get(
                                "secondApplicationName")})
                .isEqualTo(cdPipeline.getSpec().getApplications());
        softAssertions.assertThat(new String[]{pipelineEditData.get("applicationName")})
                .isEqualTo(cdPipeline.getSpec().getApplicationsToPromote());
        softAssertions.assertAll();
    }

    public void checkTriggerTypeForStageByName(String triggerType, String stageName) {
        headlampCDPipelinePage.isTriggerTypeFieldForStageContainsValue(stageName, triggerType);
    }

    public void editStageWithParameters(Map<String, String> stageEditData) {
        headlampCDPipelinePage.clickOnStageEditButton(stageEditData.get("stageName"));
        editStagePopup.editStagePopupIsOpened(stageEditData.get("pipelineName"), stageEditData.get("stageName"));
        editStagePopup.selectTriggerType(stageEditData.get("triggerType"));
        editStagePopup.clickOnApplyButton();
        editStagePopup.editStagePopupIsClosed(stageEditData.get("pipelineName"), stageEditData.get("stageName"));
    }

    public void clickOnTheEditButtonForTheSelectedStage() {
        headlampCDPipelinePage.clickOnEditButtonInSelectedStage();
    }

    public void checkDataOnTheEditStagePopup(Map<String, String> stageEditData) {
        editStagePopup.editStagePopupIsOpened(stageEditData.get("pipelineName"), stageEditData.get("stageName"));
        editStagePopup.isTriggerTypeFieldContainsText(stageEditData.get("triggerType"));
        editStagePopup.clickOnCancelButton();
        editStagePopup.editStagePopupIsClosed(stageEditData.get("pipelineName"), stageEditData.get("stageName"));
        Stage stage = factory.getCustomResource(Stage.class,
                stageEditData.get("pipelineName").concat("-").concat(stageEditData.get("stageName"))).get();
        assertThat(stageEditData.get("triggerType")).isEqualTo(stage.getSpec().getTriggerType());
    }

    public void checkAddedApplicationOnTheStageScreen(Map<String, String> applications) {
        for (Map.Entry<String, String> formEntry : applications.entrySet()) {
            headlampCDPipelinePage.isApplicationsFieldOnStageScreenContainsValue(formEntry.getValue());
        }
    }

    public void checkLogsAndTerminalPopups(String applicationName, String pipelineName, String stageName)
            throws TestFailedException {
        String newNamespaceName = edpComponentsConfig.getNamespace().concat("-").concat(pipelineName).concat("-")
                .concat(stageName);
        String podName = factory.getPodListInNamespace(newNamespaceName)
                .stream().filter(pod -> pod.getMetadata().getName().startsWith(applicationName)).findFirst()
                .orElseThrow(() -> new TAFRuntimeException(
                        String.format("Pod started with %s name wasn't found in %s namespace.", applicationName,
                                newNamespaceName)))
                .getMetadata().getName();
        // Logs
        headlampCDPipelinePage.clickOnShowLogsButton(applicationName);
        logsPopup.logsPopupIsOpened(podName);
        logsPopup.isSelectPodFieldForLogsContainsValue(podName);
        logsPopup.isSelectContainerFieldForLogsContainsValue(applicationName);
        logsPopup.closeLogsPopup(podName);
        logsPopup.logsPopupIsClosed(podName);

        // Console
        headlampCDPipelinePage.clickOnShowTerminalButton(applicationName);
        terminalPopup.terminalPopupIsOpened(podName);
        terminalPopup.isSelectPodFieldForTerminalContainsValue(podName);
        terminalPopup.isSelectContainerFieldForTerminalContainsValue(applicationName);
        terminalPopup.closeTerminalPopup(podName);
        terminalPopup.terminalPopupIsClosed(podName);
    }
}
