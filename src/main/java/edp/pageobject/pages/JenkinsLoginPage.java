package edp.pageobject.pages;

import static com.codeborne.selenide.Selenide.$x;
import static com.codeborne.selenide.WebDriverRunner.getWebDriver;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.Selenide;
import edp.core.annotations.Page;
import edp.core.config.EdpComponentsConfig;
import edp.pageobject.IBasePage;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class JenkinsLoginPage implements IBasePage {

    @Autowired
    private EdpComponentsConfig edpComponentsConfig;

    private static final String USERNAME_FIELD = "//input[@id='username']";
    private static final String PASSWORD_FIELD = "//input[@id='password']";
    private static final String LOGIN_BUTTON = "//input[@id='kc-login']";

    public void openLoginPage() {
        getWebDriver().get(edpComponentsConfig.getJenkinsUrl());
    }

    public void enterUsername(String username) {
        $x(USERNAME_FIELD).shouldBe(Condition.visible).sendKeys(username);
    }

    public void enterPassword(String password) {
        $x(PASSWORD_FIELD).shouldBe(Condition.visible).sendKeys(password);
    }

    public void clickLoginButton() {
        $x(LOGIN_BUTTON).shouldBe(Condition.visible).click();
        Selenide.refresh();
        Selenide.sleep(1000);
        Selenide.refresh();
        Selenide.sleep(1000);
    }

}
