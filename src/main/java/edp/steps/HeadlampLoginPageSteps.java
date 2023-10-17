package edp.steps;

import com.codeborne.selenide.Selenide;
import edp.core.config.EdpComponentsConfig;
import edp.core.config.KeycloakAuthConfig;
import edp.core.config.TestsConfig;
import edp.pageobject.IBrowserTabProcessing;
import edp.pageobject.pages.HeadlampLoginPage;
import edp.pageobject.pages.HeadlampMainPage;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class HeadlampLoginPageSteps {
    @Autowired
    private HeadlampLoginPage loginPage;
    @Autowired
    private HeadlampMainPage headlampMainPage;
    @Autowired
    private KeycloakAuthConfig keycloakAuthConfig;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private SecretsSteps secretsSteps;


    public void loginAsDefaultUser() {
        loginPage.openLoginPage();
        if ("sandbox".equals(testsConfig.getCluster())) {
            loginPage.clickUseASignInButton();
            IBrowserTabProcessing.switchToNewTab();
            loginPage.enterUsername(keycloakAuthConfig.getUserName());
            loginPage.enterPassword(keycloakAuthConfig.getPassword());
            loginPage.clickUseALoginButton();
            IBrowserTabProcessing.switchToFirstTab();
        } else {
//            loginPage.clickUseAUseATokenButton();
            loginPage.enterToken(secretsSteps.getHeadlampAdminTokenForOKDCluster());
            loginPage.clickUseAuthenticateButton();
        }
    }

    public void setUpDefaultNamespace() {
        Selenide.sleep(2000);
        headlampMainPage.clickOnUserSettingsButton();
        headlampMainPage.enterDefaultNamespace(edpComponentsConfig.getNamespace());
        headlampMainPage.enterAllowedNamespace(edpComponentsConfig.getNamespace());
        headlampMainPage.clickOnAddAllowedNamespaceButton();
    }
}
