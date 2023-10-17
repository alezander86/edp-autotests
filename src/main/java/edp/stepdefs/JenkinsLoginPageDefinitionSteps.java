package edp.stepdefs;

import edp.core.config.KeycloakAuthConfig;
import edp.pageobject.pages.Jenkins;
import edp.pageobject.pages.JenkinsLoginPage;
import io.cucumber.java.en.Given;
import org.springframework.beans.factory.annotation.Autowired;

public class JenkinsLoginPageDefinitionSteps {

    @Autowired
    private JenkinsLoginPage loginPage;
    @Autowired
    private Jenkins jenkinsMainPage;
    @Autowired
    private KeycloakAuthConfig keycloakAuthConfig;

    @Given("User opens Jenkins as default user")
    public void userOpenAndLoginWithDefaultCredentials() {
        loginPage.openLoginPage();
        loginPage.enterUsername(keycloakAuthConfig.getUserName());
        loginPage.enterPassword(keycloakAuthConfig.getPassword());
        loginPage.clickLoginButton();
    }
}
