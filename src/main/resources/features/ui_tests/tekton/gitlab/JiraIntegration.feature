Feature: Tekton Jira Integration review and build pipeline with gitlab

  Scenario Outline: Check Jira-integration for <codeLanguage> added with EDP version using clone strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    And User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User imports codebase using edp versioning type on gitlab
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | startFromVersion  | 1.2.6               |
      | startFromSnapshot | SNAPSHOT            |
      | jiraIntegration   | True                |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    When User creates new branch with edp versioning type in <applicationName> application
      | newBranchName     | <newBranchName> |
      | startFromVersion  | 5.9.7           |
      | StartFromSnapshot | RC              |
      | realiseBranch     | True            |
    Then User sees created <newBranchName> branch as release
    When User creates pull request from "<defaultBranchName>" ref branch to "<newBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<newBranchNameFormatted>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<newBranchNameFormatted>" branch in "<applicationName>" codebase
    And User checks Jira ticket fields
      | applicationName | <applicationName> |
      | version         | build/5.9.7-RC.1  |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask

    @UI @TektonGitlabUI @TektonJiraGitlabUI
    Examples:
      | applicationName                  | codeLanguage             | defaultBranchName | newBranchName | newBranchNameFormatted |
      | java8-grd-import-edp-app-rc-jira | java8_gradle_application | master            | release/5.9   | release-5.9            |




