Feature: Tekton Jira integration

  Scenario Outline: Check Jira-integration for <codeLanguage> added with default version using create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User creates default codebase on gerrit with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    When User creates change in "<defaultBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    When User saves the image version in memory for <applicationName> application
    Then User checks Jira ticket fields
      | applicationName   | <applicationName>   |
      | variable          | EDP_VERSION         |
      | defaultBranchName | <defaultBranchName> |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @TektonGerrit @TektonJiraSmoke
    Examples:
      | applicationName                   | codeLanguage             | defaultBranchName |
      | java11-mvn-create-def-jira-gerrit | java11_maven_application | master            |


  Scenario Outline: Check Jira-integration commit massage validate for <codeLanguage> added with edp version using create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User creates edp codebase on gerrit with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
    When User creates change in "<defaultBranchName>" branch in "<applicationName>" gerrit project with wrong commit message
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase is failed on push-to-jira stage
    And User checks Jira ticket fields are empty
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @TektonGerrit @TektonJiraSmoke
    Examples:
      | applicationName              | codeLanguage | defaultBranchName |
      | rego-opa-lib-jira-validation | opa_library  | master            |