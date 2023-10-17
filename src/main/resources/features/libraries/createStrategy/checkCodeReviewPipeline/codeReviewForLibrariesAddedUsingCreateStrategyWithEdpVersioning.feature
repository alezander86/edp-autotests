Feature: Code-review for Libraries added using Create strategy with EDP versioning type


  Scenario Outline: Check code-review for library added using Create strategy with EDP version
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
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'Overview' tab
    And User click 'Gerrit' link
    And User clicks 'Browse' button
    And User clicks "<applicationName>" gerrit project
    And User clicks 'Commands' button
    And User clicks 'Create change' button
    And User selects "<branchName>" for new change
    And User inserts "<changeDescription>" change description
    And User confirms change creation
    And User clicks on Libraries tab
    And User search "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<codeReviewJob>" code review job
#    And User checks success status for "<buildJob>" build job
    And User close current tab
    And User switch to first tab
    And User clicks 'Overview' tab
    And User click 'Gerrit' link
    And User clicks 'Browse' button
    And User clicks "<applicationName>" gerrit project
    And User clicks 'Commands' button
    And User clicks 'Delete project' button
#    And User switch to first tab
#    And User clicks on Libraries tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                       | codebaseStrategy | codeLanguage    | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                           | codeReviewJob                                            | changeDescription    |
      | java8-maven-lib-create-edp-review     | Create           | Java            | java8           | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-maven-lib-create-edp-review     | MASTER-Code-review-java8-maven-lib-create-edp-review     | [EPMDEDP-1111]: test |
      | java8-gradle-lib-create-edp-review    | Create           | Java            | java8           | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-gradle-lib-create-edp-review    | MASTER-Code-review-java8-gradle-lib-create-edp-review    | [EPMDEDP-1111]: test |
      | java11-maven-lib-create-edp-review    | Create           | Java            | java11          | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-maven-lib-create-edp-review    | MASTER-Code-review-java11-maven-lib-create-edp-review    | [EPMDEDP-1111]: test |
      | java11-gradle-lib-create-edp-review   | Create           | Java            | java11          | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-gradle-lib-create-edp-review   | MASTER-Code-review-java11-gradle-lib-create-edp-review   | [EPMDEDP-1111]: test |
      | javascript-lib-create-edp-review      | Create           | JavaScript      | react           | NPM       | master     | master            | edp              | 1.2.3        | MASTER-Build-javascript-lib-create-edp-review      | MASTER-Code-review-javascript-lib-create-edp-review      | [EPMDEDP-1111]: test |
      | dotnet-2-1-lib-create-edp-review      | Create           | DotNet          | dotnet-2.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-2-1-lib-create-edp-review      | MASTER-Code-review-dotnet-2-1-lib-create-edp-review      | [EPMDEDP-1111]: test |
      | dotnet-3-1-lib-create-edp-review      | Create           | DotNet          | dotnet-3.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-3-1-lib-create-edp-review      | MASTER-Code-review-dotnet-3-1-lib-create-edp-review      | [EPMDEDP-1111]: test |
      | python-lib-create-edp-review          | Create           | Python          | python-3.8      | Python    | master     | master            | edp              | 1.2.3        | MASTER-Build-python-lib-create-edp-review          | MASTER-Code-review-python-lib-create-edp-review          | [EPMDEDP-1111]: test |
      | groovy-pipeline-lib-create-edp-review | Create           | Groovy-pipeline | Groovy          | Codenarc  | master     | master            | edp              | 1.2.3        | MASTER-Build-groovy-pipeline-lib-create-edp-review | MASTER-Code-review-groovy-pipeline-lib-create-edp-review | [EPMDEDP-1111]: test |
      | rego-opa-lib-create-edp-review        | Create           | Rego            | opa             | OPA       | master     | master            | edp              | 1.2.3        | MASTER-Build-rego-opa-lib-create-edp-review        | MASTER-Code-review-rego-opa-lib-create-edp-review        | [EPMDEDP-1111]: test |


  Scenario Outline: Check code-review for Terraform library added using Create strategy with EDP version
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
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'Overview' tab
    And User click 'Gerrit' link
    And User clicks 'Browse' button
    And User clicks "<applicationName>" gerrit project
    And User clicks 'Commands' button
    And User clicks 'Create change' button
    And User selects "<branchName>" for new change
    And User inserts "<changeDescription>" change description
    And User confirms change creation
    And User clicks on Libraries tab
    And User search "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
    And User checks success status for "<codeReviewJob>" code review job
    And User close current tab
    And User switch to first tab
    And User clicks 'Overview' tab
    And User click 'Gerrit' link
    And User clicks 'Browse' button
    And User clicks "<applicationName>" gerrit project
    And User clicks 'Commands' button
    And User clicks 'Delete project' button
#    And User switch to first tab
#    And User clicks on Libraries tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                 | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                     | codeReviewJob                                      | changeDescription    |
      | terraform-lib-create-edp-review | Create           | Terraform    | terraform       | Terraform | master     | master            | edp              | 1.2.3        | MASTER-Build-terraform-lib-create-edp-review | MASTER-Code-review-terraform-lib-create-edp-review | [EPMDEDP-1111]: test |


