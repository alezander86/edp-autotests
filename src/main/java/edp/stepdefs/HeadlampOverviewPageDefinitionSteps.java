package edp.stepdefs;

import edp.steps.HeadlampOverviewPageSteps;
import io.cucumber.java.en.Then;
import org.springframework.beans.factory.annotation.Autowired;

public class HeadlampOverviewPageDefinitionSteps {
    @Autowired
    private HeadlampOverviewPageSteps headlampOverviewPageSteps;

    @Then("User checks created link with random name and url")
    public void checkAddedLinkOnOverviewScreen() {
        headlampOverviewPageSteps.checkAddedLinkOnOverviewScreen();
    }

}
