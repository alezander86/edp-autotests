Feature: Deploy

  Scenario Outline: Deploy <codeLanguage> from release branch with EDP version using Create strategy
    Given User creates edp codebase on gerrit for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
#    Then User stop "<jobName>" build in "<applicationName>" jenkins folder
    #    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    When User creates new release branch
      | applicationName  | <applicationName>      |
      | branchName       | <releaseBranchName>    |
      | newBranchVersion | <releaseBranchVersion> |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    And User creates cd pipeline <cdPipelineName> with deployment type <deploymentType>
      | applicationName | <applicationName>   |
      | branchName      | <releaseBranchName> |
    And User creates stage <name> in cd pipeline <cdPipelineName>
      | applications    | <applicationName>    |
      | triggerType     | <triggerType>        |
      | jobProvisioning | <cdpJobProvisioning> |
      | source          | <sourceType>         |
      | qualityGateType | <qualityGateType>    |
      | stepName        | <stepName>           |
    Then User checks "<releaseJobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<releaseCodebaseBranchName>" branch build status
    And User checks "<releaseCodebaseBranchName>" branch last successful build status
    And User checks "<releaseImageStream>" codebase image stream "<annotation>" tag
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
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @Deploy @DeployRelease @PythonCreate @PythonDeployReleaseCreate @PythonRegression @Regression
    Examples:
      | applicationName                  | codeLanguage           | releaseBranchName | startFrom      | releaseBranchVersion | releaseCodebaseBranchName                    | createReleaseJob                                | releaseJobName                                     | deploymentType | inputDockerStream                            | releaseImageStream                           | cdPipelineName | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName | sourceType | stepName | cdPipelinejenkinsFolder    | annotation |
      | python-3-8-release-create-deploy | python_3_8_application | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | python-3-8-release-create-deploy-release-1.2 | Create-release-python-3-8-release-create-deploy | RELEASE-1.2-Build-python-3-8-release-create-deploy | container      | python-3-8-release-create-deploy-release/1.2 | python-3-8-release-create-deploy-release-1-2 | release-python | sit         | default            | sit  | manual          | manual      | release-python-sit  | default    | approve  | release-python-cd-pipeline | 1.2.3-RC.1 |


  Scenario Outline: Deploy <codeLanguage> with EDP version using Clone strategy
    Given User clones edp codebase on gerrit for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
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
    And User checks "<codebaseBranchName>" branch build status
    And User checks "<codebaseBranchName>" branch last successful build status
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
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @Deploy @DeployEDP @Java11Clone @Java11DeployCloneEDP @Java11Regression @Regression
    Examples:
      | applicationName               | codeLanguage             | startFrom      | codebaseBranchName                   | createReleaseJob                             | jobName                                    | deploymentType | inputDockerStream                    | cdPipelineName         | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName        | sourceType | stepName | cdPipelinejenkinsFolder            | annotation       |
      | java11-maven-clone-deploy-edp | java11_maven_application | 1.2.3-SNAPSHOT | java11-maven-clone-deploy-edp-master | Create-release-java11-maven-clone-deploy-edp | MASTER-Build-java11-maven-clone-deploy-edp | container      | java11-maven-clone-deploy-edp-master | clone-edp-java11-maven | sit         | default            | sit  | manual          | manual      | clone-edp-java11-maven-sit | default    | approve  | clone-edp-java11-maven-cd-pipeline | 1.2.3-SNAPSHOT.1 |
    @JenkinsCriticalPath @Deploy @DeployEDP @Java11Clone @Java11DeployCloneEDP @Java11Regression @Regression
    Examples:
      | applicationName                | codeLanguage                   | startFrom      | codebaseBranchName                    | createReleaseJob                              | jobName                                     | deploymentType | inputDockerStream                     | cdPipelineName          | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName         | sourceType | stepName | cdPipelinejenkinsFolder             | annotation       |
      | java11-gradle-clone-deploy-edp | java11_gradle_application      | 1.2.3-SNAPSHOT | java11-gradle-clone-deploy-edp-master | Create-release-java11-gradle-clone-deploy-edp | MASTER-Build-java11-gradle-clone-deploy-edp | container      | java11-gradle-clone-deploy-edp-master | clone-edp-java11-gradle | sit         | default            | sit  | manual          | manual      | clone-edp-java11-gradle-sit | default    | approve  | clone-edp-java11-gradle-cd-pipeline | 1.2.3-SNAPSHOT.1 |
      | java11-mult-clone-deploy-edp   | java11_multimodule_application | 1.2.3-SNAPSHOT | java11-mult-clone-deploy-edp-master   | Create-release-java11-mult-clone-deploy-edp   | MASTER-Build-java11-mult-clone-deploy-edp   | container      | java11-mult-clone-deploy-edp-master   | clone-edp-java11-mult   | sit         | default            | sit  | manual          | manual      | clone-edp-java11-mult-sit   | default    | approve  | clone-edp-java11-mult-cd-pipeline   | 1.2.3-SNAPSHOT.1 |

  Scenario Outline: Deploy <codeLanguage> from new branch with EDP version using Clone strategy
    Given User clones edp codebase on gerrit for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
#    Then User stop "<jobNameDefault>" build in "<applicationName>" jenkins folder
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
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
    And User checks "<newCodebaseBranchName>" branch build status
    And User checks "<newCodebaseBranchName>" branch last successful build status
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
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @Deploy @DeployBranchEDP @Java11Clone @Java11DeployBranchCloneEDP @Java11Regression @Regression
    Examples:
      | applicationName                   | codeLanguage              | newBranchName | startFrom      | newBranchVersion   | newCodebaseBranchName                 | createReleaseJob                                 | jobName                                     | deploymentType | inputDockerStream                     | cdPipelineName             | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName            | sourceType | stepName | cdPipelinejenkinsFolder                | annotation           |
      | java11-gradle-br-clone-deploy-edp | java11_gradle_application | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | java11-gradle-br-clone-deploy-edp-new | Create-release-java11-gradle-br-clone-deploy-edp | NEW-Build-java11-gradle-br-clone-deploy-edp | container      | java11-gradle-br-clone-deploy-edp-new | br-clone-edp-java11-gradle | sit         | default            | sit  | manual          | manual      | br-clone-edp-java11-gradle-sit | default    | approve  | br-clone-edp-java11-gradle-cd-pipeline | 1.2.3-NEW-SNAPSHOT.1 |
    @JenkinsCriticalPath @Deploy @DeployBranchEDP @Java11Clone @Java11DeployBranchCloneEDP @Java11Regression @Regression
    Examples:
      | applicationName                  | codeLanguage                   | newBranchName | startFrom      | newBranchVersion   | newCodebaseBranchName                | createReleaseJob                                | jobName                                    | deploymentType | inputDockerStream                    | cdPipelineName            | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName           | sourceType | stepName | cdPipelinejenkinsFolder               | annotation           |
      | java11-maven-br-clone-deploy-edp | java11_maven_application       | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | java11-maven-br-clone-deploy-edp-new | Create-release-java11-maven-br-clone-deploy-edp | NEW-Build-java11-maven-br-clone-deploy-edp | container      | java11-maven-br-clone-deploy-edp-new | br-clone-edp-java11-maven | sit         | default            | sit  | manual          | manual      | br-clone-edp-java11-maven-sit | default    | approve  | br-clone-edp-java11-maven-cd-pipeline | 1.2.3-NEW-SNAPSHOT.1 |
      | java11-mult-br-clone-deploy-edp  | java11_multimodule_application | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | java11-mult-br-clone-deploy-edp-new  | Create-release-java11-mult-br-clone-deploy-edp  | NEW-Build-java11-mult-br-clone-deploy-edp  | container      | java11-mult-br-clone-deploy-edp-new  | br-clone-edp-java11-mult  | sit         | default            | sit  | manual          | manual      | br-clone-edp-java11-mult-sit  | default    | approve  | br-clone-edp-java11-mult-cd-pipeline  | 1.2.3-NEW-SNAPSHOT.1 |


  Scenario Outline: Deploy <codeLanguage> from release branch with EDP version using Clone strategy
    Given User clones edp codebase on gerrit for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
#    Then User stop "<jobName>" build in "<applicationName>" jenkins folder
#    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    When User creates new release branch
      | applicationName  | <applicationName>      |
      | branchName       | <releaseBranchName>    |
      | newBranchVersion | <releaseBranchVersion> |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    And User creates cd pipeline <cdPipelineName> with deployment type <deploymentType>
      | applicationName | <applicationName>   |
      | branchName      | <releaseBranchName> |
    And User creates stage <name> in cd pipeline <cdPipelineName>
      | applications    | <applicationName>    |
      | triggerType     | <triggerType>        |
      | jobProvisioning | <cdpJobProvisioning> |
      | source          | <sourceType>         |
      | qualityGateType | <qualityGateType>    |
      | stepName        | <stepName>           |
    Then User checks "<releaseJobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<releaseCodebaseBranchName>" branch build status
    And User checks "<releaseCodebaseBranchName>" branch last successful build status
    And User checks "<releaseImageStream>" codebase image stream "<annotation>" tag
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
    @JenkinsCriticalPath @JenkinsMiniCriticalPath  @Deploy @DeployRelease @Java8Clone @Java8DeployReleaseClone @Java8Regression @Regression
    Examples:
      | applicationName                  | codeLanguage            | releaseBranchName | startFrom      | releaseBranchVersion | releaseCodebaseBranchName                    | createReleaseJob                                | releaseJobName                                     | deploymentType | inputDockerStream                            | releaseImageStream                           | cdPipelineName            | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName           | sourceType | stepName | cdPipelinejenkinsFolder               | annotation |
      | java8-maven-release-clone-deploy | java8_maven_application | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | java8-maven-release-clone-deploy-release-1.2 | Create-release-java8-maven-release-clone-deploy | RELEASE-1.2-Build-java8-maven-release-clone-deploy | container      | java8-maven-release-clone-deploy-release/1.2 | java8-maven-release-clone-deploy-release-1-2 | release-clone-java8-maven | sit         | default            | sit  | manual          | manual      | release-clone-java8-maven-sit | default    | approve  | release-clone-java8-maven-cd-pipeline | 1.2.3-RC.1 |
    @JenkinsCriticalPath  @Deploy @DeployRelease @Java8Clone @Java8DeployReleaseClone @Java8Regression @Regression
    Examples:
      | applicationName                   | codeLanguage             | releaseBranchName | startFrom      | releaseBranchVersion | releaseCodebaseBranchName                     | createReleaseJob                                 | releaseJobName                                      | deploymentType | inputDockerStream                             | releaseImageStream                            | cdPipelineName         | description | cdpJobProvisioning | name | qualityGateType | triggerType | cdPipelineStageName        | sourceType | stepName | cdPipelinejenkinsFolder            | annotation |
      | java8-gradle-release-clone-deploy | java8_gradle_application | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | java8-gradle-release-clone-deploy-release-1.2 | Create-release-java8-gradle-release-clone-deploy | RELEASE-1.2-Build-java8-gradle-release-clone-deploy | container      | java8-gradle-release-clone-deploy-release/1.2 | java8-gradle-release-clone-deploy-release-1-2 | release-clone-java8-gr | sit         | default            | sit  | manual          | manual      | release-clone-java8-gr-sit | default    | approve  | release-clone-java8-gr-cd-pipeline | 1.2.3-RC.1 |

