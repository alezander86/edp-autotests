Feature: Adding new branch for applications added using Clone strategy with EDP versioning type


  Scenario Outline: Create new branch for application added using Clone strategy from private repository with EDP version (Gitlab)
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
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
    And User enters "<branchVersion>" branch version
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'CI' link for "<newBranchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                          | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | versioningType   | startVersion | branchVersion | buildJob                                           | codeReviewJob                                            |
      | java8-maven-clone-gitlab-edp-vers-br     | Clone            | java8-gitlab          | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Maven     | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-maven-clone-gitlab-edp-vers-br     | NEW-Code-review-java8-maven-clone-gitlab-edp-vers-br     |
      | java8-gradle-clone-gitlab-edp-vers-br    | Clone            | java8-gradle-gitlab   | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Gradle    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-gradle-clone-gitlab-edp-vers-br    | NEW-Code-review-java8-gradle-clone-gitlab-edp-vers-br    |
      | java11-gradle-clone-gitlab-edp-vers-br   | Clone            | java11-gitlab         | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Gradle    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-gradle-clone-gitlab-edp-vers-br   | NEW-Code-review-java11-gradle-clone-gitlab-edp-vers-br   |
      | java11-maven-clone-gitlab-edp-vers-br    | Clone            | java11-maven-gitlab   | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Maven     | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-maven-clone-gitlab-edp-vers-br    | NEW-Code-review-java11-maven-clone-gitlab-edp-vers-br    |
      | dotnet-3-1-clone-gitlab-edp-vers-br      | Clone            | dotnet31-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | DotNet       | dotnet-3.1      | dotnet    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-dotnet-3-1-clone-gitlab-edp-vers-br      | NEW-Code-review-dotnet-3-1-clone-gitlab-edp-vers-br      |
      | dotnet-2-1-clone-gitlab-edp-vers-br      | Clone            | dotnet21-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | DotNet       | dotnet-2.1      | dotnet    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-dotnet-2-1-clone-gitlab-edp-vers-br      | NEW-Code-review-dotnet-2-1-clone-gitlab-edp-vers-br      |
      | python-3-8-clone-gitlab-edp-vers-br      | Clone            | python38-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | Python       | python-3.8      | Python    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-python-3-8-clone-gitlab-edp-vers-br      | NEW-Code-review-python-3-8-clone-gitlab-edp-vers-br      |
      | javascript-clone-gitlab-edp-vers-br      | Clone            | javascript-gitlab     | gitlabRepositoryLogin | gitlabRepositoryPassword | JavaScript   | react           | NPM       | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-javascript-clone-gitlab-edp-vers-br      | NEW-Code-review-javascript-clone-gitlab-edp-vers-br      |
      | go-beego-clone-gitlab-edp-vers-br        | Clone            | go-beego-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | Go           | beego           | Go        | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-go-beego-clone-gitlab-edp-vers-br        | NEW-Code-review-go-beego-clone-gitlab-edp-vers-br        |
      | go-operator-sdk-clone-gitlab-edp-vers-br | Clone            | go-operatorsdk-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Go           | operator-sdk    | Go        | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-go-operator-sdk-clone-gitlab-edp-vers-br | NEW-Code-review-go-operator-sdk-clone-gitlab-edp-vers-br |


  Scenario Outline: Create new branch for multi-module application added using Clone strategy from private repository with EDP version (Gitlab)
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
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
    And User enters "<branchVersion>" branch version
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'CI' link for "<newBranchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                            | codebaseStrategy | repository               | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | versioningType   | startVersion | branchVersion | buildJob                                             | codeReviewJob                                              |
      | java8-maven-mult-clone-gitlab-edp-vers-br  | Clone            | java8-multimodule-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Maven     | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-maven-mult-clone-gitlab-edp-vers-br  | NEW-Code-review-java8-maven-mult-clone-gitlab-edp-vers-br  |
      | java11-maven-mult-clone-gitlab-edp-vers-br | Clone            | java8-multimodule-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Maven     | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-maven-mult-clone-gitlab-edp-vers-br | NEW-Code-review-java11-maven-mult-clone-gitlab-edp-vers-br |


  Scenario Outline: Create new branch for application added using Clone strategy from public repository with EDP version (Github)
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
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
    And User enters "<branchVersion>" branch version
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'CI' link for "<newBranchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                          | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | versioningType   | startVersion | branchVersion | buildJob                                           | codeReviewJob                                            |
      | java8-maven-clone-github-edp-vers-br     | Clone            | java8-mavem-github    | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Maven     | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-maven-clone-github-edp-vers-br     | NEW-Code-review-java8-maven-clone-github-edp-vers-br     |
      | java8-gradle-clone-github-edp-vers-br    | Clone            | java8-gradle-github   | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Gradle    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-gradle-clone-github-edp-vers-br    | NEW-Code-review-java8-gradle-clone-github-edp-vers-br    |
      | java11-maven-clone-github-edp-vers-br    | Clone            | java11-mavem-github   | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Maven     | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-maven-clone-github-edp-vers-br    | NEW-Code-review-java11-maven-clone-github-edp-vers-br    |
      | java11-gradle-clone-github-edp-vers-br   | Clone            | java11-gradle-github  | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Gradle    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-gradle-clone-github-edp-vers-br   | NEW-Code-review-java11-gradle-clone-github-edp-vers-br   |
      | go-beego-clone-github-edp-vers-br        | Clone            | go-beego-github       | githubRepositoryLogin | githubRepositoryPassword | Go           | beego           | Go        | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-go-beego-clone-github-edp-vers-br        | NEW-Code-review-go-beego-clone-github-edp-vers-br        |
      | go-operator-sdk-clone-github-edp-vers-br | Clone            | go-operatorsdk-github | githubRepositoryLogin | githubRepositoryPassword | Go           | operator-sdk    | Go        | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-go-operator-sdk-clone-github-edp-vers-br | NEW-Code-review-go-operator-sdk-clone-github-edp-vers-br |
      | python-3-8-clone-github-edp-vers-br      | Clone            | python38-github       | githubRepositoryLogin | githubRepositoryPassword | Python       | python-3.8      | Python    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-python-3-8-clone-github-edp-vers-br      | NEW-Code-review-python-3-8-clone-github-edp-vers-br      |
      | javascript-clone-github-edp-vers-br      | Clone            | javascript-github     | githubRepositoryLogin | githubRepositoryPassword | JavaScript   | react           | NPM       | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-javascript-clone-github-edp-vers-br      | NEW-Code-review-javascript-clone-github-edp-vers-br      |
      | dotnet-3-1-clone-github-edp-vers-br      | Clone            | dotnet31-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet       | dotnet-3.1      | dotnet    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-dotnet-3-1-clone-github-edp-vers-br      | NEW-Code-review-dotnet-3-1-clone-github-edp-vers-br      |
      | dotnet-2-1-clone-github-edp-vers-br      | Clone            | dotnet21-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet       | dotnet-2.1      | dotnet    | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-dotnet-2-1-clone-github-edp-vers-br      | NEW-Code-review-dotnet-2-1-clone-github-edp-vers-br      |


  Scenario Outline: Create new branch for multi-module application added using Clone strategy from public repository with EDP version (Github)
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
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
    And User enters "<branchVersion>" branch version
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'CI' link for "<newBranchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                            | codebaseStrategy | repository                | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | versioningType   | startVersion | branchVersion | buildJob                                             | codeReviewJob                                              |
      | java8-maven-mult-clone-github-edp-vers-br  | Clone            | java8-multimodule-github  | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Maven     | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-maven-mult-clone-github-edp-vers-br  | NEW-Code-review-java8-maven-mult-clone-github-edp-vers-br  |
      | java11-maven-mult-clone-github-edp-vers-br | Clone            | java11-multimodule-github | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Maven     | master     | new           | master            | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-maven-mult-clone-github-edp-vers-br | NEW-Code-review-java11-maven-mult-clone-github-edp-vers-br |
