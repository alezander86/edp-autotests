Feature: Jira

  Scenario Outline: Check Jira-integration for <codeLanguage> added with Default version using Create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User creates default codebase on gerrit for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<codebaseBranchName>" codebase image stream "<imageStreamTag>" tag
    And User creates change in "<branchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder

    And User makes merge request in gerrit
    Then User checks "<jobName>" second build  status in "<applicationName>" jenkins folder
    And User checks "<codebaseBranchName>" codebase image stream "<imageStreamTag1>" second tag
    And User checks Jira ticket fields
      | applicationName | <applicationName> |
      | version         | 1.0.0             |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationDefault @PythonCreate @PythonJiraCreateDefault @Regression
    Examples:
      | applicationName                | codeLanguage       | branchName | codebaseBranchName                    | createReleaseJob                              | jobName                                     | codeReviewJob                                     | imageStreamTag | imageStreamTag1 |
      | python-3-8-lib-create-def-jira | python_3_8_library | master     | python-3-8-lib-create-def-jira-master | Create-release-python-3-8-lib-create-def-jira | MASTER-Build-python-3-8-lib-create-def-jira | MASTER-Code-review-python-3-8-lib-create-def-jira | master-1.0.0-1 | master-1.0.0-2  |


  Scenario Outline: Check Jira-integration for <codeLanguage> added with EDP version using Create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User creates edp codebase on gerrit for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<codebaseBranchName>" branch build status
    And User checks "<codebaseBranchName>" branch last successful build status
    And User creates change in "<branchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder

    And User makes merge request in gerrit
    Then User checks "<jobName>" second build  status in "<applicationName>" jenkins folder
    And User checks Jira ticket fields
      | applicationName | <applicationName> |
      | version         | 1.2.3-SNAPSHOT    |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationEDP @JavaScriptCreate @JavaScriptJiraCreateEDP @Regression
    Examples:
      | applicationName        | codeLanguage  | branchName | startFrom      | codebaseBranchName            | createReleaseJob                      | jobName                             | codeReviewJob                             |
      | js-lib-create-edp-jira | react_library | master     | 1.2.3-SNAPSHOT | js-lib-create-edp-jira-master | Create-release-js-lib-create-edp-jira | MASTER-Build-js-lib-create-edp-jira | MASTER-Code-review-js-lib-create-edp-jira |
    @JenkinsCriticalPath @JiraIntegration @JiraIntegrationEDP @JavaScriptCreate @JavaScriptJiraCreateEDP @Regression
    Examples:
      | applicationName    | codeLanguage      | branchName | startFrom      | codebaseBranchName        | createReleaseJob                  | jobName                         | codeReviewJob                         |
      | js-create-edp-jira | react_application | master     | 1.2.3-SNAPSHOT | js-create-edp-jira-master | Create-release-js-create-edp-jira | MASTER-Build-js-create-edp-jira | MASTER-Code-review-js-create-edp-jira |


  Scenario Outline: Check Jira-integration for new branch of <codeLanguage> with Default version using Create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User creates default codebase on gerrit for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    When User creates new branch
      | applicationName | <applicationName> |
      | branchName      | <newBranchName>   |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    Then User checks "<jobNameDefault>" build  status in "<applicationName>" jenkins folder
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<newCodebaseBranchName>" codebase image stream "<imageStreamTag>" tag
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder

    And User makes merge request in gerrit
    Then User checks "<jobName>" second build  status in "<applicationName>" jenkins folder
    And User checks "<newCodebaseBranchName>" codebase image stream "<imageStreamTag1>" second tag
    And User checks Jira ticket fields
      | applicationName | <applicationName> |
      | version         | 1.0.0             |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationBranchDefault @PythonCreate @PythonJiraBranchCreateDefault @Regression
    Examples:
      | applicationName                   | codeLanguage       | newBranchName | newCodebaseBranchName                 | createReleaseJob                                 | jobNameDefault                                 | jobName                                     | codeReviewJob                                     | imageStreamTag | imageStreamTag1 |
      | python-3-8-lib-br-create-def-jira | python_3_8_library | new           | python-3-8-lib-br-create-def-jira-new | Create-release-python-3-8-lib-br-create-def-jira | MASTER-Build-python-3-8-lib-br-create-def-jira | NEW-Build-python-3-8-lib-br-create-def-jira | NEW-Code-review-python-3-8-lib-br-create-def-jira | new-1.0.0-1    | new-1.0.0-2     |


  Scenario Outline: Check Jira-integration for new branch of <codeLanguage> with EDP version using Create strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User creates edp codebase on gerrit for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    Then User checks "<jobNameDefault>" build  status in "<applicationName>" jenkins folder
    And User checks "<codebaseBranchName>" branch build status
    And User checks "<codebaseBranchName>" branch last successful build status
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<newCodebaseBranchName>" branch build status
    And User checks "<newCodebaseBranchName>" branch last successful build status
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder

    And User makes merge request in gerrit
    Then User checks "<jobName>" second build  status in "<applicationName>" jenkins folder
    And User checks Jira ticket fields
      | applicationName | <applicationName>  |
      | version         | <newBranchVersion> |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationBranchEDP @JavaScriptCreate @JavaScriptJiraBranchCreateEDP @Regression
    Examples:
      | applicationName       | codeLanguage      | newBranchName | startFrom      | newBranchVersion   | codebaseBranchName           | newCodebaseBranchName     | createReleaseJob                     | jobNameDefault                     | jobName                         | codeReviewJob                         |
      | js-br-create-edp-jira | react_application | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | js-br-create-edp-jira-master | js-br-create-edp-jira-new | Create-release-js-br-create-edp-jira | MASTER-Build-js-br-create-edp-jira | NEW-Build-js-br-create-edp-jira | NEW-Code-review-js-br-create-edp-jira |
    @JenkinsCriticalPath @JiraIntegration @JiraIntegrationBranchEDP @JavaScriptCreate @JavaScriptJiraBranchCreateEDP @Regression
    Examples:
      | applicationName           | codeLanguage  | newBranchName | startFrom      | newBranchVersion   | codebaseBranchName               | newCodebaseBranchName         | createReleaseJob                         | jobNameDefault                         | jobName                             | codeReviewJob                             |
      | js-lib-br-create-edp-jira | react_library | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | js-lib-br-create-edp-jira-master | js-lib-br-create-edp-jira-new | Create-release-js-lib-br-create-edp-jira | MASTER-Build-js-lib-br-create-edp-jira | NEW-Build-js-lib-br-create-edp-jira | NEW-Code-review-js-lib-br-create-edp-jira |


  Scenario Outline: Check Jira-integration for <codeLanguage> added with Default version using Clone strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User clones default codebase on gerrit for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<codebaseBranchName>" codebase image stream "<imageStreamTag>" tag
    And User creates change in "<branchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder

    And User makes merge request in gerrit
    Then User checks "<jobName>" second build  status in "<applicationName>" jenkins folder
    And User checks "<codebaseBranchName>" codebase image stream "<imageStreamTag1>" second tag
    And User checks Jira ticket fields
      | applicationName | <applicationName> |
      | version         | 1.0.0             |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationDefault @PythonClone @PythonJiraCloneDefault @Regression
    Examples:
      | applicationName           | codeLanguage           | branchName | codebaseBranchName               | createReleaseJob                         | jobName                                | codeReviewJob                                | imageStreamTag | imageStreamTag1 |
      | python-3-8-clone-def-jira | python_3_8_application | master     | python-3-8-clone-def-jira-master | Create-release-python-3-8-clone-def-jira | MASTER-Build-python-3-8-clone-def-jira | MASTER-Code-review-python-3-8-clone-def-jira | master-1.0.0-1 | master-1.0.0-2  |
    @JenkinsCriticalPath @JiraIntegration @JiraIntegrationDefault @PythonClone @PythonJiraCloneDefault @Regression
    Examples:
      | applicationName               | codeLanguage       | branchName | codebaseBranchName                   | createReleaseJob                             | jobName                                    | codeReviewJob                                    | imageStreamTag | imageStreamTag1 |
      | python-3-8-lib-clone-def-jira | python_3_8_library | master     | python-3-8-lib-clone-def-jira-master | Create-release-python-3-8-lib-clone-def-jira | MASTER-Build-python-3-8-lib-clone-def-jira | MASTER-Code-review-python-3-8-lib-clone-def-jira | master-1.0.0-1 | master-1.0.0-2  |


  Scenario Outline: Check Jira-integration for new branch of <codeLanguage> with Default version using Clone strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User clones default codebase on gerrit for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    When User creates new branch
      | applicationName | <applicationName> |
      | branchName      | <newBranchName>   |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    Then User checks "<jobNameDefault>" build  status in "<applicationName>" jenkins folder
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<newCodebaseBranchName>" codebase image stream "<imageStreamTag>" tag
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder

    And User makes merge request in gerrit
    Then User checks "<jobName>" second build  status in "<applicationName>" jenkins folder
    And User checks "<newCodebaseBranchName>" codebase image stream "<imageStreamTag1>" second tag
    And User checks Jira ticket fields
      | applicationName | <applicationName> |
      | version         | 1.0.0             |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationBranchDefault @PythonClone @PythonJiraBranchCloneDefault @Regression
    Examples:
      | applicationName                  | codeLanguage       | newBranchName | newCodebaseBranchName                | createReleaseJob                                | jobNameDefault                                | jobName                                    | codeReviewJob                                    | imageStreamTag | imageStreamTag1 |
      | python-3-8-lib-br-clone-def-jira | python_3_8_library | new           | python-3-8-lib-br-clone-def-jira-new | Create-release-python-3-8-lib-br-clone-def-jira | MASTER-Build-python-3-8-lib-br-clone-def-jira | NEW-Build-python-3-8-lib-br-clone-def-jira | NEW-Code-review-python-3-8-lib-br-clone-def-jira | new-1.0.0-1    | new-1.0.0-2     |
    @JenkinsCriticalPath @JiraIntegration @JiraIntegrationBranchDefault @PythonClone @PythonJiraBranchCloneDefault @Regression
    Examples:
      | applicationName              | codeLanguage           | newBranchName | newCodebaseBranchName            | createReleaseJob                            | jobNameDefault                            | jobName                                | codeReviewJob                                | imageStreamTag | imageStreamTag1 |
      | python-3-8-br-clone-def-jira | python_3_8_application | new           | python-3-8-br-clone-def-jira-new | Create-release-python-3-8-br-clone-def-jira | MASTER-Build-python-3-8-br-clone-def-jira | NEW-Build-python-3-8-br-clone-def-jira | NEW-Code-review-python-3-8-br-clone-def-jira | new-1.0.0-1    | new-1.0.0-2     |


  Scenario Outline: Check Jira-integration for new branch of <codeLanguage> with EDP version using Clone strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User clones edp codebase on gerrit for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
#    Then User checks "<jobNameDefault>" build  status in "<applicationName>" jenkins folder
    And User checks "<codebaseBranchName>" branch build status
    And User checks "<codebaseBranchName>" branch last successful build status
    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<newCodebaseBranchName>" branch build status
    And User checks "<newCodebaseBranchName>" branch last successful build status
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder

    And User makes merge request in gerrit
    Then User checks "<jobName>" second build  status in "<applicationName>" jenkins folder
    And User checks Jira ticket fields
      | applicationName | <applicationName>  |
      | version         | <newBranchVersion> |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @JiraIntegration @JiraIntegrationBranchEDP @Java8Clone @Java8JiraBranchCloneEDP @Regression
    Examples:
      | applicationName               | codeLanguage         | newBranchName | startFrom      | newBranchVersion   | codebaseBranchName                   | newCodebaseBranchName             | createReleaseJob                             | codeReviewJob                                 | jobName                                 |
      | java8-maven-auto-br-clone-edp | java8_maven_autotest | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | java8-maven-auto-br-clone-edp-master | java8-maven-auto-br-clone-edp-new | Create-release-java8-maven-auto-br-clone-edp | NEW-Code-review-java8-maven-auto-br-clone-edp | NEW-Build-java8-maven-auto-br-clone-edp |
    @JiraIntegration @JiraIntegrationBranchEDP @Java8Clone @Java8JiraBranchCloneEDP @Regression
    Examples:
      | applicationName                    | codeLanguage          | newBranchName | startFrom      | newBranchVersion   | codebaseBranchName                        | newCodebaseBranchName                  | createReleaseJob                                  | codeReviewJob                                      | jobName                                      |
      | autotests-gradle-br-clone-edp-jira | java8_gradle_autotest | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | autotests-gradle-br-clone-edp-jira-master | autotests-gradle-br-clone-edp-jira-new | Create-release-autotests-gradle-br-clone-edp-jira | NEW-Code-review-autotests-gradle-br-clone-edp-jira | NEW-Build-autotests-gradle-br-clone-edp-jira |

  Scenario Outline: Check Jira-integration for release branch of <codeLanguage> with EDP version using Clone strategy
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User clones edp codebase on gerrit for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
#    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    When User creates new release branch
      | applicationName  | <applicationName>      |
      | branchName       | <releaseBranchName>    |
      | newBranchVersion | <releaseBranchVersion> |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    Then User checks "<releaseJobName>" build  status in "<applicationName>" jenkins folder
    And User checks "<releaseCodebaseBranchName>" branch build status
    And User checks "<releaseCodebaseBranchName>" branch last successful build status
#    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    When User creates change in "<releaseBranchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User makes merge request in gerrit
    Then User checks "<releaseJobName>" second build  status in "<applicationName>" jenkins folder
    And User checks Jira ticket fields
      | applicationName | <applicationName>      |
      | version         | <releaseBranchVersion> |
    And User deletes "<applicationName>" codebase resources
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationRelease @Java11Clone @Java11JiraReleaseClone @Regression
    Examples:
      | applicationName                      | codeLanguage          | releaseBranchName | startFrom      | releaseBranchVersion | releaseCodebaseBranchName                        | createReleaseJob                                    | releaseJobName                                         | codeReviewJob                                                |
      | java11-gradle-lib-release-clone-jira | java11_gradle_library | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | java11-gradle-lib-release-clone-jira-release-1.2 | Create-release-java11-gradle-lib-release-clone-jira | RELEASE-1.2-Build-java11-gradle-lib-release-clone-jira | RELEASE-1.2-Code-review-java11-gradle-lib-release-clone-jira |
    @JenkinsCriticalPath @JiraIntegration @JiraIntegrationRelease @Java11Clone @Java11JiraReleaseClone @Regression
    Examples:
      | applicationName                     | codeLanguage         | releaseBranchName | startFrom      | releaseBranchVersion | releaseCodebaseBranchName                       | createReleaseJob                                   | releaseJobName                                        | codeReviewJob                                               |
      | java11-maven-lib-release-clone-jira | java11_maven_library | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | java11-maven-lib-release-clone-jira-release-1.2 | Create-release-java11-maven-lib-release-clone-jira | RELEASE-1.2-Build-java11-maven-lib-release-clone-jira | RELEASE-1.2-Code-review-java11-maven-lib-release-clone-jira |
