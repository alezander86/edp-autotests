Feature: Deploy

  Scenario Outline: Check pipelines for <codeLanguage> and deploy with default version using create strategy
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    And User imports default codebase from github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    When User creates pull request to "<defaultBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
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
    @TektonGithub @TektonImport @TektonGithubDeploy @TektonGithubShortRegression
    Examples:
      | applicationName        | codeLanguage           | pipelineNane   | stageName | defaultBranchName |
      | dotnet6-import-def-dep | dotnet_6_0_application | dotnet6-deploy | sit       | master            |

  Scenario Outline: Check pipelines for <codeLanguage> and deploy with edp version using clone strategy
    Given User clones edp codebase on github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates pull request to "<defaultBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
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
    @TektonGithub @TektonClone @TektonGithubDeploy @TektonGithubShortRegression
    Examples:
      | applicationName          | codeLanguage           | startFrom      | pipelineNane      | stageName | imageVersion     | defaultBranchName |
      | python-3-8-clone-edp-dep | python_3_8_application | 1.2.3-SNAPSHOT | python-3-8-deploy | sit       | 1.2.3-SNAPSHOT.1 | master            |