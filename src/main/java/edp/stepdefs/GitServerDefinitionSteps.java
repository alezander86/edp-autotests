package edp.stepdefs;

import edp.steps.GitServerSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import org.springframework.beans.factory.annotation.Autowired;

public class GitServerDefinitionSteps {

    @Autowired
    private GitServerSteps gitServerSteps;

    @Given("User creates Github git server with following values")
    public void createGithubGitServerWithFollowingValues(final DataTable table) throws InterruptedException {
        gitServerSteps.createGithubGitServerWithFollowingValues(table);
    }
    @And("User checks {string} git server status")
    public void checkGitServerStatus(final String gitServerName) throws InterruptedException {
        gitServerSteps.checkGitServerStatus(gitServerName);
    }

    @And("User creates Gitlab git server with following values")
    public void createGitlabGitServerWithFollowingValues(final DataTable table) throws InterruptedException {
        gitServerSteps.createGitlabGitServerWithFollowingValues(table);
    }

}
