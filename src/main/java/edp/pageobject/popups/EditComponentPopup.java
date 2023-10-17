package edp.pageobject.popups;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.Selenide;
import edp.core.annotations.Page;
import lombok.extern.log4j.Log4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class EditComponentPopup {

    private static final String POPUP_TITLE = "//h5[text()='Edit %s']";
    private static final String INPUT_COMMIT_MESSAGE_PATTERN = "//input[@name='commitMessagePattern']";
    private static final String CHECKBOX_JIRA_INTEGRATION = "//input[@name='hasJiraServerIntegration']";
    private static final String JIRA_SERVER_DROPDOWN = "//div[@id='mui-component-select-jiraServer']";
    private static final String SELECT_JIRA_SERVER = "//li[text()='%s']";
    private static final String INPUT_TICKET_NAME_PATTERN = "//input[@name='ticketNamePattern']";
    private static final String MAPPING_FIELD_NAME_DROPDOWN =
            "//div[@id='mui-component-select-advancedMappingFieldName']";
    private static final String SELECT_MAPPING_FIELD = "//li[text()='%s']";
    private static final String ADD_MAPPING_FIELD_BUTTON = "//span[text()='add']";
    private static final String INPUT_COMMENTS_PATTERN = "//input[@name='mapping-row-components']";
    private static final String INPUT_FIX_VERSION_PATTERN = "//input[@name='mapping-row-fixVersions']";
    private static final String INPUT_LABEL_PATTERN = "//input[@name='mapping-row-labels']";
    private static final String APPLY_BUTTON = "//span[text()='apply']";
    private static final String CANCEL_BUTTON = "//span[text()='cancel']";

    public void editComponentPopupIsOpened(String componentName) {
        $x(String.format(POPUP_TITLE, componentName)).shouldBe(Condition.visible);
    }

    public void editComponentPopupIsClosed(String componentName) {
        $x(String.format(POPUP_TITLE, componentName)).shouldNotBe(Condition.visible);
    }

    public void enterCommitMessagePattern(String pattern) {
        $x(INPUT_COMMIT_MESSAGE_PATTERN).shouldBe(Condition.visible).sendKeys(pattern);
    }

    public void clickOnJiraIntegrationCheckbox() {
        Selenide.sleep(500);
        $x(CHECKBOX_JIRA_INTEGRATION).click();
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

    public void clickOnApplyButton() {
        $x(APPLY_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnCancelButton() {
        $x(CANCEL_BUTTON).shouldBe(Condition.visible).click();
    }

    public void isCommitMessagePatternFieldContainsValue(String value) {
        $x(INPUT_COMMIT_MESSAGE_PATTERN).shouldBe(Condition.visible).shouldHave(Condition.attribute("value", value));
    }

    public void isIntegrateWithJiraServerCheckBoxSelected() {
        $x(CHECKBOX_JIRA_INTEGRATION).shouldBe(Condition.selected);
    }

    public void isJiraServerFieldContainsText(String value) {
        $x(JIRA_SERVER_DROPDOWN).shouldBe(Condition.visible).shouldHave(Condition.text(value));
    }

    public void isTicketNamePatternFieldContainsValue(String value) {
        $x(INPUT_TICKET_NAME_PATTERN).shouldBe(Condition.visible).shouldHave(Condition.attribute("value", value));
    }

    public void isCommentPatternFieldContainsValue(String value) {
        $x(INPUT_COMMENTS_PATTERN).shouldBe(Condition.visible).shouldHave(Condition.attribute("value", value));
    }

    public void isFixVersionPatternFieldContainsValue(String value) {
        $x(INPUT_FIX_VERSION_PATTERN).shouldBe(Condition.visible).shouldHave(Condition.attribute("value", value));
    }

    public void isLabelPatternFieldContainsValue(String value) {
        $x(INPUT_LABEL_PATTERN).shouldBe(Condition.visible).shouldHave(Condition.attribute("value", value));
    }
}
