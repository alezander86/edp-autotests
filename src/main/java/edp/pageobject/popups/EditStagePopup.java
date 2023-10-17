package edp.pageobject.popups;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import edp.core.annotations.Page;
import lombok.extern.log4j.Log4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class EditStagePopup {

    private static final String POPUP_TITLE = "//h5[text()='Edit %s']";
    private static final String SELECT_TRIGGER_TYPE_BUTTON = "//div[@id='mui-component-select-triggerType']";
    private static final String SELECT_TRIGGER_TYPE_LIST_BOX = "//li[text()='%s']";
    private static final String APPLY_BUTTON = "//span[text()='apply']";
    private static final String CANCEL_BUTTON = "//span[text()='cancel']";

    public void editStagePopupIsOpened(String pipelineName, String stageName) {
        $x(String.format(POPUP_TITLE, pipelineName.concat("-").concat(stageName))).shouldBe(Condition.visible);
    }

    public void editStagePopupIsClosed(String pipelineName, String stageName) {
        $x(String.format(POPUP_TITLE, pipelineName.concat("-").concat(stageName))).shouldNotBe(Condition.visible);
    }

    public void selectTriggerType(String triggerType) {
        $x(SELECT_TRIGGER_TYPE_BUTTON).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_TRIGGER_TYPE_LIST_BOX, triggerType)).shouldBe(Condition.visible).click();
    }

    public void clickOnApplyButton() {
        $x(APPLY_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickOnCancelButton() {
        $x(CANCEL_BUTTON).shouldBe(Condition.visible).click();
    }

    public void isTriggerTypeFieldContainsText(String value) {
        $x(SELECT_TRIGGER_TYPE_BUTTON).shouldBe(Condition.visible).shouldHave(Condition.text(value));
    }
}
