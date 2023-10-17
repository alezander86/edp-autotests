Feature: Deploy applications added using Create and Clone strategy Gerrit

  Scenario Outline: Deploy application added using Create strategy with default versioning type
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on gerrit
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    When User creates new branch with default versioning type in <applicationName> application
      | newBranchName | <newBranchName> |
    And User triggers build pipeline for <newBranchName> branch name
    Then User checks build pipeline status submitted manually for "<newBranchName>" branch in "<applicationName>" codebase
    And User checks build pipeline status in headlamp for <newBranchName> branch in <applicationName> codebase
    When User saves the image version in memory for <applicationName> application
    And User opens EDP Environments tab
    And User creates pipeline <pipelineName> with deployment type container
      | applicationName | <applicationName> |
      | newBranchName   | <newBranchName>   |
      | clusterName     | in-cluster        |
      | stageName       | <stageName>       |
    And User waits till <pipelineName> pipeline with <stageName> stage will be created
    Then User sees success status for <pipelineName> pipeline
    When User opens <pipelineName> pipeline
    Then User sees success status for <stageName> stage
    When User opens <stageName> stage
    And User deploys <applicationName> application with saved image version
    Then User waits till <applicationName> application will be deployed with success status
    And User checks logs and terminal popups for <applicationName> application <pipelineName> pipeline <stageName> stage
    And User uninstalls <applicationName> application
    And User deletes <pipelineName> cd pipeline
    And User deletes application with name <applicationName>

    @UI @TektonGerritUI @TektonGerritDeployUI
    Examples:
      | applicationName           | defaultBranchName | codeLanguage        | newBranchName | pipelineName      | stageName |
      | js-exp-app-crt-def-dep-ui | master            | express_application | new           | js-express-deploy | sit       |

  Scenario Outline: Deploy application added using Clone strategy with EDP versioning type release branch
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using edp versioning type on gerrit
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | startFromVersion  | 1.2.3               |
      | startFromSnapshot | SNAPSHOT            |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    When User creates new branch with edp versioning type in <applicationName> application
      | newBranchName     | <newBranchName> |
      | startFromVersion  | 2.3.4           |
      | StartFromSnapshot | RC              |
      | realiseBranch     | True            |
    Then User sees created <newBranchName> branch as release
    When User triggers build pipeline for <newBranchName> branch name
    Then User checks build pipeline status submitted manually for "<newBranchNameFormatted>" branch in "<applicationName>" codebase
    And User checks build pipeline status in headlamp for <newBranchName> branch in <applicationName> codebase
    When User saves the image version in memory for <applicationName> application
    And User opens EDP Environments tab
    And User creates pipeline <pipelineName> with deployment type container
      | applicationName | <applicationName> |
      | newBranchName   | <newBranchName>   |
      | clusterName     | in-cluster        |
      | stageName       | <stageName>       |
    And User waits till <pipelineName> pipeline with <stageName> stage will be created
    Then User sees success status for <pipelineName> pipeline
    When User opens <pipelineName> pipeline
    Then User sees success status for <stageName> stage
    When User opens <stageName> stage
    And User deploys <applicationName> application with saved image version
    Then User waits till <applicationName> application will be deployed with success status
    And User uninstalls <applicationName> application
    And User deletes <pipelineName> cd pipeline
    And User deletes application with name <applicationName>

    @UI @TektonGerritUI @TektonGerritDeployUI
    Examples:
      | applicationName          | defaultBranchName | codeLanguage      | newBranchName | pipelineName | stageName | newBranchNameFormatted |
      | beego-app-cln-edp-dep-ui | master            | beego_application | release/2.3   | beego-deploy | dev       | release-2.3            |

