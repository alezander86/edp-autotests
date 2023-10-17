package edp.stepdefs;

import edp.steps.JiraServerSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import org.springframework.beans.factory.annotation.Autowired;

public class JiraServerDefinitionSteps {
    @Autowired
    private JiraServerSteps jiraServer;

    @Given("User creates Jira server with following values")
    public void createJiraServerWithFollowingValues(final DataTable table) {
        jiraServer.createJiraServerWithFollowingValues(table);
    }

    @And("User checks {string} jira server status")
    public void checkJiraServerStatus(final String jiraServerName) throws InterruptedException {
        jiraServer.checkJiraServerStatus(jiraServerName);
    }
}
