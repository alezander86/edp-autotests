Feature: Applications provisioning using Import strategy with default versioning type


  Scenario Outline: Create application using Import strategy (gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User selects "<gitServer>" git server
    And User enters "<relativePath>" repository relative path
    And User clicks 'Proceed' button
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User clicks 'Proceed' button
    And User selects "<ciPipelineProvisioner>" ci pipeline provisioner
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
#    Then User sees success status for "<applicationName>" application name
##    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
#    And User clicks 'CI' link for "<branchName>"
#    And User checks "<buildJob>" build job is created
#    And User checks "<codeReviewJob>" code review job is created
##    And User switch to first tab
#    And User checks success status for "<buildJob>" build job
##    And User sends request to get ac-creator secret
##    And User sends request to get admin-console-client secret
##    And User sends request to get token
    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName  | codebaseStrategy | gitServer | relativePath          | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                      | codeReviewJob                       |
      | java8-gradle     | Import           | git-epam  | java8-gradle-gitlab   | Java         | java8           | Gradle    | master     | master            | gitlab                | default          | MASTER-Build-java8-gradle     | MASTER-Code-review-java8-gradle     |
      | java8-maven      | Import           | git-epam  | java8-gitlab          | Java         | java8           | Maven     | master     | master            | gitlab                | default          | MASTER-Build-java8-maven      | MASTER-Code-review-java8-maven      |
      | java11-gradle    | Import           | git-epam  | java11-gitlab         | Java         | java11          | Gradle    | master     | master            | gitlab                | default          | MASTER-Build-java11-gradle    | MASTER-Code-review-java11-gradle    |
      | java11-maven     | Import           | git-epam  | java11-maven-gitlab   | Java         | java11          | Maven     | master     | master            | gitlab                | default          | MASTER-Build-java11-maven     | MASTER-Code-review-java11-maven     |
      | dotnet-3-1       | Import           | git-epam  | dotnet31-gitlab       | DotNet       | dotnet-3.1      | dotnet    | master     | master            | gitlab                | default          | MASTER-Build-dotnet-3-1       | MASTER-Code-review-dotnet-3-1       |
      | dotnet-2-1       | Import           | git-epam  | dotnet21-gitlab       | DotNet       | dotnet-2.1      | dotnet    | master     | master            | gitlab                | default          | MASTER-Build-dotnet-2-1       | MASTER-Code-review-dotnet-2-1       |
      | python-3-8       | Import           | git-epam  | python38-gitlab       | Python       | python-3.8      | Python    | master     | master            | gitlab                | default          | MASTER-Build-python-3-8       | MASTER-Code-review-python-3-8       |
      | javascript-react | Import           | git-epam  | javascript-gitlab     | JavaScript   | react           | NPM       | master     | master            | gitlab                | default          | MASTER-Build-javascript-react | MASTER-Code-review-javascript-react |
      | go-beego         | Import           | git-epam  | go-beego-gitlab       | Go           | beego           | Go        | master     | master            | gitlab                | default          | MASTER-Build-go-beego         | MASTER-Code-review-go-beego         |
      | go-operator-sdk  | Import           | git-epam  | go-operatorsdk-gitlab | Go           | operator-sdk    | Go        | master     | master            | gitlab                | default          | MASTER-Build-go-operator-sdk  | MASTER-Code-review-go-operator-sdk  |



  Scenario Outline: Create multi-module application using Import strategy (gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User selects "<gitServer>" git server
    And User enters "<relativePath>" repository relative path
    And User clicks 'Proceed' button
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
#    Then User sees success status for "<applicationName>" application name
##    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
#    And User clicks 'CI' link for "<branchName>"
#    And User checks "<buildJob>" build job is created
#    And User checks "<codeReviewJob>" code review job is created
##    And User switch to first tab
#    And User checks success status for "<buildJob>" build job
##    And User sends request to get ac-creator secret
##    And User sends request to get admin-console-client secret
##    And User sends request to get token
#    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName          | codebaseStrategy | gitServer | relativePath              | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                              | codeReviewJob                               |
      | java8-maven-multimodule  | Import           | git-epam  | java8-multimodule-gitlab  | Java         | java8           | Maven     | master     | master            | gitlab                | default          | MASTER-Build-java8-maven-multimodule  | MASTER-Code-review-java8-maven-multimodule  |
      | java11-maven-multimodule | Import           | git-epam  | java11-multimodule-gitlab | Java         | java11          | Maven     | master     | master            | gitlab                | default          | MASTER-Build-java11-maven-multimodule | MASTER-Code-review-java11-maven-multimodule |



  Scenario Outline: Create application using Import strategy (github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User selects "<gitServer>" git server
    And User enters "<relativePath>" relative path for github repository
    And User clicks 'Proceed' button
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User clicks 'Proceed' button
    And User selects "<ciPipelineProvisioner>" ci pipeline provisioner
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
#    Then User sees success status for "<applicationName>" application name
##    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
#    And User clicks 'CI' link for "<branchName>"
#    And User checks "<buildJob>" build job is created
#    And User checks "<codeReviewJob>" code review job is created
##    And User switch to first tab
#    And User checks success status for "<buildJob>" build job
##    And User sends request to get ac-creator secret
##    And User sends request to get admin-console-client secret
##    And User sends request to get token
#    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName          | codebaseStrategy | gitServer | relativePath          | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                              | codeReviewJob                               |
      | java-maven-java8         | Import           | github    | java8-mavem-github    | Java         | java8           | Maven     | master     | master            | github                | default          | MASTER-Build-java-maven-java8         | MASTER-Code-review-java-maven-java8         |
      | java-gradle-java8        | Import           | github    | java8-gradle-github   | Java         | java8           | Gradle    | master     | master            | github                | default          | MASTER-Build-java-gradle-java8        | MASTER-Code-review-java-gradle-java8        |
      | java-maven-java11        | Import           | github    | java11-mavem-github   | Java         | java11          | Maven     | master     | master            | github                | default          | MASTER-Build-java-maven-java11        | MASTER-Code-review-java-maven-java11        |
      | java-gradle-java11       | Import           | github    | java11-gradle-github  | Java         | java11          | Gradle    | master     | master            | github                | default          | MASTER-Build-java-gradle-java11       | MASTER-Code-review-java-gradle-java11       |
      | python-python-python-3-8 | Import           | github    | python38-github       | Python       | python-3.8      | Python    | master     | master            | github                | default          | MASTER-Build-python-python-python-3-8 | MASTER-Code-review-python-python-python-3-8 |
      | javascript-npm-react     | Import           | github    | javascript-github     | JavaScript   | react           | NPM       | master     | master            | github                | default          | MASTER-Build-javascript-npm-react     | MASTER-Code-review-javascript-npm-react     |
      | dotnet-dotnet-dotnet-3-1 | Import           | github    | dotnet31-github       | DotNet       | dotnet-3.1      | dotnet    | master     | master            | github               | default          | MASTER-Build-dotnet-dotnet-dotnet-3-1 | MASTER-Code-review-dotnet-dotnet-dotnet-3-1 |
      | dotnet-dotnet-dotnet-2-1 | Import           | github    | dotnet21-github       | DotNet       | dotnet-2.1      | dotnet    | master     | master            | github                | default          | MASTER-Build-dotnet-dotnet-dotnet-2-1 | MASTER-Code-review-dotnet-dotnet-dotnet-2-1 |
      | go-go-beego              | Import           | github    | go-beego-github       | Go           | beego           | Go        | master     | master            | github               | default          | MASTER-Build-go-go-beego              | MASTER-Code-review-go-go-beego              |
      | go-go-operator-sdk       | Import           | github    | go-operatorsdk-github | Go           | operator-sdk    | Go        | master     | master            | github                | default          | MASTER-Build-go-go-operator-sdk       | MASTER-Code-review-go-go-operator-sdk       |



  Scenario Outline: Create multi-module application using Import strategy (github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User selects "<gitServer>" git server
    And User enters "<relativePath>" relative path for github repository
    And User clicks 'Proceed' button
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
#    Then User sees success status for "<applicationName>" application name
##    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
#    And User clicks 'CI' link for "<branchName>"
#    And User checks "<buildJob>" build job is created
#    And User checks "<codeReviewJob>" code review job is created
##    And User switch to first tab
#    And User checks success status for "<buildJob>" build job
##    And User sends request to get ac-creator secret
##    And User sends request to get admin-console-client secret
##    And User sends request to get token
#    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName               | codebaseStrategy | gitServer | relativePath              | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                                   | codeReviewJob                                    |
      | java-maven-java8-multimodule  | Import           | github    | java8-multimodule-github  | Java         | java8           | Maven     | master     | master            | github                | default          | MASTER-Build-java-maven-java8-multimodule  | MASTER-Code-review-java-maven-java8-multimodule  |
      | java-maven-java11-multimodule | Import           | github    | java11-multimodule-github | Java         | java11          | Maven     | master     | master            | github                | default          | MASTER-Build-java-maven-java11-multimodule | MASTER-Code-review-java-maven-java11-multimodule |
