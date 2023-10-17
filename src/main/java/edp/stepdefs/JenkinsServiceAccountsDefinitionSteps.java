package edp.stepdefs;

import edp.steps.JenkinsServiceAccountsSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import org.springframework.beans.factory.annotation.Autowired;

public class JenkinsServiceAccountsDefinitionSteps {

    @Autowired
    private JenkinsServiceAccountsSteps jenkinsServiceAccountsSteps;

    @Given("User creates service account")
    public void createServiceAccount(final DataTable table) throws InterruptedException {
        jenkinsServiceAccountsSteps.createServiceAccount(table);
    }

    @And("User checks {string} jenkins service account status")
    public void checkJenkinsServiceAccountStatus(final String credentialName) throws InterruptedException {
        jenkinsServiceAccountsSteps.checkJenkinsServiceAccountStatus(credentialName);
    }
}
