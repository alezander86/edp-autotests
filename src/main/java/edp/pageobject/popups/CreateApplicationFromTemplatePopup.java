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
public class CreateApplicationFromTemplatePopup {

    private static final String POPUP_TITLE = "//h5/strong[text()='%s']";
    private static final String INPUT_COMPONENT_NAME = "//input[@name='name']";
    private static final String INPUT_DESCRIPTION = "//input[@name='description']";
    private static final String GIT_SERVER_DROPDOWN = "//div[@id='mui-component-select-gitServer']";
    private static final String SELECT_GIT_SERVER = "//li[text()='%s']";
    private static final String INPUT_GIT_URL_PATH = "//input[@name='gitUrlPath']";
    private static final String VERSIONING_TYPE_DROPDOWN = "//div[@id='mui-component-select-versioningType']";
    private static final String SELECT_VERSIONING_TYPE = "//li[text()='%s']";
    private static final String INPUT_START_FROM_VERSION = "//input[@name='versioningStartFromVersion']";
    private static final String INPUT_START_FROM_SNAPSHOT = "//input[@name='versioningStartFromPostfix']";
    private static final String APPLY_BUTTON = "//span[text()='apply']";

    public void createApplicationFromTemplatePopupIsOpened(String templateName) {
        $x(String.format(POPUP_TITLE, templateName)).shouldBe(Condition.visible);
    }
    public void createApplicationFromTemplatePopupIsClosed(String templateName) {
        $x(String.format(POPUP_TITLE, templateName)).shouldNotBe(Condition.visible);
    }
    public void enterComponentName(String name) {
        cleanAndEnterData(INPUT_COMPONENT_NAME, name);
    }
    public void enterDescription(String description) {
        $x(INPUT_DESCRIPTION).shouldBe(Condition.visible).sendKeys(description);
    }
    public void selectGitServerType(String gitTypeName) {
        $x(GIT_SERVER_DROPDOWN).shouldBe(Condition.visible).click();
        $x(String.format(SELECT_GIT_SERVER, gitTypeName)).shouldBe(Condition.visible).click();
    }
    public void enterGitServerPath(String gitPath) {
        cleanAndEnterData(INPUT_GIT_URL_PATH, gitPath);
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
    private void cleanAndEnterData(String xPath, String dataToEnter) {
        $x(xPath).shouldBe(Condition.visible).sendKeys(Keys.CONTROL + "A");
        $x(xPath).shouldBe(Condition.visible).sendKeys(Keys.BACK_SPACE);
        $x(xPath).shouldBe(Condition.visible).sendKeys(dataToEnter);
    }
    public void clickOnApplyButton() {
        $x(APPLY_BUTTON).shouldBe(Condition.visible).click();
    }
}
