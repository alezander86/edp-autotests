package edp.steps;

import static edp.core.crd.codebase.codebase_branch.CodebaseBranch.formatCodebaseBranchNameForManualLaunch;
import static edp.stepdefs.http.GitLabDefinitionSteps.GITLAB_NAMESPACE_PATH;
import static edp.stepdefs.http.GithubDefinitionSteps.GITHUB_NAMESPACE_PATH;
import static edp.utils.consts.Constants.FORMATTER;
import static io.vavr.API.$;
import static io.vavr.API.Case;
import static io.vavr.API.Match;

import com.codeborne.selenide.Selenide;
import edp.core.cache.TestCache;
import edp.core.config.EdpComponentsConfig;
import edp.core.config.GithubProviderConfig;
import edp.core.config.TestsConfig;
import edp.core.crd.codebase.codebase.Codebase;
import edp.core.crd.codebase.codebase_branch.CodebaseBranch;
import edp.core.crd.tekton.task_run.TaskRun;
import edp.core.crd.tekton.task_run.TaskRunSpec;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.enums.testdata.CodeLanguage;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.pageobject.pages.HeadlampComponentsPage;
import edp.pageobject.pages.HeadlampMainPage;
import edp.pageobject.popups.ConfirmDeletionPopup;
import edp.pageobject.popups.CreateNewBranchPopup;
import edp.pageobject.popups.CreateNewComponentPopup;
import edp.pageobject.popups.EditComponentPopup;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import lombok.extern.log4j.Log4j;
import org.assertj.core.api.SoftAssertions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class HeadlampComponentsPageSteps {
    @Autowired
    private HeadlampComponentsPage headlampComponentsPage;
    @Autowired
    private HeadlampMainPage headlampMainPage;
    @Autowired
    private ConfirmDeletionPopup confirmDeletionPopup;
    @Autowired
    private CreateNewBranchPopup createNewBranchPopup;
    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private CreateNewComponentPopup createNewComponentPopup;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private GithubProviderConfig githubProviderConfig;
    @Autowired
    private EditComponentPopup editComponentPopup;

    private static final String JIRA_ISSUE_METADATA_PAYLOAD =
            "{\"components\":\"%s\",\"fixVersions\":\"%s\",\"labels\":\"%s\"}";

    public void createApplication(Map<String, String> codebaseData) {
        CodeLanguage codeLanguage =
                CodeLanguage.valueOf(codebaseData.get("codeLanguage").toUpperCase());

        headlampComponentsPage.clickOnAddComponentButton();
        createNewComponentPopup.createApplicationPopupIsOpened();
        createNewComponentPopup.clickOnSelectComponentButton(codeLanguage.getCodebaseLanguageUI().getCodebaseType());
        createNewComponentPopup.clickOnSelectCreationTypeButton(codebaseData.get("codebaseStrategy"));
        Selenide.sleep(500);
        if ("clone".equals(codebaseData.get("codebaseStrategy"))) {
            createNewComponentPopup.enterRepositoryURL("https://github.com/edp-robot/"
                    .concat(codeLanguage.getGithubProjectName()).concat(".git"));
            createNewComponentPopup.clickOnRepositoryCredentialsCheckbox();
            createNewComponentPopup.enterRepositoryLogin(githubProviderConfig.getUsername());
            createNewComponentPopup.enterRepositoryToken(githubProviderConfig.getToken());
        }
        createNewComponentPopup.selectGitServerType(codebaseData.get("gitProvider"));
        createNewComponentPopup.enterGitServerPath(("import".equals(codebaseData.get("codebaseStrategy")) ?
                getGitServerPathBAseOnGitProviderImport(codebaseData.get("gitProvider")) :
                getGitServerPathBAseOnGitProvider(codebaseData.get("gitProvider"),
                        codebaseData.get("applicationName"))));
        createNewComponentPopup.enterApplicationName(codebaseData.get("applicationName"));
        createNewComponentPopup.enterApplicationDescription(codebaseData.get("applicationName"));
        if (codebaseData.containsKey("emptyProject")) {
            createNewComponentPopup.clickOnEmptyProjectCheckbox();
        }
        createNewComponentPopup.selectApplicationCodeLanguage(codeLanguage.getLanguage());
        createNewComponentPopup.selectApplicationProvider(codeLanguage.getVersion());
        createNewComponentPopup.selectApplicationBuildTool(codeLanguage.getBuildTool());
        createNewComponentPopup.clickOnProceedButton();

        createNewComponentPopup.enterDefaultBranchName(codebaseData.get("defaultBranchName"));
        createNewComponentPopup.selectVersioningType(codebaseData.get("versioningType"));
        if (codebaseData.get("versioningType").equals("edp")) {
            createNewComponentPopup.enterStartFromVersion(codebaseData.get("startFromVersion"));
            createNewComponentPopup.enterStartFromSnapshot(codebaseData.get("startFromSnapshot"));
        }
        if (codebaseData.containsKey("jiraIntegration")) {
            createNewComponentPopup.clickOnJiraIntegrationCheckbox();
            createNewComponentPopup.enterCommitMessagePattern("^\\[EPMDEDPSUP-\\d{4}\\]:.*");
            createNewComponentPopup.selectJiraServer("epam-jira");
            createNewComponentPopup.enterTicketNamePattern("EPMDEDPSUP-\\d{4}");
            createNewComponentPopup.addMappingField("Component/s");
            createNewComponentPopup.enterCommentPattern("EDP_COMPONENT");
            createNewComponentPopup.addMappingField("FixVersion/s");
            createNewComponentPopup.enterFixVersionPattern("EDP_GITTAG-EDP_COMPONENT");
            createNewComponentPopup.addMappingField("Labels");
            createNewComponentPopup.enterLabelsPattern("EDP_COMPONENT");
        }
        createNewComponentPopup.clickOnApplyButton();
        createNewComponentPopup.createApplicationPopupIsClosed(codeLanguage.getCodebaseLanguageUI().getCodebaseType());
        factory.verifyCustomResource(Codebase.class, codebaseData.get("applicationName"), Codebase::isActive);
        factory.verifyCustomResource(CodebaseBranch.class,
                codebaseData.get("applicationName").concat("-").concat(codebaseData.get("defaultBranchName")),
                CodebaseBranch::isActive);
        headlampComponentsPage.searchComponentByName(codebaseData.get("applicationName"));
    }

    public void checkIsComponentCreatedWithCorrectPArameters(List<String> parameters) {
        parameters.forEach(p -> headlampComponentsPage.isFirstRowContainsText(p));
        headlampComponentsPage.checkStatusColour();
    }

    public void clickOnTheCreatedComponent() {
        headlampComponentsPage.clickOnComponentNameInTheFirstRow();
    }

    public void checkDefaultBranch(String branchName, String branchType) {
        headlampComponentsPage.checkCreatedBranchStatus(branchName, branchType);
    }

    public void deleteApplicationByName(String applicationName) {
        headlampMainPage.clickOnEDPTab();
        headlampMainPage.clickOnComponentsTab();
        headlampComponentsPage.searchComponentByName(applicationName);
        headlampComponentsPage.clickOnDeleteButton();
        confirmDeletionPopup.enterApplicationName(applicationName);
        confirmDeletionPopup.confirmDeletionButton();
    }

    public void createNewBranch(Map<String, String> newBranchData) {
        headlampComponentsPage.clickOnCreateNewBranchButton();
        if (newBranchData.containsKey("realiseBranch") && newBranchData.get("versioningType").equals("edp")) {
            createNewBranchPopup.clickOnRealiseBranchCheckbox();
        }
        if (!newBranchData.containsKey("realiseBranch")) {
            createNewBranchPopup.enterBranchName(newBranchData.get("newBranchName"));
        }
        if (newBranchData.get("versioningType").equals("edp")) {
            createNewBranchPopup.enterStartFromVersion(newBranchData.get("startFromVersion"));
            createNewBranchPopup.enterStartFromSnapshot(newBranchData.get("StartFromSnapshot"));
        }
        createNewBranchPopup.applyCreationButton();
        createNewBranchPopup.createNewBranchPopupIsClosed();
        factory.verifyCustomResource(CodebaseBranch.class, newBranchData.get("applicationName").concat("-")
                .concat(newBranchData.containsKey("realiseBranch") ?
                        newBranchData.get("newBranchName").replace("/", "-") : newBranchData.get("newBranchName")
                ), CodebaseBranch::isActive);
        headlampComponentsPage.userSeesCreatedBranch(newBranchData.get("newBranchName"));
    }

    public void deleteBranchByName(String branchName) {
        if (edpComponentsConfig.getIsSharedEnv()) {
            headlampComponentsPage.clickOnDeleteButtonByBranchNameButtonShared(branchName);
        } else {
            headlampComponentsPage.clickOnDeleteButtonByBranchNameButton(branchName);
        }
        confirmDeletionPopup.enterApplicationName(branchName);
        confirmDeletionPopup.confirmDeletionButton();
        confirmDeletionPopup.popUpShouldBeClosed();
    }

    public void triggerBuildPipeline(String branchName) {
        if (edpComponentsConfig.getIsSharedEnv()) {
            headlampComponentsPage.clickOnBuildButtonByBranchNameShared(branchName);
        } else {
            headlampComponentsPage.clickOnBuildButtonByBranchName(branchName);
        }

    }

    public void checkPipelineStatusOnUI(String pipelineType, String branchName, String codeBaseName) {
        headlampComponentsPage.userClickOnTheCreatedBranch(branchName);
        headlampComponentsPage.checkPipelineStatusFieldColour(
                formatCodebaseBranchNameForManualLaunch(codeBaseName, branchName.replace("/", "-"))
                        .concat("-").concat(pipelineType));
    }

    public void saveImageVersionInTestSession(String applicationName) {
        TaskRunSpec taskRunSpec = factory.getTargetClient().customResources(TaskRun.class)
                .inNamespace(edpComponentsConfig.getNamespace())
                .list().getItems()
                .stream().filter(item -> item.getMetadata().getName().endsWith("update-cbis") &&
                        item.getMetadata().getName().startsWith(getTrimmedName(applicationName).substring(0, 19)))
                .max(Comparator.comparing(HeadlampComponentsPageSteps::apply)).get().getSpec();
        TestCache.putDataInCache(TestCacheKey.IMAGE_VERSION, Arrays.stream(taskRunSpec.getParams())
                .filter(p -> p.getName().equals("IMAGE_TAG")).findFirst().get().getValue());
    }

    public void searchApplicationByName(String applicationName) {
        headlampComponentsPage.searchComponentByName(applicationName);

    }

    public void editApplicationWithParameters(Map<String, String> paramsForEdit) {
        headlampComponentsPage.clickOnEditButton();
        editComponentPopup.editComponentPopupIsOpened(paramsForEdit.get("applicationName"));
        editComponentPopup.enterCommitMessagePattern(paramsForEdit.get("commitMessagePattern"));
        editComponentPopup.clickOnJiraIntegrationCheckbox();
        editComponentPopup.selectJiraServer(paramsForEdit.get("jiraServer"));
        editComponentPopup.enterTicketNamePattern(paramsForEdit.get("ticketNamePattern"));
        editComponentPopup.addMappingField("Component/s");
        editComponentPopup.enterCommentPattern(paramsForEdit.get("componentJiraPattern"));
        editComponentPopup.addMappingField("FixVersion/s");
        editComponentPopup.enterFixVersionPattern(paramsForEdit.get("fixVersionJiraPattern"));
        editComponentPopup.addMappingField("Labels");
        editComponentPopup.enterLabelsPattern(paramsForEdit.get("labelJiraPattern"));
        editComponentPopup.clickOnApplyButton();
        editComponentPopup.editComponentPopupIsClosed(paramsForEdit.get("applicationName"));
    }

    public void clickOnTheEditButtonForTheSelectedApp() {
        headlampComponentsPage.clickOnEditButtonInSelectedApp();
    }

    public void checkDataOnTheEditApplicationPopup(Map<String, String> paramsForEdit) {
        editComponentPopup.editComponentPopupIsOpened(paramsForEdit.get("applicationName"));
        editComponentPopup.isCommitMessagePatternFieldContainsValue(paramsForEdit.get("commitMessagePattern"));
        editComponentPopup.isIntegrateWithJiraServerCheckBoxSelected();
        editComponentPopup.isJiraServerFieldContainsText(paramsForEdit.get("jiraServer"));
        editComponentPopup.isTicketNamePatternFieldContainsValue(paramsForEdit.get("ticketNamePattern"));
        editComponentPopup.isCommentPatternFieldContainsValue(paramsForEdit.get("componentJiraPattern"));
        editComponentPopup.isFixVersionPatternFieldContainsValue(paramsForEdit.get("fixVersionJiraPattern"));
        editComponentPopup.isLabelPatternFieldContainsValue(paramsForEdit.get("labelJiraPattern"));
        editComponentPopup.clickOnCancelButton();
        editComponentPopup.editComponentPopupIsClosed(paramsForEdit.get("applicationName"));
        Codebase codebase = factory.getCustomResource(Codebase.class, paramsForEdit.get("applicationName")).get();
        SoftAssertions softAssertions = new SoftAssertions();
        softAssertions.assertThat(paramsForEdit.get("commitMessagePattern"))
                .isEqualTo(codebase.getSpec().getCommitMessagePattern());
        softAssertions.assertThat(paramsForEdit.get("jiraServer")).isEqualTo(codebase.getSpec().getJiraServer());
        softAssertions.assertThat(paramsForEdit.get("ticketNamePattern"))
                .isEqualTo(codebase.getSpec().getTicketNamePattern());
        softAssertions.assertThat(String.format(JIRA_ISSUE_METADATA_PAYLOAD, paramsForEdit.get("componentJiraPattern"),
                        paramsForEdit.get("fixVersionJiraPattern"), paramsForEdit.get("labelJiraPattern")))
                .isEqualTo(codebase.getSpec().getJiraIssueMetadataPayload());
        softAssertions.assertAll();
    }

    private String getGitServerPathBAseOnGitProvider(String gitProvider, String applicationName) {
        return Match(gitProvider).of(
                Case($("gerrit"), applicationName),
                Case($("github"), GITHUB_NAMESPACE_PATH.concat(testsConfig.getProjectName(applicationName))),
                Case($("gitlab"), GITLAB_NAMESPACE_PATH.concat("/")
                        .concat(testsConfig.getProjectName(applicationName)))
        );
    }

    private String getGitServerPathBAseOnGitProviderImport(String gitProvider) {
        return Match(gitProvider).of(
                Case($("github"), () -> TestCache.get(TestCacheKey.GENERATED_GITHUB_PROJECT_URL).toString()
                        .replace("https://github.com/", "").replace(".git", "")),
                Case($("gitlab"), () -> TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_PATH_WITH_NAMESPACE).toString())
        );
    }

    private String getTrimmedName(String applicationName) {
        return applicationName.length() <= 33 ? applicationName : applicationName.substring(0, 33);
    }

    private static LocalDateTime apply(TaskRun e) {
        return LocalDateTime.parse(e.getMetadata().getCreationTimestamp(), FORMATTER);
    }

}
