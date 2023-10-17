Feature: Review

  Scenario Outline: Check Code-Review for <codeLanguage> added with EDP version using Import strategy (Gitlab)
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    Given User imports edp codebase from gitlab for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates pull request from "<defaultBranchName>" ref branch to "<defaultBranchName>" target branch in gitlab
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User merges pull request in Gitlab
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewEDP @PythonGitlab @PythonReviewGitlabEDP @PythonRegression @Regression
    Examples:
      | applicationName                     | codeLanguage           | defaultBranchName | startFrom      | codeReviewJob                                          |
      | python-3-8-import-edp-gitlab-review | python_3_8_application | master            | 1.2.3-SNAPSHOT | MASTER-Code-review-python-3-8-import-edp-gitlab-review |
    @JenkinsCriticalPath @CodeReview @CodeReviewEDP @PythonGitlab @PythonReviewGitlabEDP @PythonRegression @Regression
    Examples:
      | applicationName                         | codeLanguage       | defaultBranchName | startFrom      | codeReviewJob                                              |
      | python-3-8-lib-import-edp-gitlab-review | python_3_8_library | master            | 1.2.3-SNAPSHOT | MASTER-Code-review-python-3-8-lib-import-edp-gitlab-review |


  Scenario Outline: Check Code-Review for new branch of <codeLanguage> added with EDP version using Import strategy (Gitlab)
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    Given User imports edp codebase from gitlab for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    When User creates pull request from "<defaultBranchName>" ref branch to "<newBranchName>" target branch in gitlab
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User merges pull request in Gitlab
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewBranchEDP @PythonGitlab @PythonReviewBranchGitlabEDP @PythonRegression @Regression
    Examples:
      | applicationName                            | codeLanguage       | newBranchName | defaultBranchName | startFrom      | newBranchVersion   | codeReviewJob                                              |
      | python-3-8-lib-br-import-edp-gitlab-review | python_3_8_library | new           | master            | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | NEW-Code-review-python-3-8-lib-br-import-edp-gitlab-review |
    @JenkinsCriticalPath @CodeReview @CodeReviewBranchEDP @PythonGitlab @PythonReviewBranchGitlabEDP @PythonRegression @Regression
    Examples:
      | applicationName                        | codeLanguage           | newBranchName | defaultBranchName | startFrom      | newBranchVersion   | codeReviewJob                                          |
      | python-3-8-br-import-edp-gitlab-review | python_3_8_application | new           | master            | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | NEW-Code-review-python-3-8-br-import-edp-gitlab-review |

  Scenario Outline: Check Code-Review for release branch of <codeLanguage> added with EDP version using Import strategy (Gitlab)
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    Given User imports edp codebase from gitlab for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new release branch
      | applicationName  | <applicationName>      |
      | branchName       | <releaseBranchName>    |
      | newBranchVersion | <releaseBranchVersion> |
    When User creates pull request from "<defaultBranchName>" ref branch to "<releaseBranchName>" target branch in gitlab
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User merges pull request in Gitlab
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewRelease @JavaScriptGitlab @JavaScriptReviewReleaseGitlab @JavaScriptRegression @Regression
    Examples:
      | applicationName                     | codeLanguage  | releaseBranchName | defaultBranchName | startFrom      | releaseBranchVersion | codeReviewJob                                               |
      | js-lib-release-import-gitlab-review | react_library | release-1.2       | master            | 1.2.3-SNAPSHOT | 1.2.3-RC             | RELEASE-1.2-Code-review-js-lib-release-import-gitlab-review |