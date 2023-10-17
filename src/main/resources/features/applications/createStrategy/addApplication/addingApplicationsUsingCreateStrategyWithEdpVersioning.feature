Feature: Applications provisioning using Create strategy with EDP versioning type


  Scenario Outline: Create application using Create strategy with EDP version
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
      | applicationName                 | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | startVersion | buildJob                                     | codeReviewJob                                      |
      | java8-maven-create-edp-vers     | Create           | Java         | java8           | Maven     | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-java8-maven-create-edp-vers     | MASTER-Code-review-java8-maven-create-edp-vers     |
      | java11-maven-create-edp-vers    | Create           | Java         | java11          | Maven     | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-java11-maven-create-edp-vers    | MASTER-Code-review-java11-maven-create-edp-vers    |
      | java8-gradle-create-edp-vers    | Create           | Java         | java8           | Gradle    | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-java8-gradle-create-edp-vers    | MASTER-Code-review-java8-gradle-create-edp-vers    |
      | java11-gradle-create-edp-vers   | Create           | Java         | java11          | Gradle    | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-java11-gradle-create-edp-vers   | MASTER-Code-review-java11-gradle-create-edp-vers   |
      | dotnet-2-1-create-edp-vers      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-dotnet-2-1-create-edp-vers      | MASTER-Code-review-dotnet-2-1-create-edp-vers      |
      | dotnet-3-1-create-edp-vers      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-dotnet-3-1-create-edp-vers      | MASTER-Code-review-dotnet-3-1-create-edp-vers      |
      | python-3-8-create-edp-vers      | Create           | Python       | python-3.8      | Python    | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-python-3-8-create-edp-vers      | MASTER-Code-review-python-3-8-create-edp-vers      |
      | javascript-create-edp-vers      | Create           | JavaScript   | react           | NPM       | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-javascript-create-edp-vers      | MASTER-Code-review-javascript-create-edp-vers      |
      | go-beego-create-edp-vers        | Create           | Go           | beego           | Go        | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-go-beego-create-edp-vers        | MASTER-Code-review-go-beego-create-edp-vers        |
      | go-operator-sdk-create-edp-vers | Create           | Go           | operator-sdk    | Go        | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-go-operator-sdk-create-edp-vers | MASTER-Code-review-go-operator-sdk-create-edp-vers |



  Scenario Outline: Create multi-module application using Create strategy with EDP version
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
      | applicationName                   | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | startVersion | buildJob                                       | codeReviewJob                                        |
      | java8-maven-mult-create-edp-vers  | Create           | Java         | java8           | Maven     | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-java8-maven-mult-create-edp-vers  | MASTER-Code-review-java8-maven-mult-create-edp-vers  |
      | java11-maven-mult-create-edp-vers | Create           | Java         | java11          | Maven     | master     | master            | default               | edp              | 1.2.3        | MASTER-Build-java11-maven-mult-create-edp-vers | MASTER-Code-review-java11-maven-mult-create-edp-vers |


