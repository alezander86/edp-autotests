Feature: Edit component features gitlab

  Scenario Outline: Edit created component
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on gitlab
      | applicationName   | <applicationName> |
      | codeLanguage      | <codeLanguage>    |
      | defaultBranchName | master            |
    And User edits <applicationName> application with parameters
      | commitMessagePattern  | <commitMessagePattern>  |
      | jiraServer            | epam-jira               |
      | ticketNamePattern     | <ticketNamePattern>     |
      | componentJiraPattern  | <componentJiraPattern>  |
      | fixVersionJiraPattern | <fixVersionJiraPattern> |
      | labelJiraPattern      | <labelJiraPattern>      |
    And User select created application <applicationName> name
    And User click on the Edit button for the selected application
    Then User checks entered data on the edit application popup
      | applicationName       | <applicationName>       |
      | commitMessagePattern  | <commitMessagePattern>  |
      | jiraServer            | epam-jira               |
      | ticketNamePattern     | <ticketNamePattern>     |
      | componentJiraPattern  | <componentJiraPattern>  |
      | fixVersionJiraPattern | <fixVersionJiraPattern> |
      | labelJiraPattern      | <labelJiraPattern>      |
    And User deletes application with name <applicationName>
    @UI @TektonGitlabUI @EditComponentGitlab
    Examples:
      | applicationName             | codeLanguage       | commitMessagePattern    | ticketNamePattern | componentJiraPattern | fixVersionJiraPattern    | labelJiraPattern |
      | python38-lib-component-edit | python_3_8_library | ^\[TEST-\d{4}\]:test:.* | EPMDEDPSUP-\d{4}  | EDP_COMPONENT        | EDP_GITTAG-EDP_COMPONENT | EDP_COMPONENT    |

  Scenario Outline: Edit created pipeline and stage
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on gitlab
      | applicationName   | <applicationName> |
      | codeLanguage      | <codeLanguage>    |
      | defaultBranchName | <defaultBranch>   |
    And User opens EDP Components tab
    And User creates codebase using default versioning type on gitlab
      | applicationName   | <secondApplicationName> |
      | codeLanguage      | <codeLanguage>          |
      | defaultBranchName | <secondDefaultBranch>   |
    And User opens EDP Environments tab
    And User creates pipeline <pipelineName> with deployment type container
      | applicationName | <applicationName> |
      | newBranchName   | <defaultBranch>   |
      | clusterName     | in-cluster        |
      | stageName       | <stageName>       |
    And User waits till <pipelineName> pipeline with <stageName> stage will be created
    Then User sees success status for <pipelineName> pipeline
    When User edits <pipelineName> CD pipeline with parameters
      | applicationName       | <applicationName>       |
      | secondApplicationName | <secondApplicationName> |
      | secondDefaultBranch   | <secondDefaultBranch>   |
    Then User sees added applications in the applications field on environments screen
      | applicationName       | <applicationName>       |
      | secondApplicationName | <secondApplicationName> |
    When User opens <pipelineName> pipeline
    And User click on the Edit button for the selected pipeline
    Then User checks entered data on the edit pipeline popup
      | pipelineName          | <pipelineName>          |
      | applicationName       | <applicationName>       |
      | secondApplicationName | <secondApplicationName> |
      | defaultBranch         | <defaultBranch>         |
      | secondDefaultBranch   | <secondDefaultBranch>   |
    And User sees that manual trigger type is displayed for <stageName> stage
    When User edits <stageName> stage in <pipelineName> pipeline with parameters
      | triggerType | Auto |
    Then User sees that auto trigger type is displayed for <stageName> stage
    When User opens <stageName> stage
    And User click on the Edit button for the selected stage
    Then User checks entered data on the edit stage popup
      | stageName    | <stageName>    |
      | pipelineName | <pipelineName> |
      | triggerType  | Auto           |
    And User sees added applications on the selected stage screen
      | applicationName       | <applicationName>       |
      | secondApplicationName | <secondApplicationName> |
    And User deletes <pipelineName> cd pipeline
    And User deletes application with name <applicationName>
    And User deletes application with name <secondApplicationName>
    @UI @TektonGitlabUI @EditPipelineStageGitlab
    Examples:
      | applicationName                  | secondApplicationName               | codeLanguage              | pipelineName       | stageName | defaultBranch | secondDefaultBranch |
      | java17gr-app-pipeline-stage-edit | java17gr-sc-app-pipeline-stage-edit | java17_gradle_application | java17gr-test-pipe | dev       | main          | master              |
