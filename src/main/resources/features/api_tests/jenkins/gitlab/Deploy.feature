Feature: Deploy

  Scenario Outline: Deploy <codeLanguage> with Default version using Import strategy (Gitlab)
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    Given User imports default codebase from gitlab for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    And User creates cd pipeline <cdPipelineName> with deployment type <deploymentType>
      | applicationName | <applicationName> |
      | branchName      | master            |
    And User creates stage <name> in cd pipeline <cdPipelineName>
      | applications    | <applicationName>    |
      | triggerType     | <triggerType>        |
      | jobProvisioning | <cdpJobProvisioning> |
      | source          | <sourceType>         |
      | qualityGateType | <qualityGateType>    |
      | stepName        | <stepName>           |
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<codebaseBranchName>" codebase image stream "<annotation>" tag
    And User triggers "<name>" job in "<cdPipelinejenkinsFolder>" jenkins folder
    And User collects parameters for deploy
      | name   | cdPipelinejenkinsFolder   |
      | <name> | <cdPipelinejenkinsFolder> |
    And User set parameters for deploy "<name>" job in "<cdPipelinejenkinsFolder>" jenkins folder
    And User checks "<annotation>" annotation in "<cdPipelineStageName>" cd stage
    And User collects parameters for promote
      | name   | cdPipelinejenkinsFolder   |
      | <name> | <cdPipelinejenkinsFolder> |
    And User approve quality gate
      | name   | cdPipelinejenkinsFolder   |
      | <name> | <cdPipelinejenkinsFolder> |
    Then User checks "<name>" build  status in "<cdPipelinejenkinsFolder>" jenkins folder
    And User deletes <cdPipelineName>-<name> cd pipeline stage resources
    And User deletes <cdPipelineName> cd pipeline resources
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @Deploy @DeployDefault @JavaScriptGitlab @JavaScriptDeployGitlabDefault @JavaScriptRegression @Regression
    Examples:
      | applicationName  | codeLanguage      | codebaseBranchName      | createReleaseJob                | jobName                       | deploymentType | inputDockerStream       | cdPipelineName | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName | sourceType | stepName | cdPipelinejenkinsFolder | annotation     |
      | js-deploy-gitlab | react_application | js-deploy-gitlab-master | Create-release-js-deploy-gitlab | MASTER-Build-js-deploy-gitlab | container      | js-deploy-gitlab-master | gitlab-js      | sit         | default            | sit  | manual          | manual      | gitlab-js-sit       | default    | approve  | gitlab-js-cd-pipeline   | master-0.1.0-1 |


  Scenario Outline: Deploy <codeLanguage> from new branch with Default version using Import strategy (Gitlab)
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    Given User imports default codebase from gitlab for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
#    Then User stop "<jobNameDefault>" build in "<applicationName>" jenkins folder
    When User creates new branch
      | applicationName | <applicationName> |
      | branchName      | <newBranchName>   |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    And User creates cd pipeline <cdPipelineName> with deployment type <deploymentType>
      | applicationName | <applicationName> |
      | branchName      | <newBranchName>   |
    And User creates stage <name> in cd pipeline <cdPipelineName>
      | applications    | <applicationName>    |
      | triggerType     | <triggerType>        |
      | jobProvisioning | <cdpJobProvisioning> |
      | source          | <sourceType>         |
      | qualityGateType | <qualityGateType>    |
      | stepName        | <stepName>           |
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<newCodebaseBranchName>" codebase image stream "<annotation>" tag
    And User triggers "<name>" job in "<cdPipelinejenkinsFolder>" jenkins folder
    And User collects parameters for deploy
      | name   | cdPipelinejenkinsFolder   |
      | <name> | <cdPipelinejenkinsFolder> |
    And User set parameters for deploy "<name>" job in "<cdPipelinejenkinsFolder>" jenkins folder
    And User checks "<annotation>" annotation in "<cdPipelineStageName>" cd stage
    And User collects parameters for promote
      | name   | cdPipelinejenkinsFolder   |
      | <name> | <cdPipelinejenkinsFolder> |
    And User approve quality gate
      | name   | cdPipelinejenkinsFolder   |
      | <name> | <cdPipelinejenkinsFolder> |
    Then User checks "<name>" build  status in "<cdPipelinejenkinsFolder>" jenkins folder
    And User deletes <cdPipelineName>-<name> cd pipeline stage resources
    And User deletes <cdPipelineName> cd pipeline resources
    And User deletes "<applicationName>" codebase resources
#    And User deletes "<tagName>" tag from Gitlab project "<id>" id
#    And User deletes "<tagName1>" tag from Gitlab project "<id>" id
    And User deletes gitlab fork project
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @Deploy @DeployBranchDefault @JavaScriptGitlab @JavaScriptDeployBranchGitlabDefault @JavaScriptRegression @Regression
    Examples:
      | applicationName     | codeLanguage      | newBranchName | newCodebaseBranchName   | createReleaseJob                   | jobName                       | deploymentType | inputDockerStream       | cdPipelineName | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName | sourceType | stepName | cdPipelinejenkinsFolder  | annotation  |
      | js-br-deploy-gitlab | react_application | new           | js-br-deploy-gitlab-new | Create-release-js-br-deploy-gitlab | NEW-Build-js-br-deploy-gitlab | container      | js-br-deploy-gitlab-new | br-gitlab-js   | sit         | default            | sit  | manual          | manual      | br-gitlab-js-sit    | default    | approve  | br-gitlab-js-cd-pipeline | new-0.1.0-1 |
    