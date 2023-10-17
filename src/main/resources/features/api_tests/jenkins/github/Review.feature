Feature: Review

  Scenario Outline: Create <codeLanguage> with EDP version using Import strategy and check Build status (Github)
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    Given User imports edp codebase from github for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates pull request to "<branchName>" target branch in github "<applicationName>" project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User merges pull request in github "<applicationName>" project
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewEDP @PythonGithub @PythonReviewGithubEDP @Regression
    Examples:
      | applicationName                     | codeLanguage           | branchName | startFrom      | codeReviewJob                                          |
      | python-3-8-import-edp-github-review | python_3_8_application | master     | 1.2.3-SNAPSHOT | MASTER-Code-review-python-3-8-import-edp-github-review |
    @JenkinsCriticalPath @CodeReview @CodeReviewEDP @PythonGithub @PythonReviewGithubEDP @Regression
    Examples:
      | applicationName                         | codeLanguage       | branchName | startFrom      | codeReviewJob                                              |
      | python-3-8-lib-import-edp-github-review | python_3_8_library | master     | 1.2.3-SNAPSHOT | MASTER-Code-review-python-3-8-lib-import-edp-github-review |


  Scenario Outline: Create new branch for <codeLanguage> with EDP version using Import strategy and check Build status (Github)
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    Given User imports edp codebase from github for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    When User creates pull request to "<newBranchName>" target branch in github "<applicationName>" project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User merges pull request in github "<applicationName>" project
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewBranchEDP @PythonGithub @PythonReviewBranchGithubEDP @Regression
    Examples:
      | applicationName                            | codeLanguage       | newBranchName | startFrom      | newBranchVersion   | codeReviewJob                                              |
      | python-3-8-lib-br-import-edp-github-review | python_3_8_library | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | NEW-Code-review-python-3-8-lib-br-import-edp-github-review |
    @JenkinsCriticalPath @CodeReview @CodeReviewBranchEDP @PythonGithub @PythonReviewBranchGithubEDP @Regression
    Examples:
      | applicationName                        | codeLanguage           | newBranchName | startFrom      | newBranchVersion   | codeReviewJob                                          |
      | python-3-8-br-import-edp-github-review | python_3_8_application | new           | 1.2.3-SNAPSHOT | 1.2.3-NEW-SNAPSHOT | NEW-Code-review-python-3-8-br-import-edp-github-review |


  Scenario Outline: Create release branch for <codeLanguage> with EDP version using Import strategy and check Build status (Github)
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    Given User imports edp codebase from github for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new release branch
      | applicationName  | <applicationName>      |
      | branchName       | <releaseBranchName>    |
      | newBranchVersion | <releaseBranchVersion> |
    When User creates pull request to "<releaseBranchName>" target branch in github "<applicationName>" project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User merges pull request in github "<applicationName>" project
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewRelease @JavaScriptGithub @JavaScriptReviewReleaseGithub @Regression
    Examples:
      | applicationName                     | codeLanguage  | releaseBranchName | startFrom      | releaseBranchVersion | codeReviewJob                                               |
      | js-lib-release-import-github-review | react_library | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | RELEASE-1.2-Code-review-js-lib-release-import-github-review |
