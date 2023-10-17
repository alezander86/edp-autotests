Feature: Tekton Jira integration

  Scenario Outline: Check Jira-integration for <codeLanguage> added with edp version using create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    When User creates edp codebase on github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
      | jiraServer      | epam-jira         |
    When User creates pull request to "<defaultBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User checks Jira ticket fields
      | applicationName   | <applicationName>   |
      | version           | 1.2.3-SNAPSHOT.1    |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @TektonGithub
    Examples:
      | applicationName               | codeLanguage      | defaultBranchName |
      | beego-app-edp-github-jira-int | beego_application | master            |

  Scenario Outline: Check Jira-integration commit massage validate for <codeLanguage> added with default version using create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    And User creates default codebase on github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | jiraServer      | epam-jira         |
    When User creates pull request to "<defaultBranchName>" target branch in github "<applicationName>" project with wrong commit message
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase is failed on push-to-jira stage
    And User checks Jira ticket fields are empty
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @TektonGithub
    Examples:
      | applicationName                   | codeLanguage          | defaultBranchName |
      | terraform-lib-edp-jira-validation | hcl_terraform_library | master            |
