Feature: Libraries provisioning using Create strategy with EDP versioning type


  Scenario Outline: Create library using Create strategy with EDP version
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
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
#    And User clicks on Libraries tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                     | codebaseStrategy | codeLanguage    | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                         | codeReviewJob                                          |
      | java8-maven-lib-create-edp-vers     | Create           | Java            | java8           | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-maven-lib-create-edp-vers     | MASTER-Code-review-java8-maven-lib-create-edp-vers     |
      | java8-gradle-lib-create-edp-vers    | Create           | Java            | java8           | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-gradle-lib-create-edp-vers    | MASTER-Code-review-java8-gradle-lib-create-edp-vers    |
      | java11-maven-lib-create-edp-vers    | Create           | Java            | java11          | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-maven-lib-create-edp-vers    | MASTER-Code-review-java11-maven-lib-create-edp-vers    |
      | java11-gradle-lib-create-edp-vers   | Create           | Java            | java11          | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-gradle-lib-create-edp-vers   | MASTER-Code-review-java11-gradle-lib-create-edp-vers   |
      | javascript-lib-create-edp-vers      | Create           | JavaScript      | react           | NPM       | master     | master            | edp              | 1.2.3        | MASTER-Build-javascript-lib-create-edp-vers      | MASTER-Code-review-javascript-lib-create-edp-vers      |
      | dotnet-2-1-lib-create-edp-vers      | Create           | DotNet          | dotnet-2.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-2-1-lib-create-edp-vers      | MASTER-Code-review-dotnet-2-1-lib-create-edp-vers      |
      | dotnet-3-1-lib-create-edp-vers      | Create           | DotNet          | dotnet-3.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-3-1-lib-create-edp-vers      | MASTER-Code-review-dotnet-3-1-lib-create-edp-vers      |
      | python-lib-create-edp-vers          | Create           | Python          | python-3.8      | Python    | master     | master            | edp              | 1.2.3        | MASTER-Build-python-lib-create-edp-vers          | MASTER-Code-review-python-lib-create-edp-vers          |
      | groovy-pipeline-lib-create-edp-vers | Create           | Groovy-pipeline | Groovy          | Codenarc  | master     | master            | edp              | 1.2.3        | MASTER-Build-groovy-pipeline-lib-create-edp-vers | MASTER-Code-review-groovy-pipeline-lib-create-edp-vers |
      | rego-opa-lib-create-edp-vers        | Create           | Rego            | opa             | OPA       | master     | master            | edp              | 1.2.3        | MASTER-Build-rego-opa-lib-create-edp-vers        | MASTER-Code-review-rego-opa-lib-create-edp-vers        |


  Scenario Outline: Create Terraform library using Create strategy with EDP version
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
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User switch to first tab
#    And User clicks on Libraries tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName               | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                   | codeReviewJob                                    |
      | terraform-lib-create-edp-vers | Create           | Terraform    | terraform       | Terraform | master     | master            | edp              | 1.2.3        | MASTER-Build-terraform-lib-create-edp-vers | MASTER-Code-review-terraform-lib-create-edp-vers |


