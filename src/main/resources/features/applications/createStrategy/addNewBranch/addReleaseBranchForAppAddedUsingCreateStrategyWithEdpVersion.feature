Feature: Adding release branch for applications added using Create strategy with EDP versioning type


  Scenario Outline: Create release branch for added using Create strategy with EDP version
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User clicks 'Proceed' button
    And User selects "<ciPipelineProvisioner>" ci pipeline provisioner
    And User selects "<versioningType>" codebase versioning type
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User checks 'Release Branch' checkbox
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'CI' link for "<releaseBranchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                            | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | newBranchName | releaseBranchName | ciPipelineProvisioner | versioningType   | startVersion | branchVersion | buildJob                                                     | codeReviewJob                                                      |
      | java8-maven-create-edp-vers-release-br     | Create           | Java         | java8           | Maven     | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-java8-maven-create-edp-vers-release-br     | RELEASE-1.2-Code-review-java8-maven-create-edp-vers-release-br     |
      | java11-maven-create-edp-vers-release-br    | Create           | Java         | java11          | Maven     | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-java11-maven-create-edp-vers-release-br    | RELEASE-1.2-Code-review-java11-maven-create-edp-vers-release-br    |
      | java8-gradle-create-edp-vers-release-br    | Create           | Java         | java8           | Gradle    | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-java8-gradle-create-edp-vers-release-br    | RELEASE-1.2-Code-review-java8-gradle-create-edp-vers-release-br    |
      | java11-gradle-create-edp-vers-release-br   | Create           | Java         | java11          | Gradle    | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-java11-gradle-create-edp-vers-release-br   | RELEASE-1.2-Code-review-java11-gradle-create-edp-vers-release-br   |
      | dotnet-2-1-create-edp-vers-release-br      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-dotnet-2-1-create-edp-vers-release-br      | RELEASE-1.2-Code-review-dotnet-2-1-create-edp-vers-release-br      |
      | dotnet-3-1-create-edp-vers-release-br      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-dotnet-3-1-create-edp-vers-release-br      | RELEASE-1.2-Code-review-dotnet-3-1-create-edp-vers-release-br      |
      | python-3-8-create-edp-vers-release-br      | Create           | Python       | python-3.8      | Python    | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-python-3-8-create-edp-vers-release-br      | RELEASE-1.2-Code-review-python-3-8-create-edp-vers-release-br      |
      | javascript-create-edp-vers-release-br      | Create           | JavaScript   | react           | NPM       | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-javascript-create-edp-vers-release-br      | RELEASE-1.2-Code-review-javascript-create-edp-vers-release-br      |
      | go-beego-create-edp-vers-release-br        | Create           | Go           | beego           | Go        | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-go-beego-create-edp-vers-release-br        | RELEASE-1.2-Code-review-go-beego-create-edp-vers-release-br        |
      | go-operator-sdk-create-edp-vers-release-br | Create           | Go           | operator-sdk    | Go        | master     | master            | release/1.2   | release-1.2       | default               | edp              | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-go-operator-sdk-create-edp-vers-release-br | RELEASE-1.2-Code-review-go-operator-sdk-create-edp-vers-release-br |


  Scenario Outline: Create release branch for multi-module application added using Create strategy with EDP version
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User checks 'Multi-module Project' checkbox
    And User clicks 'Proceed' button
    And User selects "<ciPipelineProvisioner>" ci pipeline provisioner
    And User selects "<versioningType>" codebase versioning type
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User checks 'Release Branch' checkbox
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'CI' link for "<releaseBranchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                              | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | ciPipelineProvisioner | newBranchName | releaseBranchName | startVersion | branchVersion | buildJob                                                       | codeReviewJob                                                        |
      | java8-maven-mult-create-edp-vers-release-br  | Create           | Java         | java8           | Maven     | master     | master            | edp              | default               | release/1.2   | release-1.2       | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-java8-maven-mult-create-edp-vers-release-br  | RELEASE-1.2-Code-review-java8-maven-mult-create-edp-vers-release-br  |
      | java11-maven-mult-create-edp-vers-release-br | Create           | Java         | java11          | Maven     | master     | master            | edp              | default               | release/1.2   | release-1.2       | 1.2.3        | 1.2.4         | RELEASE-1.2-Build-java11-maven-mult-create-edp-vers-release-br | RELEASE-1.2-Code-review-java11-maven-mult-create-edp-vers-release-br |
