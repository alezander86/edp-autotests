package edp.steps;

import edp.pageobject.pages.HeadlampComponentsPage;
import edp.pageobject.pages.HeadlampMainPage;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class HeadlampMainePageSteps {
    @Autowired
    private HeadlampMainPage headlampMainPage;
    @Autowired
    private HeadlampComponentsPage headlampComponentsPage;

    public void openEDPOverviewTab() {
        headlampMainPage.clickOnEDPTab();
        headlampMainPage.clickOnOverviewTab();
    }

    public void openEDPMarketplaceTab() {
        headlampMainPage.clickOnEDPTab();
        headlampMainPage.clickOnMarketplaceTab();
    }

    public void openEDPComponentsTab() {
        headlampMainPage.clickOnEDPTab();
        headlampMainPage.clickOnComponentsTab();
    }

    public void openEDPEnvironmentsTab() {
        headlampMainPage.clickOnEDPTab();
        headlampMainPage.clickOnEnvironmentsTab();
    }

    public void openEDPConfigurationTab() {
        headlampMainPage.clickOnEDPTab();
        headlampMainPage.clickOnConfigurationTab();
    }
}
