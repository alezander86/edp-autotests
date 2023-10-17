Feature: Adding new branch for applications added using Create strategy with default versioning type


  Scenario Outline: Create new branch for application added using Create strategy with default version
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
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
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
#    And User clicks on Application tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                    | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | ciPipelineProvisioner | newBranchName | buildJob                                     | codeReviewJob                                      |
      | java8-maven-create-def-vers-br     | Create           | Java         | java8           | Maven     | master     | master            | default          | default               | new           | NEW-Build-java8-maven-create-def-vers-br     | NEW-Code-review-java8-maven-create-def-vers-br     |
      | java11-maven-create-def-vers-br    | Create           | Java         | java11          | Maven     | master     | master            | default          | default               | new           | NEW-Build-java11-maven-create-def-vers-br    | NEW-Code-review-java11-maven-create-def-vers-br    |
      | java8-gradle-create-def-vers-br    | Create           | Java         | java8           | Gradle    | master     | master            | default          | default               | new           | NEW-Build-java8-gradle-create-def-vers-br    | NEW-Code-review-java8-gradle-create-def-vers-br    |
      | java11-gradle-create-def-vers-br   | Create           | Java         | java11          | Gradle    | master     | master            | default          | default               | new           | NEW-Build-java11-gradle-create-def-vers-br   | NEW-Code-review-java11-gradle-create-def-vers-br   |
      | dotnet-2-1-create-def-vers-br      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default          | default               | new           | NEW-Build-dotnet-2-1-create-def-vers-br      | NEW-Code-review-dotnet-2-1-create-def-vers-br      |
      | dotnet-3-1-create-def-vers-br      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default          | default               | new           | NEW-Build-dotnet-3-1-create-def-vers-br      | NEW-Code-review-dotnet-3-1-create-def-vers-br      |
      | python-3-8-create-def-vers-br      | Create           | Python       | python-3.8      | Python    | master     | master            | default          | default               | new           | NEW-Build-python-3-8-create-def-vers-br      | NEW-Code-review-python-3-8-create-def-vers-br      |
      | javascript-create-def-vers-br      | Create           | JavaScript   | react           | NPM       | master     | master            | default          | default               | new           | NEW-Build-javascript-create-def-vers-br      | NEW-Code-review-javascript-create-def-vers-br      |
      | go-beego-create-def-vers-br        | Create           | Go           | beego           | Go        | master     | master            | default          | default               | new           | NEW-Build-go-beego-create-def-vers-br        | NEW-Code-review-go-beego-create-def-vers-br        |
      | go-operator-sdk-create-def-vers-br | Create           | Go           | operator-sdk    | Go        | master     | master            | default          | default               | new           | NEW-Build-go-operator-sdk-create-def-vers-br | NEW-Code-review-go-operator-sdk-create-def-vers-br |


  Scenario Outline: Create new branch for multi-module application added using Create strategy with default version
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
      | applicationName                      | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | ciPipelineProvisioner | newBranchName | buildJob                                       | codeReviewJob                                        |
      | java8-maven-mult-create-def-vers-br  | Create           | Java         | java8           | Maven     | master     | master            | default          | default               | new           | NEW-Build-java8-maven-mult-create-def-vers-br  | NEW-Code-review-java8-maven-mult-create-def-vers-br  |
      | java11-maven-mult-create-def-vers-br | Create           | Java         | java11          | Maven     | master     | master            | default          | default               | new           | NEW-Build-java11-maven-mult-create-def-vers-br | NEW-Code-review-java11-maven-mult-create-def-vers-br |
