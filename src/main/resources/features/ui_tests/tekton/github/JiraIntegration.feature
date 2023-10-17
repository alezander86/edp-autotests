Feature: Tekton Jira Integration review and build pipeline with github

  Scenario Outline: Check Jira-integration for <codeLanguage> added with EDP version using clone strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    And User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using edp versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | startFromVersion  | 1.2.3               |
      | startFromSnapshot | SNAPSHOT            |
      | jiraIntegration   | True                |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    When User creates new branch with edp versioning type in <applicationName> application
      | newBranchName     | <newBranchName> |
      | startFromVersion  | 3.5.7           |
      | StartFromSnapshot | NEW             |
    And User creates pull request to "<newBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User checks Jira ticket fields
      | applicationName | <applicationName> |
      | version         | build/3.5.7-NEW.1 |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @UI @TektonGithubUI @TektonJiraGithubUI
    Examples:
      | applicationName             | codeLanguage  | defaultBranchName | newBranchName |
      | js-react-clone-edp-lib-jira | react_library | master            | new           |
