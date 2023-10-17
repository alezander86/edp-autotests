package edp.pageobject.pages;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.Selenide;
import com.codeborne.selenide.SelenideElement;
import edp.core.annotations.Page;
import edp.utils.consts.Constants;
import io.vavr.control.Try;
import java.util.function.Predicate;
import lombok.extern.log4j.Log4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class HeadlampCDPipelinePage {

    private static final String ADD_CD_PIPELINE_BUTTON = "//span[text()='create']";
    private static final String OPEN_SEARCH_FIELD_BUTTON = "//button[@aria-label='Show filter']";
    private static final String SEARCH_FILTER_FIELD = "//input[@id='standard-search']";
    private static final String FIRST_TABLE_ROW = "//table[contains(@class,'MuiTable-root')]/tbody/tr[1]";
    private static final String STATUS_FIELD_FIRST_ROW = FIRST_TABLE_ROW.concat("/th[1]/*/*/*");
    private static final String PIPELINE_NAME_FIELD_FIRST_ROW = FIRST_TABLE_ROW.concat("/th[2]/div/a");
    private static final String PIPELINE_APPLICATIONS_FIELD_FIRST_ROW = FIRST_TABLE_ROW.concat("/th[3]/div/a[text()='%s']");
    private static final String OPTION_FIELD_FIRST_ROW = FIRST_TABLE_ROW.concat("/th[4]/div/button");
    private static final String DELETE_PIPELINE_BUTTON = "//span[text()='Delete']";
    private static final String EDIT_PIPELINE_BUTTON = "//span[text()='Edit']";
    private static final String STATUS_FIELD_STAGE_BY_NAME = "//a[text()='%s']/ancestor::th/preceding-sibling::th/*/*/*";
    private static final String STAGE_FIELD_STAGE_BY_NAME = "//a[text()='%s']";
    private static final String TRIGGER_TYPE_FIELD_STAGE_BY_NAME = "//a[text()='%s']/ancestor::th/following-sibling::th[1]/div/div/span";
    private static final String OPTION_FIELD_STAGE_BY_NAME = "//a[text()='%s']/ancestor::th/following-sibling::th[3]//button";
    private static final String EDIT_STAGE_BUTTON = "//span[text()='Edit']";
    private static final String SELECT_APPLICATION_CHECKBOX = "//a[text()='%s']/ancestor::tr/td/span";
    private static final String APPLICATION_HEALTH_STATUS = "//a[text()='%s']/ancestor::tr/th[1]/*/*/*";
    private static final String APPLICATION_SYNC_STATUS = "//a[text()='%s']/ancestor::tr/th[2]/*/*/*";
    private static final String SELECT_APPLICATION_IMAGE_BUTTON = "//a[text()='%s']/ancestor::tr/th[6]//input/preceding-sibling::div";
    private static final String SELECT_APPLICATION_IMAGE_LIST_BOX = "//li[text()='%s']";
    private static final String SHOW_APPLICATION_LOGS_BUTTON = "//a[text()='%s']/ancestor::tr/th[7]/div/div/div[1]";
    private static final String SHOW_APPLICATION_TERMINAL_BUTTON = "//a[text()='%s']/ancestor::tr/th[7]/div/div/div[2]";
    private static final String DEPLOY_BUTTON = "//button[@title='Deploy selected applications with selected image stream version']";
    private static final String UNINSTALL_BUTTON = "//button[@title='Uninstall selected applications']";
    private static final String QUALITY_GATES_BUTTON = "//span[text()='Quality Gates']";
    private static final String APPLICATIONS_BUTTON = "//span[text()='Applications']";
    private static final String PROMOTE_BUTTON = "//span[text()='Promote']";
    private static final String ACTIONS_BUTTON = "//button[@aria-label='Actions']";
    private static final String APPLICATION_LINK_IN_STAGE_SCREEN = "//a[text()='%s']";

    public void clickOnAddCDPipelineButton() {
        $x(ADD_CD_PIPELINE_BUTTON).shouldBe(Condition.visible).click();
    }

    public void searchPipelineByName(String pipelineName) {
        $x(OPEN_SEARCH_FIELD_BUTTON).shouldBe(Condition.visible).click();
        $x(SEARCH_FILTER_FIELD).shouldBe(Condition.visible).sendKeys(pipelineName);
    }

    public void checkPipelineStatus(String pipelineName) {
        searchPipelineByName(pipelineName);
        $x(STATUS_FIELD_FIRST_ROW).shouldBe(Condition.visible)
                .shouldHave(Condition.cssValue("color", Constants.SUCCESS_COLOUR));
    }

    public void clickOnCDPipelineName() {
        $x(PIPELINE_NAME_FIELD_FIRST_ROW).shouldBe(Condition.visible).click();
    }

    public void checkStageStatus(String stageName) {
        $x(String.format(STATUS_FIELD_STAGE_BY_NAME, stageName)).shouldBe(Condition.visible)
                .shouldHave(Condition.cssValue("color", Constants.SUCCESS_COLOUR));
    }

    public void clickOnStageName(String stageName) {
        $x(String.format(STAGE_FIELD_STAGE_BY_NAME, stageName)).shouldBe(Condition.visible).click();
    }

    public void selectApplicationByName(String applicationName) {
        $x(String.format(SELECT_APPLICATION_CHECKBOX, applicationName)).click();
    }

    public void selectImage(String applicationName, String imageName) {
        $x(String.format(SELECT_APPLICATION_IMAGE_BUTTON, applicationName)).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_APPLICATION_IMAGE_LIST_BOX, imageName)).shouldBe(Condition.visible).click();
    }

    public void isPromotedImageAvailable(String applicationName, String imageName) {
        $x(String.format(SELECT_APPLICATION_IMAGE_BUTTON, applicationName)).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_APPLICATION_IMAGE_LIST_BOX, imageName)).shouldBe(Condition.visible);
    }

    public void clickOnDeployButton() {
        $x(DEPLOY_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnUninstallButton() {
        $x(UNINSTALL_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnCDQualityGate() {
        $x(QUALITY_GATES_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnCDApplications() {
        $x(APPLICATIONS_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnPromoteButton() {
        $x(PROMOTE_BUTTON).shouldBe(Condition.visible).click();
    }

    public Predicate<SelenideElement> getHealsCheckCondition(String applicationName) {
        return status -> {
            Selenide.refresh();
            return Try.of(
                    () -> $x(String.format(APPLICATION_HEALTH_STATUS, applicationName)).shouldBe(Condition.visible)
                            .shouldHave(Condition.cssValue("color", Constants.SUCCESS_COLOUR))).isSuccess();
        };
    }

    public Predicate<SelenideElement> getSyncCheckCondition(String applicationName) {
        return status -> {
            Selenide.refresh();
            return Try.of(
                    () -> $x(String.format(APPLICATION_SYNC_STATUS, applicationName)).shouldBe(Condition.visible)
                            .shouldHave(Condition.cssValue("color", Constants.SUCCESS_COLOUR))).isSuccess();
        };
    }

    public void clickOnDeleteButton() {
        $x(OPTION_FIELD_FIRST_ROW).shouldBe(Condition.visible).click();
        $x(DELETE_PIPELINE_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnEditButton() {
        $x(OPTION_FIELD_FIRST_ROW).shouldBe(Condition.visible).click();
        $x(EDIT_PIPELINE_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnEditButtonInSelectedPipeline() {
        $x(ACTIONS_BUTTON).shouldBe(Condition.visible).click();
        $x(EDIT_PIPELINE_BUTTON).shouldBe(Condition.visible).click();
    }

    public void isTriggerTypeFieldForStageContainsValue(String stageName, String value) {
        $x(String.format(TRIGGER_TYPE_FIELD_STAGE_BY_NAME, stageName)).shouldBe(Condition.visible)
                .shouldHave(Condition.text(value));
    }

    public void clickOnStageEditButton(String stageName) {
        $x(String.format(OPTION_FIELD_STAGE_BY_NAME, stageName)).shouldBe(Condition.visible).click();
        $x(EDIT_STAGE_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnShowLogsButton(String applicationName) {
        $x(String.format(SHOW_APPLICATION_LOGS_BUTTON, applicationName)).shouldBe(Condition.visible).click();
    }

    public void clickOnShowTerminalButton(String applicationName) {
        $x(String.format(SHOW_APPLICATION_TERMINAL_BUTTON, applicationName)).shouldBe(Condition.visible).click();
    }

    public void clickOnEditButtonInSelectedStage() {
        $x(ACTIONS_BUTTON).shouldBe(Condition.visible).click();
        $x(EDIT_STAGE_BUTTON).shouldBe(Condition.visible).click();
    }

    public void isApplicationsFieldForTheFirstRowContainsValue(String value) {
        $x(String.format(PIPELINE_APPLICATIONS_FIELD_FIRST_ROW, value)).shouldBe(Condition.visible);
    }

    public void isApplicationsFieldOnStageScreenContainsValue(String value) {
        $x(String.format(APPLICATION_LINK_IN_STAGE_SCREEN, value)).shouldBe(Condition.visible);
    }

}
