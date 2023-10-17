package edp.pageobject.pages;

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
public class HeadlampConfigurationPage {

    private static final String CONFIGURATION_TYPE_BUTTON = "//p[text()='%s']";
    private static final String CONFIGURATION_TYPE_NAME_LABEL = "//h5[text()='%s']";
    private static final String CREATE_SERVICE_ACCOUNT_BUTTON = "//h6[text()='%s']/../../../..";
    private static final String NO_INTEGRATION_SECRET_FOUND = "//p[text()='%s']";
    private static final String SECRET_NAME_BUTTON = "//h6[text()='%s']";
    private static final String GIT_SERVER_NAME_BUTTON = "//div[text()='%s']";
    private static final String MANAGED_BY_EXTERNAL_SECRET_ICON = "//h6[text()='%s']/../following-sibling::div";
    private static final String LINKS_NAME_BUTTON = "//div[text()='%s']";
    private static final String ECR_BUTTON = "//span[text()='ECR']";
    private static final String HARBOR_BUTTON = "//span[text()='Harbor']";
    private static final String LINK_NAME_INPUT_FIELD = "//h5[text()='Links']/../../div[2]//input[@name='name']";
    private static final String LINK_URL_INPUT_FIELD = "//h5[text()='Links']/../../div[2]//input[@name='url']";
    private static final String LINK_ICON_INPUT_FIELD = "//h5[text()='Links']/../../div[2]//textarea[@name='icon']";
    private static final String SAVE_LINK_BUTTON = "//h5[text()='Links']/../../div[2]//span[text()='save']";

    public void userClickOnTConfigurationButtonByName(String buttonName) {
        $x(String.format(CONFIGURATION_TYPE_BUTTON, buttonName)).shouldBe(Condition.visible).click();
    }

    public void userSeesConfigurationScreenLabelBaseOnType(String typeName) {
        $x(String.format(CONFIGURATION_TYPE_NAME_LABEL, typeName)).shouldBe(Condition.visible);
    }

    public void isCreateServiceAccountEditable(String typeName) {
        $x(String.format(CREATE_SERVICE_ACCOUNT_BUTTON, typeName)).shouldBe(Condition.visible)
                .shouldHave(Condition.attribute("aria-disabled", "false"));
    }

    public void isCreateServiceAccountNotEditable(String typeName) {
        $x(String.format(CREATE_SERVICE_ACCOUNT_BUTTON, typeName)).shouldBe(Condition.visible)
                .shouldHave(Condition.attribute("aria-disabled", "true"));
    }

    public void noIntegrationSecretFoundMessageIsDisplayed(String noValueMessage){
        $x(String.format(NO_INTEGRATION_SECRET_FOUND, noValueMessage)).shouldBe(Condition.visible);
    }

    public void isSecretWithNameDisplayed(String secretName) {
        $x(String.format(SECRET_NAME_BUTTON, secretName)).shouldBe(Condition.visible);
    }

    public void isGitServerWithNameDisplayed(String secretName) {
        $x(String.format(GIT_SERVER_NAME_BUTTON, secretName)).shouldBe(Condition.visible);
    }

    public void isSecretWithNameNotDisplayed(String secretName) {
        $x(String.format(SECRET_NAME_BUTTON, secretName)).shouldNotBe(Condition.visible);
    }

    public void isGitOpsWithNameDisplayed(String gitOpsName) {
        $x(String.format(LINKS_NAME_BUTTON, gitOpsName)).shouldBe(Condition.visible);
    }

    public void isLinkWithNameDisplayed(String linkName) {
        $x(String.format(LINKS_NAME_BUTTON, linkName)).shouldBe(Condition.visible);
    }

    public void isManageByExternalSecretIconDisplayed(String secretName) {
        $x(String.format(MANAGED_BY_EXTERNAL_SECRET_ICON, secretName)).shouldBe(Condition.visible);
    }

    public void isManageByExternalSecretIconNotDisplayed(String secretName) {
        $x(String.format(MANAGED_BY_EXTERNAL_SECRET_ICON, secretName)).shouldNotBe(Condition.visible);
    }

    public void userClickOnECRButtonInRegistryTab() {
        $x(ECR_BUTTON).shouldBe(Condition.visible).click();
    }

    public void userClickOnHarborButtonInRegistryTab() {
        $x(HARBOR_BUTTON).shouldBe(Condition.visible).click();
    }

    public void userClickOnCreateButtonByName(String buttonName) {
        $x(String.format(CREATE_SERVICE_ACCOUNT_BUTTON, buttonName)).shouldBe(Condition.visible).click();
    }

    public void enterLinkName(String linkName) {
        $x(LINK_NAME_INPUT_FIELD).shouldBe(Condition.visible).sendKeys(linkName);
    }
    public void enterLinkUrl(String linkUrl) {
        $x(LINK_URL_INPUT_FIELD).shouldBe(Condition.visible).sendKeys(linkUrl);
    }
    public void enterLinkIcon(String linkIcon) {
        $x(LINK_ICON_INPUT_FIELD).shouldBe(Condition.visible).sendKeys(linkIcon);
    }

    public void userClickOnSaveLinkButton() {
        $x(SAVE_LINK_BUTTON).shouldBe(Condition.visible).click();
    }
}
