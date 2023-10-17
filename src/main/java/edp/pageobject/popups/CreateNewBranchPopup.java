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
public class CreateNewBranchPopup {

    private static final String POPUP_TITLE = "//h5[text()='Create New Branch']";
    private static final String ENTER_BRANCH_NAME_FIELD = "//input[@name='branchName']";
    private static final String APPLY_BUTTON = "//span[text()='apply']";
    private static final String RELEASE_BRANCH_CHECKBOX = "//input[@name='release']";
    private static final String INPUT_BRANCH_VERSION_START_FIELD = "//input[@name='branchVersionStart']";
    private static final String INPUT_BRANCH_VERSION_POSTFIX_FIELD = "//input[@name='branchVersionPostfix']";

    public void enterBranchName(String branchName) {
        $x(ENTER_BRANCH_NAME_FIELD).shouldBe(Condition.visible).sendKeys(branchName);
    }

    public void applyCreationButton() {
        $x(APPLY_BUTTON).shouldBe(Condition.visible).click();
    }

    public void createNewBranchPopupIsClosed() {
        $x(POPUP_TITLE).shouldNotBe(Condition.visible);
    }

    public void enterStartFromVersion(String startFromVersion) {
        cleanAndEnterData(INPUT_BRANCH_VERSION_START_FIELD, startFromVersion);
    }
    public void enterStartFromSnapshot(String startFromSnapshot) {
        cleanAndEnterData(INPUT_BRANCH_VERSION_POSTFIX_FIELD, startFromSnapshot);
    }

    public void clickOnRealiseBranchCheckbox() {
        $x(RELEASE_BRANCH_CHECKBOX).click();
    }

    private void cleanAndEnterData(String xPath, String dataToEnter) {
        $x(xPath).shouldBe(Condition.visible).sendKeys(Keys.CONTROL + "A");
        $x(xPath).shouldBe(Condition.visible).sendKeys(Keys.BACK_SPACE);
        $x(xPath).shouldBe(Condition.visible).sendKeys(dataToEnter);
    }

}
