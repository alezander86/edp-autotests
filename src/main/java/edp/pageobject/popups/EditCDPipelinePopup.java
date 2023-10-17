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
public class EditCDPipelinePopup {

    private static final String POPUP_TITLE = "//h5[text()='Edit %s']";
    private static final String SELECT_APPLICATION_BUTTON = "//div[@id='mui-component-select-applicationsToAddChooser']";
    private static final String SELECT_APPLICATION_LIST_BOX = "//li[text()='%s']";
    private static final String ADD_APPLICATION_BUTTON = "//span[text()='add']";
    private static final String SELECT_BRANCH_BUTTON = "//div[contains(@id,'%s')]";
    private static final String SELECT_BRANCH_LIST_BOX = "//li[text()='%s']";
    private static final String PROMOTE_IN_PIPELINE_CHECKBOX = "//input[@name='application-row-%s-application-to-promote']";
    private static final String APPLY_BUTTON = "//span[text()='apply']";
    private static final String CANCEL_BUTTON = "//span[text()='cancel']";

    public void editPipelinePopupIsOpened(String pipelineName) {
        $x(String.format(POPUP_TITLE, pipelineName)).shouldBe(Condition.visible);
    }

    public void editPipelinePopupIsClosed(String pipelineName) {
        $x(String.format(POPUP_TITLE, pipelineName)).shouldNotBe(Condition.visible);
    }

    public void addApplication(String applicationName) {
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

    public void clickOnApplyButton() {
        $x(APPLY_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnCancelButton() {
        $x(CANCEL_BUTTON).shouldBe(Condition.visible).click();
    }

    public void isBranchFieldForApplicationContainsText(String applicationName, String value) {
        $x(String.format(SELECT_BRANCH_BUTTON, applicationName)).shouldBe(Condition.visible)
                .shouldHave(Condition.text(value));
    }

    public void isToPromoteCheckBoxSelectedForApplication(String applicationName) {
        $x(String.format(PROMOTE_IN_PIPELINE_CHECKBOX, applicationName)).shouldBe(Condition.selected);
    }

    public void isToPromoteCheckBoxNotSelectedForApplication(String applicationName) {
        $x(String.format(PROMOTE_IN_PIPELINE_CHECKBOX, applicationName)).shouldNotBe(Condition.selected);
    }

}
