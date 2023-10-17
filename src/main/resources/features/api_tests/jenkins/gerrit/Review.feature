Feature: Review

  Scenario Outline: Check Code-Review for <codeLanguage> added with Default version using Create strategy
    Given User creates default codebase on gerrit for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    And User creates change in "<branchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User deletes "<applicationName>" codebase resources
    @Sit @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewDefault @Java11Create @Java11ReviewCreateDefault @CreateDefault @Java11Regression @Regression
    Examples:
      | applicationName                | codeLanguage             | branchName | createReleaseJob                              | codeReviewJob                                     |
      | java11-maven-create-def-review | java11_maven_application | master     | Create-release-java11-maven-create-def-review | MASTER-Code-review-java11-maven-create-def-review |
    @JenkinsCriticalPath @CodeReview @CodeReviewDefault @Java11Create @Java11ReviewCreateDefault @CreateDefault @Java11Regression @Regression
    Examples:
      | applicationName                     | codeLanguage                   | branchName | createReleaseJob                                   | codeReviewJob                                          |
      | java11-gradle-create-def-review     | java11_gradle_application      | master     | Create-release-java11-gradle-create-def-review     | MASTER-Code-review-java11-gradle-create-def-review     |
      | java11-mult-create-def-review       | java11_multimodule_application | master     | Create-release-java11-mult-create-def-review       | MASTER-Code-review-java11-mult-create-def-review       |
      | java11-maven-lib-create-def-review  | java11_maven_library           | master     | Create-release-java11-maven-lib-create-def-review  | MASTER-Code-review-java11-maven-lib-create-def-review  |
      | java11-gradle-lib-create-def-review | java11_gradle_library          | master     | Create-release-java11-gradle-lib-create-def-review | MASTER-Code-review-java11-gradle-lib-create-def-review |

  Scenario Outline: Check Code-Review for new branch of <codeLanguage> added with Default version using Create strategy
    Given User creates default codebase on gerrit for jenkins
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for default branch
    When User creates new branch
      | applicationName | <applicationName> |
      | branchName      | <newBranchName>   |
    And User checks "<createReleaseJob>" job status in "<applicationName>" jenkins folder for new branch
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
    And User deletes "<applicationName>" codebase resources
    @Sit @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewBranchDefault @Java8Create @Java8ReviewBranchCreateDefault @Java8Regression @Regression
    Examples:
      | applicationName                       | codeLanguage         | newBranchName | createReleaseJob                                     | codeReviewJob                                         |
      | java8-gradle-lib-br-create-def-review | java8_gradle_library | new           | Create-release-java8-gradle-lib-br-create-def-review | NEW-Code-review-java8-gradle-lib-br-create-def-review |
    @JenkinsCriticalPath @CodeReview @CodeReviewBranchDefault @Java8Create @Java8ReviewBranchCreateDefault @Java8Regression @Regression
    Examples:
      | applicationName                      | codeLanguage                   | newBranchName | createReleaseJob                                    | codeReviewJob                                        |
      | java8-maven-lib-br-create-def-review | java8_maven_library            | new           | Create-release-java8-maven-lib-br-create-def-review | NEW-Code-review-java8-maven-lib-br-create-def-review |
      | java11-maven-br-create-def-review    | java11_maven_application       | new           | Create-release-java11-maven-br-create-def-review    | NEW-Code-review-java11-maven-br-create-def-review    |
      | java11-gradle-br-create-def-review   | java11_gradle_application      | new           | Create-release-java11-gradle-br-create-def-review   | NEW-Code-review-java11-gradle-br-create-def-review   |
      | java11-mult-br-create-def-review     | java11_multimodule_application | new           | Create-release-java11-mult-br-create-def-review     | NEW-Code-review-java11-mult-br-create-def-review     |
      | java11-mvn-lib-br-create-def-review  | java11_maven_library           | new           | Create-release-java11-mvn-lib-br-create-def-review  | NEW-Code-review-java11-mvn-lib-br-create-def-review  |
      | java11-gr-lib-br-create-def-review   | java11_gradle_library          | new           | Create-release-java11-gr-lib-br-create-def-review   | NEW-Code-review-java11-gr-lib-br-create-def-review   |


  Scenario Outline: Check Code-Review for release branch of <codeLanguage> added with EDP version using Clone strategy
    Given User clones edp codebase on gerrit for jenkins
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
    And User creates change in "<releaseBranchName>" branch in "<applicationName>" gerrit project
    Then User checks "<codeReviewJob>" build  status in "<applicationName>" jenkins folder
#    Then User checks "<jobName>" build  status in "<applicationName>" jenkins folder
    And User deletes "<applicationName>" codebase resources
    @JenkinsCriticalPath @JenkinsMiniCriticalPath @CodeReview @CodeReviewRelease @JavaScriptClone @JavaScriptReviewReleaseClone @JavaScriptRegression @Regression
    Examples:
      | applicationName         | codeLanguage      | releaseBranchName | startFrom      | releaseBranchVersion | createReleaseJob                       | codeReviewJob                                   |
      | js-release-clone-review | react_application | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-js-release-clone-review | RELEASE-1.2-Code-review-js-release-clone-review |
    @Sit @JenkinsCriticalPath @CodeReview @CodeReviewRelease @JavaScriptClone @JavaScriptReviewReleaseClone @JavaScriptRegression @Regression
    Examples:
      | applicationName             | codeLanguage  | releaseBranchName | startFrom      | releaseBranchVersion | createReleaseJob                           | codeReviewJob                                       |
      | js-lib-release-clone-review | react_library | release-1.2       | 1.2.3-SNAPSHOT | 1.2.3-RC             | Create-release-js-lib-release-clone-review | RELEASE-1.2-Code-review-js-lib-release-clone-review |

