package edp.pageobject.pages;

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
public class HeadlampMainPage {
    private static final String EDP_TAB = "//span[text()='EDP']";
    private static final String CONFIGURATION_TAB = "//span[text()='EDP']/following::span[text()='Configuration']";
    private static final String OVERVIEW_TAB = "//span[text()='Overview']";
    private static final String MARKETPLACE_TAB = "//span[text()='Marketplace']";
    private static final String COMPONENTS_TAB = "//span[text()='Components']";
    private static final String ENVIRONMENTS_TAB = "//span[text()='Environments']";
    private static final String USER_SETTINGS_BUTTON = "//button[@title='Settings']";
    private static final String DEFAULT_NAMESPACE_INPUT = "//dt[text()='Default namespace']/following-sibling::*[1]//input";
    private static final String ALLOWED_NAMESPACE_INPUT = "//dt[text()='Allowed namespaces']/following-sibling::*//input";
    private static final String ADD_ALLOWED_NAMESPACE_BUTTON = "//dt[text()='Allowed namespaces']/following-sibling::*//button";

    public void clickOnEDPTab() {
        $x(EDP_TAB).shouldBe(Condition.visible).click();
    }
    public void clickOnOverviewTab() {
        $x(OVERVIEW_TAB).shouldBe(Condition.visible).click();
    }
    public void clickOnMarketplaceTab() {
        $x(MARKETPLACE_TAB).shouldBe(Condition.visible).click();
    }
    public void clickOnConfigurationTab() {
        $x(CONFIGURATION_TAB).shouldBe(Condition.visible).click();
    }
    public void clickOnComponentsTab() {
        $x(COMPONENTS_TAB).shouldBe(Condition.visible).click();
    }
    public void clickOnEnvironmentsTab() {
        $x(ENVIRONMENTS_TAB).shouldBe(Condition.visible).click();
    }
    public void clickOnUserSettingsButton() {
        $x(USER_SETTINGS_BUTTON).shouldBe(Condition.visible).click();
    }
    public void enterDefaultNamespace(String defaultNamespace) {
        $x(DEFAULT_NAMESPACE_INPUT).shouldBe(Condition.visible).sendKeys(defaultNamespace);
        Selenide.sleep(1_000);
    }
    public void enterAllowedNamespace(String allowedNamespace) {
        $x(ALLOWED_NAMESPACE_INPUT).shouldBe(Condition.visible).sendKeys(allowedNamespace);
    }
    public void clickOnAddAllowedNamespaceButton() {
        $x(ADD_ALLOWED_NAMESPACE_BUTTON).shouldBe(Condition.visible).click();
    }
}
