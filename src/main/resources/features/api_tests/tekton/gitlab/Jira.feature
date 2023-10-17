Feature: Tekton Jira integration

  Scenario Outline: Check Jira-integration for <codeLanguage> added with default version using create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    And User creates default codebase on gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | jiraServer      | epam-jira         |
    When User receive and save GitLab project ID for project <applicationName>
    And User creates pull request from "<defaultBranchName>" ref branch to "<defaultBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    When User saves the image version in memory for <applicationName> application
    And User checks Jira ticket fields
      | applicationName   | <applicationName>   |
      | variable          | EDP_VERSION         |
      | defaultBranchName | <defaultBranchName> |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @TektonGitlab
    Examples:
      | applicationName                 | codeLanguage           | defaultBranchName |
      | dotnet6-app-def-gitlab-jira-int | dotnet_6_0_application | master            |

  Scenario Outline: Check Jira-integration commit massage validate for <codeLanguage> added with edp version using create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    And User creates edp codebase on gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
      | jiraServer      | epam-jira         |
    When User receive and save GitLab project ID for project <applicationName>
    And User creates pull request from "<defaultBranchName>" ref branch to "<defaultBranchName>" target branch in gitlab with wrong commit message
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase is failed on push-to-jira stage
    And User checks Jira ticket fields are empty
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @TektonGitlab
    Examples:
      | applicationName               | codeLanguage   | defaultBranchName |
      | chart-lib-edp-jira-validation | charts_library | master            |
