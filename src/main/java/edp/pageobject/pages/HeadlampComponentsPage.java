package edp.pageobject.pages;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import edp.core.annotations.Page;
import edp.utils.consts.Constants;
import lombok.extern.log4j.Log4j;
import org.openqa.selenium.Keys;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class HeadlampComponentsPage {

    private static final String ADD_COMPONENT_BUTTON = "//span[text()='create']";
    private static final String OPEN_SEARCH_FIELD_BUTTON = "//button[@aria-label='Show filter']";
    private static final String SEARCH_FILTER_FIELD = "//input[@id='standard-search']";
    private static final String FIRST_TABLE_ROW = "//table[contains(@class,'MuiTable-root')]/tbody/tr[1]";
    private static final String STATUS_FIELD_FIRST_ROW = FIRST_TABLE_ROW.concat("/th[1]/*/*/*");
    private static final String COMPONENT_NAME_FIRST_ROW = FIRST_TABLE_ROW.concat("/th[2]/div/a");
    private static final String EDIT_DELETE_BUTTON_FIRST_ROW = FIRST_TABLE_ROW.concat("/th[8]");
    private static final String EDIT_BUTTON = "//span[text()='Edit']";
    private static final String DELETE_BUTTON = "//span[text()='Delete']";
    private static final String DEFAULT_BRANCH_FIELD = "//h6[text()='%s']/following-sibling::div/span";
    private static final String CREATE_BRANCH_BUTTON = "//button[@title='Create branch']";
    private static final String BRANCH_BY_NAME_FIELD = "//h6[text()='%s']";
    private static final String ACTION_BUTTON = "//h6[text()='%s']/following-sibling::div/div/div[5]";
    private static final String ACTION_BUTTON_SHARED = "//h6[text()='%s']/following-sibling::div/div/div[4]";
    private static final String BUILD_BUTTON = "//h6[text()='%s']/following-sibling::div/div/div[4]";
    private static final String BUILD_BUTTON_SHARED = "//h6[text()='%s']/following-sibling::div/div/div[3]";
    private static final String DELETE_BRANCH_BUTTON = "//span[text()='Delete']";
    private static final String PIPELINE_STATUS_FIELD =
            "//a[contains(text(),'%s')]/ancestor::th/preceding-sibling::th/div/*/*";
    private static final String ACTIONS_BUTTON = "//button[@aria-label='Actions']";

    public void clickOnAddComponentButton() {
        $x(ADD_COMPONENT_BUTTON).shouldBe(Condition.visible).click();
    }

    public void searchComponentByName(String applicationName) {
        if(!$x(SEARCH_FILTER_FIELD).isDisplayed()) {
            $x(OPEN_SEARCH_FIELD_BUTTON).shouldBe(Condition.visible).click();
        }
        $x(SEARCH_FILTER_FIELD).shouldBe(Condition.visible).sendKeys(Keys.CONTROL + "A");
        $x(SEARCH_FILTER_FIELD).shouldBe(Condition.visible).sendKeys(Keys.BACK_SPACE);
        $x(SEARCH_FILTER_FIELD).shouldBe(Condition.visible).sendKeys(applicationName);
    }

    public void isFirstRowContainsText(String text) {
        $x(FIRST_TABLE_ROW).shouldHave(Condition.text(text));
    }

    public void checkStatusColour() {
        $x(STATUS_FIELD_FIRST_ROW).shouldBe(Condition.visible)
                .shouldHave(Condition.cssValue("color", Constants.SUCCESS_COLOUR));
    }

    public void clickOnComponentNameInTheFirstRow() {
        $x(COMPONENT_NAME_FIRST_ROW).shouldBe(Condition.visible).click();
    }

    public void checkCreatedBranchStatus(String branchName, String branchType) {
        $x(String.format(DEFAULT_BRANCH_FIELD, branchName)).shouldBe(Condition.visible)
                .shouldHave(Condition.text(branchType));
    }

    public void clickOnDeleteButton() {
        $x(EDIT_DELETE_BUTTON_FIRST_ROW).shouldBe(Condition.visible).click();
        $x(DELETE_BUTTON).shouldBe(Condition.visible).click();
    }
    public void clickOnEditButton() {
        $x(EDIT_DELETE_BUTTON_FIRST_ROW).shouldBe(Condition.visible).click();
        $x(EDIT_BUTTON).shouldBe(Condition.visible).click();
    }
    public void clickOnEditButtonInSelectedApp() {
        $x(ACTIONS_BUTTON).shouldBe(Condition.visible).click();
        $x(EDIT_BUTTON).shouldBe(Condition.visible).click();
    }
    public void clickOnCreateNewBranchButton() {
        $x(CREATE_BRANCH_BUTTON).shouldBe(Condition.visible).click();
    }

    public void userSeesCreatedBranch(String branchName) {
        $x(String.format(BRANCH_BY_NAME_FIELD, branchName)).shouldBe(Condition.visible);
    }

    public void userClickOnTheCreatedBranch(String branchName) {
        $x(String.format(BRANCH_BY_NAME_FIELD, branchName)).shouldBe(Condition.visible).click();
    }

    public void clickOnDeleteButtonByBranchNameButton(String branchName) {
        $x(String.format(ACTION_BUTTON, branchName)).shouldBe(Condition.visible).click();
        $x(DELETE_BRANCH_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnDeleteButtonByBranchNameButtonShared(String branchName) {
        $x(String.format(ACTION_BUTTON_SHARED, branchName)).shouldBe(Condition.visible).click();
        $x(DELETE_BRANCH_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnBuildButtonByBranchName(String branchName) {
        $x(String.format(BUILD_BUTTON, branchName)).shouldBe(Condition.visible).click();
    }

    public void clickOnBuildButtonByBranchNameShared(String branchName) {
        $x(String.format(BUILD_BUTTON_SHARED, branchName)).shouldBe(Condition.visible).click();
    }

    public void checkPipelineStatusFieldColour(String runName) {
        $x(String.format(PIPELINE_STATUS_FIELD, runName)).shouldBe(Condition.visible)
                .shouldHave(Condition.cssValue("color", Constants.SUCCESS_COLOUR));
    }
}
