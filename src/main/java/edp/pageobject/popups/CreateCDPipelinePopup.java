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
public class CreateCDPipelinePopup {

    private static final String POPUP_TITLE = "//h5[text()='Create CD Pipeline']";
    private static final String INPUT_PIPELINE_NAME = "//input[@name='name']";
    private static final String SELECT_DEPLOYMENT_TYPE_BUTTON = "//div[@id='mui-component-select-deploymentType']";
    private static final String SELECT_DEPLOYMENT_TYPE_LIST_BOX = "//li[text()='%s']";
    private static final String PROCEED_BUTTON = "//span[text()='proceed']";
    private static final String SELECT_APPLICATION_BUTTON = "//div[@id='mui-component-select-applicationsToAddChooser']";
    private static final String SELECT_APPLICATION_LIST_BOX = "//li[text()='%s']";
    private static final String ADD_APPLICATION_BUTTON = "//span[text()='add']";
    private static final String SELECT_BRANCH_BUTTON = "//div[contains(@id,'%s')]";
    private static final String SELECT_BRANCH_LIST_BOX = "//li[text()='%s']";
    private static final String PROMOTE_IN_PIPELINE_CHECKBOX = "//input[@name='application-row-%s-application-to-promote']";
    private static final String ADD_STAGE_BUTTON = "//span[text()='add stage']";
    private static final String APPLY_BUTTON = "//span[text()='apply']";

    public void createCDPipelinePopupIsOpened() {
        $x(POPUP_TITLE).shouldBe(Condition.visible);
    }

    public void createCDPipelinePopupIsClosed() {
        $x(POPUP_TITLE).shouldNotBe(Condition.visible);
    }

    public void enterPipelineName(String pipelineName) {
        $x(INPUT_PIPELINE_NAME).shouldBe(Condition.visible).sendKeys(pipelineName);
    }

    public void selectDeploymentType(String deploymentType) {
        $x(SELECT_DEPLOYMENT_TYPE_BUTTON).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_DEPLOYMENT_TYPE_LIST_BOX, StringUtils.capitalize(deploymentType)))
                .shouldBe(Condition.visible).click();
    }

    public void clickOnProceedButton() {
        $x(PROCEED_BUTTON).shouldBe(Condition.visible).click();
    }

    public void selectApplication(String applicationName) {
        $x(SELECT_APPLICATION_BUTTON).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_APPLICATION_LIST_BOX, applicationName)).shouldBe(Condition.visible).click();
        $x(ADD_APPLICATION_BUTTON).shouldBe(Condition.visible).click();
    }

    public void selectBranch(String applicationName, String branchName) {
        $x(String.format(SELECT_BRANCH_BUTTON, applicationName)).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_BRANCH_LIST_BOX, branchName)).shouldBe(Condition.visible).click();
    }

    public void clickOnPromoteProjectCheckbox(String applicationName) {
        Selenide.sleep(500);
        $x(String.format(PROMOTE_IN_PIPELINE_CHECKBOX, applicationName)).click();
    }

    public void clickOnAddStageButton() {
        $x(ADD_STAGE_BUTTON).shouldBe(Condition.visible).click();
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
