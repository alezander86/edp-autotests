Feature: Adding new branch for applications added using Create strategy with EDP versioning type


  Scenario Outline: Create new branch for added using Create strategy with EDP version
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
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                    | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | newBranchName | ciPipelineProvisioner | versioningType   | startVersion | branchVersion | buildJob                                     | codeReviewJob                                      |
      | java8-maven-create-edp-vers-br     | Create           | Java         | java8           | Maven     | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-maven-create-edp-vers-br     | NEW-Code-review-java8-maven-create-edp-vers-br     |
      | java11-maven-create-edp-vers-br    | Create           | Java         | java11          | Maven     | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-maven-create-edp-vers-br    | NEW-Code-review-java11-maven-create-edp-vers-br    |
      | java8-gradle-create-edp-vers-br    | Create           | Java         | java8           | Gradle    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-gradle-create-edp-vers-br    | NEW-Code-review-java8-gradle-create-edp-vers-br    |
      | java11-gradle-create-edp-vers-br   | Create           | Java         | java11          | Gradle    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-gradle-create-edp-vers-br   | NEW-Code-review-java11-gradle-create-edp-vers-br   |
      | dotnet-2-1-create-edp-vers-br      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-dotnet-2-1-create-edp-vers-br      | NEW-Code-review-dotnet-2-1-create-edp-vers-br      |
      | dotnet-3-1-create-edp-vers-br      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-dotnet-3-1-create-edp-vers-br      | NEW-Code-review-dotnet-3-1-create-edp-vers-br      |
      | python-3-8-create-edp-vers-br      | Create           | Python       | python-3.8      | Python    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-python-3-8-create-edp-vers-br      | NEW-Code-review-python-3-8-create-edp-vers-br      |
      | javascript-create-edp-vers-br      | Create           | JavaScript   | react           | NPM       | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-javascript-create-edp-vers-br      | NEW-Code-review-javascript-create-edp-vers-br      |
      | go-beego-create-edp-vers-br        | Create           | Go           | beego           | Go        | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-go-beego-create-edp-vers-br        | NEW-Code-review-go-beego-create-edp-vers-br        |
      | go-operator-sdk-create-edp-vers-br | Create           | Go           | operator-sdk    | Go        | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-go-operator-sdk-create-edp-vers-br | NEW-Code-review-go-operator-sdk-create-edp-vers-br |


  Scenario Outline: Create new branch for multi-module application added using Create strategy with EDP version
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
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
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
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                      | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | ciPipelineProvisioner | newBranchName | branchVersion | buildJob                                       | codeReviewJob                                        |
      | java8-maven-mult-create-edp-vers-br  | Create           | Java         | java8           | Maven     | master     | master            | edp              | default               | new           | 1.2.4         | NEW-Build-java8-maven-mult-create-edp-vers-br  | NEW-Code-review-java8-maven-mult-create-edp-vers-br  |
      | java11-maven-mult-create-edp-vers-br | Create           | Java         | java11          | Maven     | master     | master            | edp              | default               | new           | 1.2.4         | NEW-Build-java11-maven-mult-create-edp-vers-br | NEW-Code-review-java11-maven-mult-create-edp-vers-br |
