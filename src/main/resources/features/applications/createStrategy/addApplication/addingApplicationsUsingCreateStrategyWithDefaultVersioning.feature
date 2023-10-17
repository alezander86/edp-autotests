Feature: Applications provisioning using Create strategy with default versioning type


  Scenario Outline: Create application using Create strategy with Default version
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
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'VCS' link for "<branchName>"
    And User checks "<branchName>" branch created in Gerrit
    And User clicks 'CI' link for "<branchName>"
    And User checks "<buildJob>" build job is created
    And User checks "<codeReviewJob>" code review job is created
#    And User switch to first tab
    And User checks success status for "<buildJob>" build job
    And User clicks on Application tab
    And User clicks 'delete' button for "<applicationName>" codebase
    And User enters "<applicationName>" in confirmation name field
    And User clicks 'Delete confirmation' button


    Examples:
      | applicationName                 | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType | codebaseType | gitServer | ciTool  | deploymentScript | jenkinsSlave      | codebaseBranchName                       | buildJob                                     | codeReviewJob                                      | apiVersion |
      | java8-maven-create-def-vers     | Create           | Java         | java8           | Maven     | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | maven-java8       | java8-maven-create-def-vers-master       | MASTER-Build-java8-maven-create-def-vers     | MASTER-Code-review-java8-maven-create-def-vers     | v1         |
      | java11-maven-create-def-vers    | Create           | Java         | java11          | Maven     | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | maven-java11      | java11-maven-create-def-vers-master      | MASTER-Build-java11-maven-create-def-vers    | MASTER-Code-review-java11-maven-create-def-vers    | v1         |
      | java8-gradle-create-def-vers    | Create           | Java         | java8           | Gradle    | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | gradle-java8      | java8-gradle-create-def-vers-master      | MASTER-Build-java8-gradle-create-def-vers    | MASTER-Code-review-java8-gradle-create-def-vers    | v1         |
      | java11-gradle-create-def-vers   | Create           | Java         | java11          | Gradle    | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | gradle-java11     | java11-gradle-create-def-vers-master     | MASTER-Build-java11-gradle-create-def-vers   | MASTER-Code-review-java11-gradle-create-def-vers   | v1         |
      | dotnet-2-1-create-def-vers      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | dotnet-dotnet-2.1 | dotnet-2-1-create-def-vers-master        | MASTER-Build-dotnet-2-1-create-def-vers      | MASTER-Code-review-dotnet-2-1-create-def-vers      | v1         |
      | dotnet-3-1-create-def-vers      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | dotnet-dotnet-3.1 | dotnet-3-1-create-def-vers-master        | MASTER-Build-dotnet-3-1-create-def-vers      | MASTER-Code-review-dotnet-3-1-create-def-vers      | v1         |
      | python-3-8-create-def-vers      | Create           | Python       | python-3.8      | Python    | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | python-3.8        | python-3-8-create-def-vers-master        | MASTER-Build-python-3-8-create-def-vers      | MASTER-Code-review-python-3-8-create-def-vers      | v1         |
      | javascript-create-def-vers      | Create           | JavaScript   | react           | NPM       | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | npm               | javascript-create-def-vers-master        | MASTER-Build-javascript-create-def-vers      | MASTER-Code-review-javascript-create-def-vers      | v1         |
      | go-beego-create-def-vers        | Create           | Go           | beego           | Go        | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | go                | go-beego-create-def-vers-master          | MASTER-Build-go-beego-create-def-vers        | MASTER-Code-review-go-beego-create-def-vers        | v1         |
      | go-operator-sdk-create-def-vers | Create           | Go           | operator-sdk    | Go        | master     | master            | default               | default        | application  | gerrit    | Jenkins | helm-chart       | go                | go-operator-sdk-create-def-vers-master   | MASTER-Build-go-operator-sdk-create-def-vers | MASTER-Code-review-go-operator-sdk-create-def-vers | v1         |


  Scenario Outline: Create multi-module application using Create strategy with Default version
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
      | applicationName                   | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                                       | codeReviewJob                                        |
      | java8-maven-mult-create-def-vers  | Create           | Java         | java8           | Maven     | master     | master            | default               | default          | MASTER-Build-java8-maven-mult-create-def-vers  | MASTER-Code-review-java8-maven-mult-create-def-vers  |
      | java11-maven-mult-create-def-vers | Create           | Java         | java11          | Maven     | master     | master            | default               | default          | MASTER-Build-java11-maven-mult-create-def-vers | MASTER-Code-review-java11-maven-mult-create-def-vers |