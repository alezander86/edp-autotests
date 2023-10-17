package edp.pageobject.pages;

import com.codeborne.selenide.Condition;
import edp.core.annotations.CurrentUrl;
import edp.core.annotations.Page;
import edp.core.config.EdpComponentsConfig;
import edp.pageobject.IBasePage;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

import static com.codeborne.selenide.Selenide.$x;
import static com.codeborne.selenide.WebDriverRunner.getWebDriver;

@Lazy
@Page
@Log4j
@Scope("prototype")
@CurrentUrl("/c/main/login")
public class HeadlampLoginPage implements IBasePage {
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    private static final String SIGN_IN_BUTTON = "//span[text()='Sign In']";
    private static final String USE_A_TOKEN_BUTTON = "//span[text()='Use A Token']";
    private static final String ID_TOKEN_INPUT = "//input[@id='token']";
    private static final String AUTHENTICATE_BUTTON = "//span[text()='Authenticate']";
    private static final String USERNAME_FIELD = "//input[@id='username']";
    private static final String PASSWORD_FIELD = "//input[@id='password']";
    private static final String LOGIN_BUTTON = "//input[@id='kc-login']";

    @Override
    public void openLoginPage() {
        getWebDriver().get(
                edpComponentsConfig.getHeadlampUrl() + this.getClass().getAnnotation(CurrentUrl.class).value());
    }

    public void clickUseASignInButton() {
        $x(SIGN_IN_BUTTON).shouldBe(Condition.visible).click();
    }
    public void clickUseAUseATokenButton() {
        $x(USE_A_TOKEN_BUTTON).shouldBe(Condition.visible).click();
    }
    public void enterUsername(String username) {
        $x(USERNAME_FIELD).shouldBe(Condition.visible).sendKeys(username);
    }
    public void enterPassword(String password) {
        $x(PASSWORD_FIELD).shouldBe(Condition.visible).sendKeys(password);
    }
    public void enterToken(String token) {
        $x(ID_TOKEN_INPUT).shouldBe(Condition.visible).sendKeys(token);
    }
    public void clickUseALoginButton() {
        $x(LOGIN_BUTTON).shouldBe(Condition.visible).click();
    }
    public void clickUseAuthenticateButton() {
        $x(AUTHENTICATE_BUTTON).shouldBe(Condition.visible).click();
    }
}
