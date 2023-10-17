Feature: Adding release branch for libraries added using Create strategy with EDP versioning type


  Scenario Outline: Create release branch for library added using Create strategy with EDP version
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Libraries tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
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
#    And User clicks on Libraries tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName                                | codebaseStrategy | codeLanguage    | languageVersion | buildTool | branchName | newBranchName | releaseBranchName | defaultBranchName | versioningType   | startVersion | buildJob                                                         | codeReviewJob                                                          |
      | java8-maven-lib-create-edp-vers-release-br     | Create           | Java            | java8           | Maven     | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-java8-maven-lib-create-edp-vers-release-br     | RELEASE-1.2-Code-review-java8-maven-lib-create-edp-vers-release-br     |
      | java8-gradle-lib-create-edp-vers-release-br    | Create           | Java            | java8           | Gradle    | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-java8-gradle-lib-create-edp-vers-release-br    | RELEASE-1.2-Code-review-java8-gradle-lib-create-edp-vers-release-br    |
      | java11-maven-lib-create-edp-vers-release-br    | Create           | Java            | java11          | Maven     | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-java11-maven-lib-create-edp-vers-release-br    | RELEASE-1.2-Code-review-java11-maven-lib-create-edp-vers-release-br    |
      | java11-gradle-lib-create-edp-vers-release-br   | Create           | Java            | java11          | Gradle    | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-java11-gradle-lib-create-edp-vers-release-br   | RELEASE-1.2-Code-review-java11-gradle-lib-create-edp-vers-release-br   |
      | javascript-lib-create-edp-vers-release-br      | Create           | JavaScript      | react           | NPM       | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-javascript-lib-create-edp-vers-release-br      | RELEASE-1.2-Code-review-javascript-lib-create-edp-vers-release-br      |
      | dotnet-2-1-lib-create-edp-vers-release-br      | Create           | DotNet          | dotnet-2.1      | dotnet    | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-dotnet-2-1-lib-create-edp-vers-release-br      | RELEASE-1.2-Code-review-dotnet-2-1-lib-create-edp-vers-release-br      |
      | dotnet-3-1-lib-create-edp-vers-release-br      | Create           | DotNet          | dotnet-3.1      | dotnet    | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-dotnet-3-1-lib-create-edp-vers-release-br      | RELEASE-1.2-Code-review-dotnet-3-1-lib-create-edp-vers-release-br      |
      | python-lib-create-edp-vers-release-br          | Create           | Python          | python-3.8      | Python    | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-python-lib-create-edp-vers-release-br          | RELEASE-1.2-Code-review-python-lib-create-edp-vers-release-br          |
      | groovy-pipeline-lib-create-edp-vers-release-br | Create           | Groovy-pipeline | Groovy          | Codenarc  | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-groovy-pipeline-lib-create-edp-vers-release-br | RELEASE-1.2-Code-review-groovy-pipeline-lib-create-edp-vers-release-br |
      | rego-opa-lib-create-edp-vers-release-br        | Create           | Rego            | opa             | OPA       | master     | release/1.2   | release-1.2       | master            | edp              | 1.2.3        | RELEASE-1.2-Build-rego-opa-lib-create-edp-vers-release-br        | RELEASE-1.2-Code-review-rego-opa-lib-create-edp-vers-release-br        |


  Scenario Outline: Create release branch for Terraform library added using Create strategy with EDP version
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Libraries tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
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
    And User checks 'Release Branch' checkbox
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'CI' link for "<newBranchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User switch to first tab
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Libraries tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName                          | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | versioningType | startVersion   | buildJob                                                   | codeReviewJob                                                    |
      | terraform-lib-create-def-vers-release-br | Create           | Terraform    | terraform       | Terraform | master     | new           | master            | edp            | 1.2.3          | RELEASE-1.2-Build-terraform-lib-create-def-vers-release-br | RELEASE-1.2-Code-review-terraform-lib-create-def-vers-release-br |
