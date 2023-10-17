Feature: Applications provisioning using Clone strategy with default versioning type


  Scenario Outline: Create application using Clone strategy from private repository with Default version (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
    And User checks 'Codebase Authentication' check-box
    And User enters "<repositoryLogin>" for Gitlab in repository login field
    And User enters "<repositoryPassword>" for Gitlab in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User clicks 'Proceed' button
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
#    And User switch to first tab
    And User checks success status for "<buildJob>" build job
#    And User clicks on Application tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                       | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | buildJob                                           | codeReviewJob                                            |
      | java8-maven-clone-gitlab-def-vers     | Clone            | java8-gitlab          | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          | MASTER-Build-java8-maven-clone-gitlab-def-vers     | MASTER-Code-review-java8-maven-clone-gitlab-def-vers     |
      | java8-gradle-clone-gitlab-def-vers    | Clone            | java8-gradle-gitlab   | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Gradle    | master     | master            | default          | MASTER-Build-java8-gradle-clone-gitlab-def-vers    | MASTER-Code-review-java8-gradle-clone-gitlab-def-vers    |
      | java11-gradle-clone-gitlab-def-vers   | Clone            | java11-gitlab         | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Gradle    | master     | master            | default          | MASTER-Build-java11-gradle-clone-gitlab-def-vers   | MASTER-Code-review-java11-gradle-clone-gitlab-def-vers   |
      | java11-maven-clone-gitlab-def-vers    | Clone            | java11-maven-gitlab   | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          | MASTER-Build-java11-maven-clone-gitlab-def-vers    | MASTER-Code-review-java11-maven-clone-gitlab-def-vers    |
      | dotnet-3-1-clone-gitlab-def-vers      | Clone            | dotnet31-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default          | MASTER-Build-dotnet-3-1-clone-gitlab-def-vers      | MASTER-Code-review-dotnet-3-1-clone-gitlab-def-vers      |
      | dotnet-2-1-clone-gitlab-def-vers      | Clone            | dotnet21-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default          | MASTER-Build-dotnet-2-1-clone-gitlab-def-vers      | MASTER-Code-review-dotnet-2-1-clone-gitlab-def-vers      |
      | python-3-8-clone-gitlab-def-vers      | Clone            | python38-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | Python       | python-3.8      | Python    | master     | master            | default          | MASTER-Build-python-3-8-clone-gitlab-def-vers      | MASTER-Code-review-python-3-8-clone-gitlab-def-vers      |
      | javascript-clone-gitlab-def-vers      | Clone            | javascript-gitlab     | gitlabRepositoryLogin | gitlabRepositoryPassword | JavaScript   | react           | NPM       | master     | master            | default          | MASTER-Build-javascript-clone-gitlab-def-vers      | MASTER-Code-review-javascript-clone-gitlab-def-vers      |
      | go-beego-clone-gitlab-def-vers        | Clone            | go-beego-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | Go           | beego           | Go        | master     | master            | default          | MASTER-Build-go-beego-clone-gitlab-def-vers        | MASTER-Code-review-go-beego-clone-gitlab-def-vers        |
      | go-operator-sdk-clone-gitlab-def-vers | Clone            | go-operatorsdk-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Go           | operator-sdk    | Go        | master     | master            | default          | MASTER-Build-go-operator-sdk-clone-gitlab-def-vers | MASTER-Code-review-go-operator-sdk-clone-gitlab-def-vers |



  Scenario Outline: Create multi-module application using Clone strategy from private repository with Default version (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
    And User checks 'Codebase Authentication' check-box
    And User enters "<repositoryLogin>" for Gitlab in repository login field
    And User enters "<repositoryPassword>" for Gitlab in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User checks 'Multi-module Project' checkbox
    And User clicks 'Proceed' button
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
#    And User switch to first tab
    And User checks success status for "<buildJob>" build job
#    And User clicks on Application tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                         | codebaseStrategy | repository               | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | buildJob                                             | codeReviewJob                                              |
      | java8-maven-mult-clone-gitlab-def-vers  | Clone            | java8-multimodule-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          | MASTER-Build-java8-maven-mult-clone-gitlab-def-vers  | MASTER-Code-review-java8-maven-mult-clone-gitlab-def-vers  |
      | java11-maven-mult-clone-gitlab-def-vers | Clone            | java8-multimodule-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          | MASTER-Build-java11-maven-mult-clone-gitlab-def-vers | MASTER-Code-review-java11-maven-mult-clone-gitlab-def-vers |



  Scenario Outline: Create application using Clone strategy from public repository with Default version (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
#    And User checks 'Codebase Authentication' check-box
#    And User enters "<repositoryLogin>" for Github in repository login field
#    And User enters "<repositoryPassword>" for Github in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User clicks 'Proceed' button
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
#    And User switch to first tab
    And User checks success status for "<buildJob>" build job
#    And User switch to first tab
#    And User clicks on Application tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                       | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | buildJob                                           | codeReviewJob                                            |
      | java8-maven-clone-github-def-vers     | Clone            | java8-mavem-github    | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          | MASTER-Build-java8-maven-clone-github-def-vers     | MASTER-Code-review-java8-maven-clone-github-def-vers     |
      | java8-gradle-clone-github-def-vers    | Clone            | java8-gradle-github   | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Gradle    | master     | master            | default          | MASTER-Build-java8-gradle-clone-github-def-vers    | MASTER-Code-review-java8-gradle-clone-github-def-vers    |
      | java11-maven-clone-github-def-vers    | Clone            | java11-mavem-github   | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          | MASTER-Build-java11-maven-clone-github-def-vers    | MASTER-Code-review-java11-maven-clone-github-def-vers    |
      | java11-gradle-clone-github-def-vers   | Clone            | java11-gradle-github  | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Gradle    | master     | master            | default          | MASTER-Build-java11-gradle-clone-github-def-vers   | MASTER-Code-review-java11-gradle-clone-github-def-vers   |
      | go-beego-clone-github-def-vers        | Clone            | go-beego-github       | githubRepositoryLogin | githubRepositoryPassword | Go           | beego           | Go        | master     | master            | default          | MASTER-Build-go-beego-clone-github-def-vers        | MASTER-Code-review-go-beego-clone-github-def-vers        |
      | go-operator-sdk-clone-github-def-vers | Clone            | go-operatorsdk-github | githubRepositoryLogin | githubRepositoryPassword | Go           | operator-sdk    | Go        | master     | master            | default          | MASTER-Build-go-operator-sdk-clone-github-def-vers | MASTER-Code-review-go-operator-sdk-clone-github-def-vers |
      | python-3-8-clone-github-def-vers      | Clone            | python38-github       | githubRepositoryLogin | githubRepositoryPassword | Python       | python-3.8      | Python    | master     | master            | default          | MASTER-Build-python-3-8-clone-github-def-vers      | MASTER-Code-review-python-3-8-clone-github-def-vers      |
      | javascript-clone-github-def-vers      | Clone            | javascript-github     | githubRepositoryLogin | githubRepositoryPassword | JavaScript   | react           | NPM       | master     | master            | default          | MASTER-Build-javascript-clone-github-def-vers      | MASTER-Code-review-javascript-clone-github-def-vers      |
      | dotnet-3-1-clone-github-def-vers      | Clone            | dotnet31-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default          | MASTER-Build-dotnet-3-1-clone-github-def-vers      | MASTER-Code-review-dotnet-3-1-clone-github-def-vers      |
      | dotnet-2-1-clone-github-def-vers      | Clone            | dotnet21-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default          | MASTER-Build-dotnet-2-1-clone-github-def-vers      | MASTER-Code-review-dotnet-2-1-clone-github-def-vers      |



  Scenario Outline: Create multi-module application using Clone strategy from public repository with Default version (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
#    And User checks 'Codebase Authentication' check-box
#    And User enters "<repositoryLogin>" for Github in repository login field
#    And User enters "<repositoryPassword>" for Github in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User checks 'Multi-module Project' checkbox
    And User clicks 'Proceed' button
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
#    And User switch to first tab
    And User checks success status for "<buildJob>" build job
#    And User clicks on Application tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                         | codebaseStrategy | repository                | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | buildJob                                             | codeReviewJob                                              |
      | java8-maven-mult-clone-github-def-vers  | Clone            | java8-multimodule-github  | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          | MASTER-Build-java8-maven-mult-clone-github-def-vers  | MASTER-Code-review-java8-maven-mult-clone-github-def-vers  |
      | java11-maven-mult-clone-github-def-vers | Clone            | java11-multimodule-github | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          | MASTER-Build-java11-maven-mult-clone-github-def-vers | MASTER-Code-review-java11-maven-mult-clone-github-def-vers |
