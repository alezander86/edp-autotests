package edp.stepdefs;

import edp.steps.HeadlampLoginPageSteps;
import io.cucumber.java.en.Given;
import org.springframework.beans.factory.annotation.Autowired;

public class HeadlampLoginPageDefinitionSteps {

    @Autowired
    private HeadlampLoginPageSteps headlampLoginPageSteps;

    @Given("User opens EDP Headlamp as default user")
    public void userOpenAndLoginWithDefaultCredentials() {
        headlampLoginPageSteps.loginAsDefaultUser();
        headlampLoginPageSteps.setUpDefaultNamespace();
    }
}
