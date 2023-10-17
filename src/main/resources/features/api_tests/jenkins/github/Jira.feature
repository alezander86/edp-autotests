Feature: Jira

  Scenario Outline: Check Jira-integration for release branch of <codeLanguage> with EDP version using Import strategy (Github)
    Given User creates "<applicationName>" subtask in Jira ticket
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    Given User imports edp codebase from github for jenkins with jira integration
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    When User creates new release branch
      | applicationName  | <applicationName>      |
      | branchName       | <releaseBranchName>    |
      | newBranchVersion | <releaseBranchVersion> |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    Then User checks "<releaseJobName>" build  status in "<applicationName>" jenkins folder
    When User creates pull request to "<releaseBranchName>" target branch in github "<applicationName>" project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User merges pull request in github "<applicationName>" project
    Then User checks "<releaseJobName>" second build  status in "<applicationName>" jenkins folder
    And User checks Jira ticket fields
      | applicationName | <applicationName>      |
      | version         | <releaseBranchVersion> |
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    And User deletes Jira subtask
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationRelease @Java11Github @Java11JiraReleaseGithub @Regression
    Examples:
      | applicationName                  | codeLanguage             | releaseBranchName | startFrom      | releaseBranchVersion | createReleaseJob                                | releaseJobName                                     | codeReviewJob                                            |
      | java11-maven-release-github-jira | java11_maven_application | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-maven-release-github-jira | RELEASE-1.2-Build-java11-maven-release-github-jira | RELEASE-1.2-Code-review-java11-maven-release-github-jira |
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @JiraIntegration @JiraIntegrationRelease @Java11Github @Java11JiraReleaseGithub @Regression
    Examples:
      | applicationName                              | codeLanguage                   | releaseBranchName | startFrom      | releaseBranchVersion | createReleaseJob                                            | releaseJobName                                                 | codeReviewJob                                                        |
      | java11-gradle-release-github-jira            | java11_gradle_application      | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-gradle-release-github-jira            | RELEASE-1.2-Build-java11-gradle-release-github-jira            | RELEASE-1.2-Code-review-java11-gradle-release-github-jira            |
      | java11-mult-release-github-jira              | java11_multimodule_application | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-mult-release-github-jira              | RELEASE-1.2-Build-java11-mult-release-github-jira              | RELEASE-1.2-Code-review-java11-mult-release-github-jira              |
      | java11-maven-lib-release-import-github-jira  | java11_maven_library           | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-maven-lib-release-import-github-jira  | RELEASE-1.2-Build-java11-maven-lib-release-import-github-jira  | RELEASE-1.2-Code-review-java11-maven-lib-release-import-github-jira  |
      | java11-gradle-lib-release-import-github-jira | java11_gradle_library          | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-java11-gradle-lib-release-import-github-jira | RELEASE-1.2-Build-java11-gradle-lib-release-import-github-jira | RELEASE-1.2-Code-review-java11-gradle-lib-release-import-github-jira |
