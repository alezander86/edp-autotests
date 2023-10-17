Feature: Jira

  Scenario Outline: Check Jira-integration for release branch of <codeLanguage> with EDP version using Import strategy (Gitlab)
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    Given User imports edp codebase from gitlab for jenkins with jira integration
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
    When User creates pull request from "<defaultBranchName>" ref branch to "<releaseBranchName>" target branch in gitlab
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User merges pull request in Gitlab
    Then User checks "<releaseJobName>" second build  status in "<applicationName>" jenkins folder
    And User checks Jira ticket fields
      | applicationName | <applicationName>      |
      | version         | <releaseBranchVersion> |
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationRelease @Java11Gitlab @Java11JiraReleaseGitlab @Regression
    Examples:
      | applicationName                  | codeLanguage             | releaseBranchName | defaultBranchName | startFrom      | releaseBranchVersion | createReleaseJob                                | releaseCodebaseBranchName                    | releaseJobName                                     | codeReviewJob                                            |
      | java11-maven-release-gitlab-jira | java11_maven_application | release-1.2       | master            | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-maven-release-gitlab-jira | java11-maven-release-gitlab-jira-release-1.2 | RELEASE-1.2-Build-java11-maven-release-gitlab-jira | RELEASE-1.2-Code-review-java11-maven-release-gitlab-jira |
    @JenkinsCriticalPath @JiraIntegration @JiraIntegrationRelease @Java11Gitlab @Java11JiraReleaseGitlab @Regression
    Examples:
      | applicationName                              | codeLanguage                   | releaseBranchName | defaultBranchName | startFrom      | releaseBranchVersion | createReleaseJob                                            | releaseCodebaseBranchName                                | releaseJobName                                                 | codeReviewJob                                                        |
      | java11-gradle-release-gitlab-jira            | java11_gradle_application      | release-1.2       | master            | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-gradle-release-gitlab-jira            | java11-gradle-release-gitlab-jira-release-1.2            | RELEASE-1.2-Build-java11-gradle-release-gitlab-jira            | RELEASE-1.2-Code-review-java11-gradle-release-gitlab-jira            |
      | java11-mult-release-gitlab-jira              | java11_multimodule_application | release-1.2       | master            | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-mult-release-gitlab-jira              | java11-mult-release-gitlab-jira-release-1.2              | RELEASE-1.2-Build-java11-mult-release-gitlab-jira              | RELEASE-1.2-Code-review-java11-mult-release-gitlab-jira              |
      | java11-maven-lib-release-import-gitlab-jira  | java11_maven_library           | release-1.2       | master            | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-maven-lib-release-import-gitlab-jira  | java11-maven-lib-release-import-gitlab-jira-release-1.2  | RELEASE-1.2-Build-java11-maven-lib-release-import-gitlab-jira  | RELEASE-1.2-Code-review-java11-maven-lib-release-import-gitlab-jira  |
      | java11-gradle-lib-release-import-gitlab-jira | java11_gradle_library          | release-1.2       | master            | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-gradle-lib-release-import-gitlab-jira | java11-gradle-lib-release-import-gitlab-jira-release-1.2 | RELEASE-1.2-Build-java11-gradle-lib-release-import-gitlab-jira | RELEASE-1.2-Code-review-java11-gradle-lib-release-import-gitlab-jira |