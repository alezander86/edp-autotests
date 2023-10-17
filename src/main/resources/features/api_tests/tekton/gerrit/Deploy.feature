Feature: Deploy

  Scenario Outline: Check pipelines for release branch of <codeLanguage> and deploy with edp version using create strategy
    Given User creates edp codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new release branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    When User creates cd pipeline <pipelineNane> with deployment type container
      | applicationName | <applicationName> |
      | branchName      | <newBranchName>   |
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
    @TektonGerrit @TektonGerritRelease @TektonGerritDeploy @TektonSmoke
    Examples:
      | applicationName        | codeLanguage              | newBranchName | startFrom      | newBranchVersion | pipelineNane      | stageName | imageVersion |
      | java17-grd-crt-edp-dep | java17_gradle_application | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         | java17-grd-deploy | sit       | 1.2.3-RC.1   |

  Scenario Outline: Check pipelines for <codeLanguage> and deploy with default version using clone strategy
    Given User clones default codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    When User creates change in "<defaultBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    When User makes merge request in gerrit
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
    @TektonGerrit @TektonGerritRelease @TektonClone @TektonGerritDeploy
    Examples:
      | applicationName       | codeLanguage        | pipelineNane   | stageName | defaultBranchName |
      | angular-clone-def-dep | angular_application | angular-deploy | sit       | master            |