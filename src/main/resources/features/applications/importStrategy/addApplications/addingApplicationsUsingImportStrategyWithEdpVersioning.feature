Feature: Applications provisioning using Import strategy with EDP versioning type


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
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
#    And User sends request to get ac-creator secret
#    And User sends request to get admin-console-client secret
#    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName  | codebaseStrategy | gitServer | relativePath          | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | startVersion |
      | java8-gradle     | Import           | git-epam  | java8-gradle-gitlab   | Java         | java8           | Gradle    | master     | master            | gitlab                | edp              | 1.2.3        |
      | java8-maven      | Import           | git-epam  | java8-gitlab          | Java         | java8           | Maven     | master     | master            | gitlab                | edp              | 1.2.3        |
      | java11-gradle    | Import           | git-epam  | java11-gitlab         | Java         | java11          | Gradle    | master     | master            | gitlab                | edp              | 1.2.3        |
      | java11-maven     | Import           | git-epam  | java11-maven-gitlab   | Java         | java11          | Maven     | master     | master            | gitlab                | edp              | 1.2.3        |
      | dotnet-3-1       | Import           | git-epam  | dotnet31-gitlab       | DotNet       | dotnet-3.1      | dotnet    | master     | master            | gitlab                | edp              | 1.2.3        |
      | dotnet-2-1       | Import           | git-epam  | dotnet21-gitlab       | DotNet       | dotnet-2.1      | dotnet    | master     | master            | gitlab                | edp              | 1.2.3        |
      | python-3-8       | Import           | git-epam  | python38-gitlab       | Python       | python-3.8      | Python    | master     | master            | gitlab                | edp              | 1.2.3        |
      | javascript-react | Import           | git-epam  | javascript-gitlab     | JavaScript   | react           | NPM       | master     | master            | gitlab                | edp              | 1.2.3        |
      | go-beego         | Import           | git-epam  | go-beego-gitlab       | Go           | beego           | Go        | master     | master            | gitlab                | edp              | 1.2.3        |
      | go-operator-sdk  | Import           | git-epam  | go-operatorsdk-gitlab | Go           | operator-sdk    | Go        | master     | master            | gitlab                | edp              | 1.2.3        |


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
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
#    And User sends request to get ac-creator secret
#    And User sends request to get admin-console-client secret
#    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName          | codebaseStrategy | gitServer | relativePath              | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | startVersion |
      | java8-maven-multimodule  | Import           | git-epam  | java8-multimodule-gitlab  | Java         | java8           | Maven     | master     | master            | gitlab                | edp              | 1.2.3        |
      | java11-maven-multimodule | Import           | git-epam  | java11-multimodule-gitlab | Java         | java11          | Maven     | master     | master            | gitlab                | edp              | 1.2.3        |


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
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
#    And User sends request to get ac-creator secret
#    And User sends request to get admin-console-client secret
#    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName          | codebaseStrategy | gitServer | relativePath          | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | startVersion |
      | java-maven-java8         | Import           | github    | java8-mavem-github    | Java         | java8           | Maven     | master     | master            | github                | edp              | 1.2.3        |
      | java-gradle-java8        | Import           | github    | java8-gradle-github   | Java         | java8           | Gradle    | master     | master            | github                | edp              | 1.2.3        |
      | java-maven-java11        | Import           | github    | java11-mavem-github   | Java         | java11          | Maven     | master     | master            | github                | edp              | 1.2.3        |
      | java-gradle-java11       | Import           | github    | java11-gradle-github  | Java         | java11          | Gradle    | master     | master            | github                | edp              | 1.2.3        |
      | python-python-python-3-8 | Import           | github    | python38-github       | Python       | python-3.8      | Python    | master     | master            | github                | edp              | 1.2.3        |
      | javascript-npm-react     | Import           | github    | javascript-github     | JavaScript   | react           | NPM       | master     | master            | github                | edp              | 1.2.3        |
      | dotnet-dotnet-dotnet-3-1 | Import           | github    | dotnet31-github       | DotNet       | dotnet-3.1      | dotnet    | master     | master            | gitlab                | edp              | 1.2.3        |
      | dotnet-dotnet-dotnet-2-1 | Import           | github    | dotnet21-github       | DotNet       | dotnet-2.1      | dotnet    | master     | master            | gitlab                | edp              | 1.2.3        |
      | go-go-beego              | Import           | github    | go-beego-github       | Go           | beego           | Go        | master     | master            | gitlab                | edp              | 1.2.3        |
      | go-go-operator-sdk       | Import           | github    | go-operatorsdk-github | Go           | operator-sdk    | Go        | master     | master            | gitlab                | edp              | 1.2.3        |


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
    And User enters "<startVersion>" start version
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
#    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
#    And User sends request to get ac-creator secret
#    And User sends request to get admin-console-client secret
#    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName               | codebaseStrategy | gitServer | relativePath              | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | startVersion |
      | java-maven-java8-multimodule  | Import           | github    | java8-multimodule-github  | Java         | java8           | Maven     | master     | master            | github                | edp              | 1.2.3        |
      | java-maven-java11-multimodule | Import           | github    | java11-multimodule-github | Java         | java11          | Maven     | master     | master            | github                | edp              | 1.2.3        |
