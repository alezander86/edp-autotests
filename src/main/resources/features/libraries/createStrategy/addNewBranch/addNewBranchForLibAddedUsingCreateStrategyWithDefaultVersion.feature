Feature: Adding new branch for libraries added using Create strategy with default versioning type


  Scenario Outline: Create new branch for library added using Create strategy with Default version
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
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
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
#    And User clicks on Libraries tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                      | codebaseStrategy | codeLanguage    | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | versioningType   | buildJob                                       | codeReviewJob                                        |
      | java8-maven-lib-create-def-vers-br   | Create           | Java            | java8           | Maven     | master     | new           | master            | default          | NEW-Build-java8-maven-lib-create-def-vers-br   | NEW-Code-review-java8-maven-lib-create-def-vers-br   |
      | java8-gradle-lib-create-def-vers-br  | Create           | Java            | java8           | Gradle    | master     | new           | master            | default          | NEW-Build-java8-gradle-lib-create-def-vers-br  | NEW-Code-review-java8-gradle-lib-create-def-vers-br  |
      | java11-maven-lib-create-def-vers-br  | Create           | Java            | java11          | Maven     | master     | new           | master            | default          | NEW-Build-java11-maven-lib-create-def-vers-br  | NEW-Code-review-java11-maven-lib-create-def-vers-br  |
      | java11-gradle-lib-create-def-vers-br | Create           | Java            | java11          | Gradle    | master     | new           | master            | default          | NEW-Build-java11-gradle-lib-create-def-vers-br | NEW-Code-review-java11-gradle-lib-create-def-vers-br |
      | javascript-lib-create-def-vers-br    | Create           | JavaScript      | react           | NPM       | master     | new           | master            | default          | NEW-Build-javascript-lib-create-def-vers-br    | NEW-Code-review-javascript-lib-create-def-vers-br    |
      | dotnet-2-1-lib-create-def-vers-br    | Create           | DotNet          | dotnet-2.1      | dotnet    | master     | new           | master            | default          | NEW-Build-dotnet-2-1-lib-create-def-vers-br    | NEW-Code-review-dotnet-2-1-lib-create-def-vers-br    |
      | dotnet-3-1-lib-create-def-vers-br    | Create           | DotNet          | dotnet-3.1      | dotnet    | master     | new           | master            | default          | NEW-Build-dotnet-3-1-lib-create-def-vers-br    | NEW-Code-review-dotnet-3-1-lib-create-def-vers-br    |
      | python-3-8-lib-create-def-vers-br    | Create           | Python          | python-3.8      | Python    | master     | new           | master            | default          | NEW-Build-python-3-8-lib-create-def-vers-br    | NEW-Code-review-python-3-8-lib-create-def-vers-br    |
      | groovy-pipeline-create-def-vers-br   | Create           | Groovy-pipeline | Groovy          | Codenarc  | master     | new           | master            | default          | NEW-Build-groovy-pipeline-create-def-vers-br   | NEW-Code-review-groovy-pipeline-create-def-vers-br   |
      | rego-opa-create-def-vers-br          | Create           | Rego            | opa             | OPA       | master     | new           | master            | default          | NEW-Build-groovy-pipeline-create-def-vers-br   | NEW-Code-review-groovy-pipeline-create-def-vers-br   |


  Scenario Outline: Create new branch for Terraform library added using Create strategy with Default version
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
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
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
      | applicationName                  | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | versioningType   | buildJob                                   | codeReviewJob                                    |
      | terraform-lib-create-def-vers-br | Create           | Terraform    | terraform       | Terraform | master     | new           | master            | default          | NEW-Build-terraform-lib-create-def-vers-br | NEW-Code-review-terraform-lib-create-def-vers-br |

