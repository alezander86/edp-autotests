package edp.stepdefs;

import edp.steps.SecretsSteps;
import io.cucumber.java.en.Given;
import org.springframework.beans.factory.annotation.Autowired;

public class SecretsDefinitionSteps {
    @Autowired
    private SecretsSteps secrets;

    @Given("User creates {string} github-sshsecret with following values")
    public void createGithubSshSecretWithFollowingValues(final String secretName) {
        secrets.createGithubSshSecretWithFollowingValues(secretName);
    }

    @Given("User creates {string} gitlab-sshsecret with following values")
    public void createGitlabSshSecretWithFollowingValues(final String secretName) {
        secrets.createGitlabSshSecretWithFollowingValues(secretName);
    }

    @Given("User creates {string} github API token secret")
    public void createGithubApiTokenSecret(final String secretName) {
        secrets.createGithubApiTokenSecret(secretName);
    }

    @Given("User creates {string} gitlab API token secret")
    public void createGitlabApiTokenSecret(final String secretName) {
        secrets.createGitlabApiTokenSecret(secretName);
    }

    @Given("User creates {string} jira-user with following values")
    public void createEpanJiraUserSecretWithFollowingValues(final String secretName) {
        secrets.createEpamJiraUserSecretWithFollowingValues(secretName);
    }

    @Given("User updates {string} secret data")
    public void updateSecretData(final String secretName) {
        secrets.updateSecretData(secretName);
    }

}
