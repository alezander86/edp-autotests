Feature: Jira_integration

  Scenario Outline: Create epam-jira-user in namespace for Jira integration
    Given User creates "<secretName>" jira-user with following values
    Examples:
      | secretName |
      | jira-user  |

  Scenario Outline: Create JiraServer for Jira integration
    Given User creates Jira server with following values
      | jiraServerName   | apiUrl   | rootUrl   | credentialName   |
      | <jiraServerName> | <apiUrl> | <rootUrl> | <credentialName> |
    And User checks "<jiraServerName>" jira server status
    Examples:
      | jiraServerName | apiUrl                      | rootUrl                     | credentialName |
      | epam-jira      | https://jiraeu-api.epam.com | https://jiraeu-api.epam.com | epam-jira-user |