Feature: Libraries provisioning using Create strategy with EDP versioning type Empty Project


  Scenario Outline: Create library with empty project using Create strategy with EDP version
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Libraries tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User checks 'Empty Project' checkbox
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
      | applicationName                        | codebaseStrategy | codeLanguage    | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                            | codeReviewJob                                             |
      | java8-maven-lib-create-edp-vers-ep     | Create           | Java            | java8           | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-maven-lib-create-edp-vers-ep     | MASTER-Code-review-java8-maven-lib-create-edp-vers-ep     |
      | java8-gradle-lib-create-edp-vers-ep    | Create           | Java            | java8           | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-gradle-lib-create-edp-vers-ep    | MASTER-Code-review-java8-gradle-lib-create-edp-vers-ep    |
      | java11-maven-lib-create-edp-vers-ep    | Create           | Java            | java11          | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-maven-lib-create-edp-vers-ep    | MASTER-Code-review-java11-maven-lib-create-edp-vers-ep    |
      | java11-gradle-lib-create-edp-vers-ep   | Create           | Java            | java11          | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-gradle-lib-create-edp-vers-ep   | MASTER-Code-review-java11-gradle-lib-create-edp-vers-ep   |
      | javascript-lib-create-edp-vers-ep      | Create           | JavaScript      | react           | NPM       | master     | master            | edp              | 1.2.3        | MASTER-Build-javascript-lib-create-edp-vers-ep      | MASTER-Code-review-javascript-lib-create-edp-vers-ep      |
      | dotnet-2-1-lib-create-edp-vers-ep      | Create           | DotNet          | dotnet-2.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-2-1-lib-create-edp-vers-ep      | MASTER-Code-review-dotnet-2-1-lib-create-edp-vers-ep      |
      | dotnet-3-1-lib-create-edp-vers-ep      | Create           | DotNet          | dotnet-3.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-3-1-lib-create-edp-vers-ep      | MASTER-Code-review-dotnet-3-1-lib-create-edp-vers-ep      |
      | python-lib-create-edp-vers-ep          | Create           | Python          | python-3.8      | Python    | master     | master            | edp              | 1.2.3        | MASTER-Build-python-lib-create-edp-vers-ep          | MASTER-Code-review-python-lib-create-edp-vers-ep          |
      | groovy-pipeline-lib-create-edp-vers-ep | Create           | Groovy-pipeline | Groovy          | Codenarc  | master     | master            | edp              | 1.2.3        | MASTER-Build-groovy-pipeline-lib-create-edp-vers-ep | MASTER-Code-review-groovy-pipeline-lib-create-edp-vers-ep |
      | rego-opa-lib-create-edp-vers-ep        | Create           | Rego            | opa             | OPA       | master     | master            | edp              | 1.2.3        | MASTER-Build-rego-opa-lib-create-edp-vers-ep        | MASTER-Code-review-rego-opa-lib-create-edp-vers-ep        |


  Scenario Outline: Create Terraform library with empty project using Create strategy with EDP version
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Libraries tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User checks 'Empty Project' checkbox
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
      | applicationName                  | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                      | codeReviewJob                                       |
      | terraform-lib-create-edp-vers-ep | Create           | Terraform    | terraform       | Terraform | master     | master            | edp              | 1.2.3        | MASTER-Build-terraform-lib-create-edp-vers-ep | MASTER-Code-review-terraform-lib-create-edp-vers-ep |


