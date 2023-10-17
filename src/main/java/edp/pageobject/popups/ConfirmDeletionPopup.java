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
public class ConfirmDeletionPopup {

    private static final String ENTER_CODEBASE_NAME_TO_DELETE = "//input[@name='name']";
    private static final String CONFIRM_DELETION_BUTTON = "//span[text()='Confirm']";

    public void enterApplicationName(String applicationName) {
        $x(ENTER_CODEBASE_NAME_TO_DELETE).shouldBe(Condition.visible).sendKeys(applicationName);
    }

    public void confirmDeletionButton() {
        $x(CONFIRM_DELETION_BUTTON).shouldBe(Condition.visible).click();
    }

    public void popUpShouldBeClosed() {
        $x(CONFIRM_DELETION_BUTTON).shouldNot(Condition.visible);
    }

}
