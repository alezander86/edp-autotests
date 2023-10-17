package edp.stepdefs;

import edp.steps.HeadlampConfigurationPageSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.springframework.beans.factory.annotation.Autowired;

public class HeadlampConfigurationPageDefinitionSteps {

    @Autowired
    private HeadlampConfigurationPageSteps headlampConfigurationPageSteps;

    @Then("User checks Git Servers configuration parameters")
    public void checkGitServersConfigurationOnScreen() {
        headlampConfigurationPageSteps.checkGitServersConfiguration();
    }

    @Then("User checks Clusters configuration parameters")
    public void checkClustersConfigurationOnScreen() {
        headlampConfigurationPageSteps.checkClustersConfiguration();
    }

    @Then("User checks Registry configuration parameters")
    public void checkRegistryConfigurationOnScreen() {
        headlampConfigurationPageSteps.checkRegistryConfiguration();
    }

    @Then("User checks {word} configuration parameters with {word} secret")
    public void checkConfigurationsOnScreen(String typeName, String secretName) {
        headlampConfigurationPageSteps.checkServiceAccountSecret(typeName, secretName);
    }

    @Then("User checks GitOps configuration parameters")
    public void checkGitOpsConfigurationOnScreen() {
        headlampConfigurationPageSteps.checkGitOpsConfiguration();
    }

    @Then("User checks Links configuration parameters")
    public void checkLinksConfigurationOnScreen() {
        headlampConfigurationPageSteps.checkLinksConfiguration();
    }

    @When("User adds new link with random name and url")
    public void addNewLinkOnConfigurationScreen() {
        headlampConfigurationPageSteps.addNewLinkOnConfigurationScreen();
    }
}
