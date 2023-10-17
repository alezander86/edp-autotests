Feature: Libraries provisioning using Create strategy with default versioning type


  Scenario Outline: Create library using Create strategy with Default version
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
      | applicationName                     | codebaseStrategy | codeLanguage    | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | buildJob                                         | codeReviewJob                                          |
      | java8-maven-lib-create-def-vers     | Create           | Java            | java8           | Maven     | master     | master            | default          | MASTER-Build-java8-maven-lib-create-def-vers     | MASTER-Code-review-java8-maven-lib-create-def-vers     |
      | java8-gradle-lib-create-def-vers    | Create           | Java            | java8           | Gradle    | master     | master            | default          | MASTER-Build-java8-gradle-lib-create-def-vers    | MASTER-Code-review-java8-gradle-lib-create-def-vers    |
      | java11-maven-lib-create-def-vers    | Create           | Java            | java11          | Maven     | master     | master            | default          | MASTER-Build-java11-maven-lib-create-def-vers    | MASTER-Code-review-java11-maven-lib-create-def-vers    |
      | java11-gradle-lib-create-def-vers   | Create           | Java            | java11          | Gradle    | master     | master            | default          | MASTER-Build-java11-gradle-lib-create-def-vers   | MASTER-Code-review-java11-gradle-lib-create-def-vers   |
      | javascript-lib-create-def-vers      | Create           | JavaScript      | react           | NPM       | master     | master            | default          | MASTER-Build-javascript-lib-create-def-vers      | MASTER-Code-review-javascript-lib-create-def-vers      |
      | dotnet-2-1-lib-create-def-vers      | Create           | DotNet          | dotnet-2.1      | dotnet    | master     | master            | default          | MASTER-Build-dotnet-2-1-lib-create-def-vers      | MASTER-Code-review-dotnet-2-1-lib-create-def-vers      |
      | dotnet-3-1-lib-create-def-vers      | Create           | DotNet          | dotnet-3.1      | dotnet    | master     | master            | default          | MASTER-Build-dotnet-3-1-lib-create-def-vers      | MASTER-Code-review-dotnet-3-1-lib-create-def-vers      |
      | python-3-8-lib-create-def-vers      | Create           | Python          | python-3.8      | Python    | master     | master            | default          | MASTER-Build-python-3-8-lib-create-def-vers      | MASTER-Code-review-python-3-8-lib-create-def-vers      |
      | groovy-pipeline-lib-create-def-vers | Create           | Groovy-pipeline | Groovy          | Codenarc  | master     | master            | default          | MASTER-Build-groovy-pipeline-lib-create-def-vers | MASTER-Code-review-groovy-pipeline-lib-create-def-vers |
      | rego-opa-lib-create-def-vers        | Create           | Rego            | opa             | OPA       | master     | master            | default          | MASTER-Build-rego-opa-lib-create-def-vers        | MASTER-Code-review-rego-opa-lib-create-def-vers        |


  Scenario Outline: Create Terraform library using Create strategy with Default version
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
      | applicationName               | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | buildJob                                   | codeReviewJob                                    |
      | terraform-lib-create-def-vers | Create           | Terraform    | terraform       | Terraform | master     | master            | default          | MASTER-Build-terraform-lib-create-def-vers | MASTER-Code-review-terraform-lib-create-def-vers |

