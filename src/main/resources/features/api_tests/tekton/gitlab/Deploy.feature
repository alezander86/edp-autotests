Feature: Deploy

  Scenario Outline: Check pipelines for <codeLanguage> and deploy with edp version using create strategy
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User imports edp codebase from gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates pull request from "<defaultBranchName>" ref branch to "<defaultBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    When User creates cd pipeline <pipelineNane> with deployment type container
      | applicationName | <applicationName>   |
      | branchName      | <defaultBranchName> |
    And User creates stage <stageName> in cd pipeline <pipelineNane>
      | applications    | <applicationName> |
      | triggerType     | Manual            |
      | jobProvisioning | default           |
      | source          | default           |
      | qualityGateType | manual            |
      | stepName        | manual            |
    And User deploys application using created image edp versioning type
      | applicationName | <applicationName> |
      | pipelineNane    | <pipelineNane>    |
      | stageName       | <stageName>       |
      | imageVersion    | <imageVersion>    |
    And User deletes <applicationName> application
    And User deletes <pipelineNane>-<stageName> cd pipeline stage resources
    And User deletes <pipelineNane> cd pipeline resources
    And User deletes "<applicationName>" codebase resources
    @TektonGitlab @TektonImport @TektonGitlabDeploy
    Examples:
      | applicationName         | codeLanguage      | startFrom      | pipelineNane | stageName | imageVersion     | defaultBranchName |
      | go-beego-import-edp-dep | beego_application | 1.2.3-SNAPSHOT | beego-deploy | sit       | 1.2.3-SNAPSHOT.1 | master            |

  Scenario Outline: Check pipelines for <codeLanguage> and deploy with default version using clone strategy
    Given User creates default codebase on gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    When User receive and save GitLab project ID for project <applicationName>
    When User creates pull request from "<defaultBranchName>" ref branch to "<defaultBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    When User creates cd pipeline <pipelineNane> with deployment type container
      | applicationName | <applicationName>   |
      | branchName      | <defaultBranchName> |
    And User creates stage <stageName> in cd pipeline <pipelineNane>
      | applications    | <applicationName> |
      | triggerType     | Manual            |
      | jobProvisioning | default           |
      | source          | default           |
      | qualityGateType | manual            |
      | stepName        | manual            |
    And User deploys application using created image default versioning type
      | applicationName | <applicationName> |
      | pipelineNane    | <pipelineNane>    |
      | stageName       | <stageName>       |
    And User deletes <applicationName> application
    And User deletes <pipelineNane>-<stageName> cd pipeline stage resources
    And User deletes <pipelineNane> cd pipeline resources
    And User deletes "<applicationName>" codebase resources
    @TektonGitlab @TektonClone @TektonGitlabDeploy
    Examples:
      | applicationName          | codeLanguage            | pipelineNane     | stageName | defaultBranchName |
      | java8-mvn-create-def-dep | java8_maven_application | java8-mvn-deploy | sit       | master            |