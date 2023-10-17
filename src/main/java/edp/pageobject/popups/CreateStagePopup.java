package edp.pageobject.popups;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import edp.core.annotations.Page;
import lombok.extern.log4j.Log4j;
import org.openqa.selenium.Keys;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class CreateStagePopup {

    private static final String POPUP_TITLE = "//h5[contains(text(),'Create stage for \"%s\"')]";
    private static final String SELECT_CLUSTER_BUTTON = "//div[@id='mui-component-select-cluster']";
    private static final String SELECT_CLUSTER_LIST_BOX = "//li[text()='%s']";
    private static final String INPUT_STAGE_NAME = "//span[text()='Stage name']/following::input[@name='name']";
    private static final String INPUT_STAGE_DESCRIPTION_NAME = "//span[text()='Description']/following::input[@name='description']";
    private static final String SELECT_QG_FIRST_STEP_TYPE = "//div[contains(@id,'mui-component-select-quality-gate-type-')]";
    private static final String SELECT_QG_FIRST_STEP_TYPE_LIST_BOX = "//li[text()='%s']";
    private static final String INPUT_QG_FIRST_STEP_NAME = "//input[contains(@name,'quality-gate-step-name-')]";
    private static final String SELECT_QG_FIRST_STEP_AUTOTEST_PROJECT = "//div[text()='Select autotest']";
    private static final String SELECT_QG_FIRST_STEP_PROJECT_LIST_BOX = "//li[text()='%s']";
    private static final String SELECT_QG_FIRST_STEP_AUTOTEST_PROJECT_BRANCH = "//div[text()='Select autotest branch']";
    private static final String SELECT_QG_FIRST_STEP_PROJECT_BRANCH_LIST_BOX = "//li[text()='%s']";
    private static final String ADD_QUALITY_GATES_BUTTON = "//span[text()='add']";
    private static final String APPLY_BUTTON = "//h6[text()='Quality gates']/following::span[text()='apply']";

    public void createStagePopupIsOpened(String pipelineName) {
        $x(String.format(POPUP_TITLE, pipelineName)).shouldBe(Condition.visible);
    }

    public void createStagePopupIsClosed(String pipelineName) {
        $x(String.format(POPUP_TITLE, pipelineName)).shouldNotBe(Condition.visible);
    }

    public void enterClusterName(String clusterName) {
        $x(SELECT_CLUSTER_BUTTON).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_CLUSTER_LIST_BOX, clusterName)).shouldBe(Condition.visible).click();
    }

    public void enterStageName(String stageName) {
        $x(INPUT_STAGE_NAME).shouldBe(Condition.visible).sendKeys(stageName);
    }

    public void enterStageDescriptionName(String description) {
        $x(INPUT_STAGE_DESCRIPTION_NAME).shouldBe(Condition.visible).sendKeys(description);
    }

    public void selectQGType(String qgType) {
        $x(SELECT_QG_FIRST_STEP_TYPE).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_QG_FIRST_STEP_TYPE_LIST_BOX, qgType)).shouldBe(Condition.visible).click();
    }

    public void enterQGFirstStepName(String qgStepName) {
        $x(INPUT_QG_FIRST_STEP_NAME).shouldBe(Condition.visible).sendKeys(qgStepName);
    }

    public void selectAutotestProject(String projectName) {
        $x(SELECT_QG_FIRST_STEP_AUTOTEST_PROJECT).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_QG_FIRST_STEP_PROJECT_LIST_BOX, projectName)).shouldBe(Condition.visible).click();
    }

    public void selectAutotestProjectBranch(String projectBranch) {
        $x(SELECT_QG_FIRST_STEP_AUTOTEST_PROJECT_BRANCH).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_QG_FIRST_STEP_PROJECT_BRANCH_LIST_BOX, projectBranch)).shouldBe(Condition.visible)
                .click();
    }

    public void clickOnAddQualityGatesButton() {
        $x(ADD_QUALITY_GATES_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnApplyButton() {
        $x(APPLY_BUTTON).shouldBe(Condition.visible).click();
    }

    private void cleanAndEnterData(String xPath, String dataToEnter) {
        $x(xPath).shouldBe(Condition.visible).sendKeys(Keys.CONTROL + "A");
        $x(xPath).shouldBe(Condition.visible).sendKeys(Keys.BACK_SPACE);
        $x(xPath).shouldBe(Condition.visible).sendKeys(dataToEnter);
    }
}
