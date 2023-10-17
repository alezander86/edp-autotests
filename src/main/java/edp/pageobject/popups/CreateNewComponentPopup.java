package edp.pageobject.popups;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.Selenide;
import edp.core.annotations.Page;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang.StringUtils;
import org.openqa.selenium.Keys;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class CreateNewComponentPopup {

    private static final String POPUP_TITLE_INITIAL = "//h5[text()='Create new component']";
    private static final String POPUP_TITLE = "//h5[text()='Create %s']";
    private static final String SELECT_COMPONENT_BUTTON = "//h4[text()='Create new component']/following-sibling::div//div[text()='%s']";
    private static final String SELECT_CREATION_TYPE_BUTTON = "//div[contains(text(), '%s')]";
    private static final String GIT_SERVER_DROPDOWN = "//div[@id='mui-component-select-gitServer']";
    private static final String SELECT_GIT_SERVER = "//li[text()='%s']";
    private static final String INPUT_GIT_URL_PATH = "//input[@name='gitUrlPath']";
    private static final String INPUT_COMPONENT_NAME = "//input[@name='name']";
    private static final String INPUT_COMPONENT_DESCRIPTION = "//input[@name='description']";
    private static final String CHECKBOX_EMPTY_PROJECT = "//input[@name='emptyProject']";
    private static final String CHECKBOX_JIRA_INTEGRATION = "//input[@name='hasJiraServerIntegration']";
    private static final String APPLICATION_CODE_LANGUAGE = "//input[@value='%s']";
    private static final String APPLICATION_PROVIDER = "//span[text()='Language version/framework']/../../following-sibling::div//input[@value='%s']";
    private static final String APPLICATION_BUILD_TOOL = "//span[text()='Build tool']/../../following-sibling::div//input[@value='%s']";
    private static final String PROCEED_BUTTON = "//span[text()='proceed']";
    private static final String INPUT_DEFAULT_BRANCH = "//input[@name='defaultBranch']";
    private static final String VERSIONING_TYPE_DROPDOWN = "//div[@id='mui-component-select-versioningType']";
    private static final String SELECT_VERSIONING_TYPE = "//li[text()='%s']";
    private static final String APPLY_BUTTON = "//span[text()='apply']";
    private static final String INPUT_START_FROM_VERSION = "//input[@name='versioningStartFromVersion']";
    private static final String INPUT_START_FROM_SNAPSHOT = "//input[@name='versioningStartFromSnapshot']";
    // For Clone strategy
    private static final String INPUT_REPOSITORY_URL = "//input[@name='repositoryUrl']";
    private static final String CHECKBOX_REPOSITORY_CREDENTIALS = "//input[@name='hasCodebaseAuth']";
    private static final String INPUT_REPOSITORY_LOGIN = "//input[@name='repositoryLogin']";
    private static final String INPUT_REPOSITORY_TOKEN = "//input[@name='repositoryPasswordOrApiToken']";
    private static final String INPUT_COMMIT_MESSAGE_PATTERN = "//input[@name='commitMessagePattern']";
    private static final String JIRA_SERVER_DROPDOWN = "//div[@id='mui-component-select-jiraServer']";
    private static final String SELECT_JIRA_SERVER = "//li[text()='%s']";
    private static final String INPUT_TICKET_NAME_PATTERN = "//input[@name='ticketNamePattern']";
    private static final String MAPPING_FIELD_NAME_DROPDOWN = "//div[@id='mui-component-select-advancedMappingFieldName']";
    private static final String SELECT_MAPPING_FIELD = "//li[text()='%s']";
    private static final String ADD_MAPPING_FIELD_BUTTON = "//span[text()='add']";
    private static final String INPUT_COMMENTS_PATTERN = "//input[@name='mapping-row-components']";
    private static final String INPUT_FIX_VERSION_PATTERN = "//input[@name='mapping-row-fixVersions']";
    private static final String INPUT_LABEL_PATTERN = "//input[@name='mapping-row-labels']";

    public void clickOnSelectComponentButton(String componentName) {
        Selenide.sleep(500);
        $x(String.format(SELECT_COMPONENT_BUTTON, componentName)).shouldBe(Condition.visible).click();
    }
    public void clickOnSelectCreationTypeButton(String typeName) {
        $x(String.format(SELECT_CREATION_TYPE_BUTTON, StringUtils.capitalize(typeName)))
                .shouldBe(Condition.visible).click();
    }
    public void selectGitServerType(String gitTypeName) {
        $x(GIT_SERVER_DROPDOWN).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_GIT_SERVER, gitTypeName)).shouldBe(Condition.visible).click();
    }
    public void enterGitServerPath(String gitPath) {
        cleanAndEnterData(INPUT_GIT_URL_PATH, gitPath);
    }
    public void enterApplicationName(String name) {
        cleanAndEnterData(INPUT_COMPONENT_NAME, name);
    }
    public void enterApplicationDescription(String description) {
        $x(INPUT_COMPONENT_DESCRIPTION).shouldBe(Condition.visible).sendKeys(description);
    }
    public void clickOnEmptyProjectCheckbox() {
        Selenide.sleep(500);
        $x(CHECKBOX_EMPTY_PROJECT).click();
    }
    public void clickOnJiraIntegrationCheckbox() {
        Selenide.sleep(500);
        $x(CHECKBOX_JIRA_INTEGRATION).click();
    }
    public void selectApplicationCodeLanguage(String language) {
        Selenide.sleep(500);
        $x(String.format(APPLICATION_CODE_LANGUAGE, language)).click();
    }
    public void selectApplicationProvider(String provider) {
        Selenide.sleep(500);
        $x(String.format(APPLICATION_PROVIDER, provider)).click();
    }
    public void selectApplicationBuildTool(String buildTool) {
        Selenide.sleep(500);
        $x(String.format(APPLICATION_BUILD_TOOL, buildTool)).click();
    }
    public void clickOnProceedButton() {
        $x(PROCEED_BUTTON).shouldBe(Condition.visible).click();
    }
    public void enterDefaultBranchName(String branchName) {
        cleanAndEnterData(INPUT_DEFAULT_BRANCH, branchName);
    }
    public void selectVersioningType(String versioningType) {
        $x(VERSIONING_TYPE_DROPDOWN).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_VERSIONING_TYPE, versioningType)).shouldBe(Condition.visible).click();
    }
    public void enterStartFromVersion(String startFromVersion) {
        cleanAndEnterData(INPUT_START_FROM_VERSION, startFromVersion);
    }
    public void enterStartFromSnapshot(String startFromSnapshot) {
        cleanAndEnterData(INPUT_START_FROM_SNAPSHOT, startFromSnapshot);
    }
    public void clickOnApplyButton() {
        $x(APPLY_BUTTON).shouldBe(Condition.visible).click();
    }
    public void createApplicationPopupIsOpened() {
        $x(POPUP_TITLE_INITIAL).shouldNotBe(Condition.visible);
    }
    public void createApplicationPopupIsClosed(String componentType) {
        $x(String.format(POPUP_TITLE, componentType)).shouldNotBe(Condition.visible);
    }
    public void enterRepositoryURL(String gitPath) {
        $x(INPUT_REPOSITORY_URL).shouldBe(Condition.visible).sendKeys(gitPath);
    }
    public void clickOnRepositoryCredentialsCheckbox() {
        Selenide.sleep(500);
        $x(CHECKBOX_REPOSITORY_CREDENTIALS).click();
    }
    public void enterRepositoryLogin(String login) {
        $x(INPUT_REPOSITORY_LOGIN).shouldBe(Condition.visible).sendKeys(login);
    }
    public void enterRepositoryToken(String token) {
        $x(INPUT_REPOSITORY_TOKEN).shouldBe(Condition.visible).sendKeys(token);
    }
    public void enterCommitMessagePattern(String pattern) {
        $x(INPUT_COMMIT_MESSAGE_PATTERN).shouldBe(Condition.visible).sendKeys(pattern);
    }
    public void selectJiraServer(String jiraServer) {
        $x(JIRA_SERVER_DROPDOWN).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_JIRA_SERVER, jiraServer)).shouldBe(Condition.visible).click();
    }
    public void enterTicketNamePattern(String pattern) {
        $x(INPUT_TICKET_NAME_PATTERN).shouldBe(Condition.visible).sendKeys(pattern);
    }
    public void addMappingField(String fieldName) {
        $x(MAPPING_FIELD_NAME_DROPDOWN).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_MAPPING_FIELD, fieldName)).shouldBe(Condition.visible).click();
        $x(ADD_MAPPING_FIELD_BUTTON).shouldBe(Condition.visible).click();
    }
    public void enterCommentPattern(String pattern) {
        $x(INPUT_COMMENTS_PATTERN).shouldBe(Condition.visible).sendKeys(pattern);
    }
    public void enterFixVersionPattern(String pattern) {
        $x(INPUT_FIX_VERSION_PATTERN).shouldBe(Condition.visible).sendKeys(pattern);
    }
    public void enterLabelsPattern(String pattern) {
        $x(INPUT_LABEL_PATTERN).shouldBe(Condition.visible).sendKeys(pattern);
    }

    private void cleanAndEnterData(String xPath, String dataToEnter) {
        $x(xPath).shouldBe(Condition.visible).sendKeys(Keys.CONTROL + "A");
        $x(xPath).shouldBe(Condition.visible).sendKeys(Keys.BACK_SPACE);
        $x(xPath).shouldBe(Condition.visible).sendKeys(dataToEnter);
    }
}
