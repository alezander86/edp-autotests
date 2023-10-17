package edp.stepdefs;

import edp.steps.HeadlampMainePageSteps;
import io.cucumber.java.en.When;
import org.springframework.beans.factory.annotation.Autowired;

public class HeadlampMainPageDefinitionSteps {
    @Autowired
    private HeadlampMainePageSteps headlampMainePageSteps;

    @When("User opens EDP Overview tab")
    public void openEDPOverviewTab() {
        headlampMainePageSteps.openEDPOverviewTab();
    }

    @When("User opens EDP Marketplace tab")
    public void openEDPMarketplaceTab() {
        headlampMainePageSteps.openEDPMarketplaceTab();
    }

    @When("User opens EDP Components tab")
    public void openEDPComponentsTab() {
        headlampMainePageSteps.openEDPComponentsTab();
    }

    @When("User opens EDP Environments tab")
    public void openEDPCDPipelineTab() {
        headlampMainePageSteps.openEDPEnvironmentsTab();
    }

    @When("User opens EDP Configuration tab")
    public void openEDPConfigurationTab() {
        headlampMainePageSteps.openEDPConfigurationTab();
    }

}
