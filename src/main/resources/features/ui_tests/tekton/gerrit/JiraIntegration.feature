Feature: Tekton Jira Integration review and build pipeline with gerrit

  Scenario Outline: Check Jira-integration for <codeLanguage> added with default version using create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    And User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on gerrit
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | jiraIntegration   | True                |
    When User creates change in "<defaultBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    When User saves the image version in memory for <applicationName> application
    Then User checks Jira ticket fields
      | applicationName | <applicationName> |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @UI @TektonGerritUI @TektonJiraGerritUI
    Examples:
      | applicationName          | codeLanguage     | defaultBranchName |
      | helm-create-def-app-jira | helm_application | master            |
