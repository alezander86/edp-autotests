Feature: Promote applications added using Import strategy GitLab

  Scenario Outline: Deploy and promote application added using Import strategy with Default versioning type
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using edp versioning type on gitlab
      | applicationName   | <autotestName>         |
      | codeLanguage      | <autotestCodeLanguage> |
      | defaultBranchName | <defaultBranchName>    |
      | startFromVersion  | 1.2.3                  |
      | startFromSnapshot | SNAPSHOT               |
    Then User sees success status and correct values in fields for <autotestName> application
      | codeLanguage | <autotestCodeLanguage> |
      | ciTool       | Tekton                 |
    When User imports codebase using default versioning type on gitlab
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
      | applicationName           | <applicationName>   |
      | newBranchName             | <newBranchName>     |
      | clusterName               | in-cluster          |
      | stageName                 | <stageName>         |
      | qualityGates              | True                |
      | qualityGatesName          | autotest            |
      | qualityGatesProject       | <autotestName>      |
      | qualityGatesProjectBranch | <defaultBranchName> |
    And User waits till <pipelineName> pipeline with <stageName> stage will be created
    Then User sees success status for <pipelineName> pipeline
    When User opens <pipelineName> pipeline
    Then User sees success status for <stageName> stage
    When User opens <stageName> stage
    And User deploys <applicationName> application with saved image version
    Then User waits till <applicationName> application will be deployed with success status
    When User promotes application using autotests
    Then User checks autotestRunner autotest pipeline status for "<stageName>" stage in "<pipelineName>" pipeline
    And User checks promoted image for <applicationName> application for <stageName> stage <pipelineName> pipeline
    And User checks that promoted image available in image stream version popup for <applicationName> application
    And User uninstalls <applicationName> application
    And User deletes <pipelineName> cd pipeline
    And User deletes application with name <applicationName>
    And User deletes application with name <autotestName>

    @UI @TektonGitlabUI @TektonGitlabPromoteUI
    Examples:
      | applicationName        | defaultBranchName | codeLanguage           | newBranchName | pipelineName           | stageName | autotestName    | autotestCodeLanguage  |
      | dotnet6-app-ui-promote | master            | dotnet_6_0_application | new           | dotnet6-deploy-promote | dev       | java17-mvn-test | java17_maven_autotest |

