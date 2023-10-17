Feature: Code-review for new branch of applications added using Create strategy with EDP versioning type


  Scenario Outline: Check code-review for new branch of application added using Create strategy with EDP version
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
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
    And User enters "<branchVersion>" branch version
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'Overview' tab
    And User click 'Gerrit' link
    And User clicks 'Browse' button
    And User clicks "<applicationName>" gerrit project
    And User clicks 'Commands' button
    And User clicks 'Create change' button
    And User selects "<newBranchName>" for new change
    And User inserts "<changeDescription>" change description
    And User confirms change creation
    And User clicks on Application tab
    And User search "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User clicks 'CI' link for "<newBranchName>"
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
    And User switch to first tab
    And User clicks on Application tab
    And User search "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase


    Examples:
      | applicationName                      | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | newBranchName | ciPipelineProvisioner | versioningType   | startVersion | branchVersion | buildJob                                       | codeReviewJob                                        | changeDescription    |
      | java8-maven-create-edp-review-br     | Create           | Java         | java8           | Maven     | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-maven-create-edp-review-br     | NEW-Code-review-java8-maven-create-edp-review-br     | [EPMDEDP-1111]: test |
      | java11-maven-create-edp-review-br    | Create           | Java         | java11          | Maven     | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-maven-create-edp-review-br    | NEW-Code-review-java11-maven-create-edp-review-br    | [EPMDEDP-1111]: test |
      | java8-gradle-create-edp-review-br    | Create           | Java         | java8           | Gradle    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-java8-gradle-create-edp-review-br    | NEW-Code-review-java8-gradle-create-edp-review-br    | [EPMDEDP-1111]: test |
      | java11-gradle-create-edp-review-br   | Create           | Java         | java11          | Gradle    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-java11-gradle-create-edp-review-br   | NEW-Code-review-java11-gradle-create-edp-review-br   | [EPMDEDP-1111]: test |
      | dotnet-2-1-create-edp-review-br      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-dotnet-2-1-create-edp-review-br      | NEW-Code-review-dotnet-2-1-create-edp-review-br      | [EPMDEDP-1111]: test |
      | dotnet-3-1-create-edp-review-br      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-dotnet-3-1-create-edp-review-br      | NEW-Code-review-dotnet-3-1-create-edp-review-br      | [EPMDEDP-1111]: test |
      | python-3-8-create-edp-review-br      | Create           | Python       | python-3.8      | Python    | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-python-3-8-create-edp-review-br      | NEW-Code-review-python-3-8-create-edp-review-br      | [EPMDEDP-1111]: test |
      | javascript-create-edp-review-br      | Create           | JavaScript   | react           | NPM       | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-javascript-create-edp-review-br      | NEW-Code-review-javascript-create-edp-review-br      | [EPMDEDP-1111]: test |
      | go-beego-create-edp-review-br        | Create           | Go           | beego           | Go        | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-go-beego-create-edp-review-br        | NEW-Code-review-go-beego-create-edp-review-br        | [EPMDEDP-1111]: test |
      | go-operator-sdk-create-edp-review-br | Create           | Go           | operator-sdk    | Go        | master     | master            | new           | default               | edp              | 1.2.3        | 1.2.4         | NEW-Build-go-operator-sdk-create-edp-review-br | NEW-Code-review-go-operator-sdk-create-edp-review-br | [EPMDEDP-1111]: test |


  Scenario Outline: Check code-review for new branch of multi-module application adde using Create strategy with default version
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
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
    And User enters "<branchVersion>" branch version
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks 'VCS' link for "<newBranchName>"
    And User checks "<newBranchName>" branch created in Gerrit
    And User clicks 'Overview' tab
    And User click 'Gerrit' link
    And User clicks 'Browse' button
    And User clicks "<applicationName>" gerrit project
    And User clicks 'Commands' button
    And User clicks 'Create change' button
    And User selects "<newBranchName>" for new change
    And User inserts "<changeDescription>" change description
    And User confirms change creation
    And User clicks on Application tab
    And User search "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User clicks 'CI' link for "<newBranchName>"
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
    And User switch to first tab
    And User clicks on Application tab
    And User search "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User clicks 'delete' button for "<newBranchName>" branch name
    And User enters "<newBranchName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                        | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | ciPipelineProvisioner | newBranchName | startVersion | branchVersion | buildJob                                         | codeReviewJob                                          | changeDescription    |
      | java8-maven-mult-create-edp-review-br  | Create           | Java         | java8           | Maven     | master     | master            | edp              | default               | new           | 1.2.3        | 1.2.4         | NEW-Build-java8-maven-mult-create-edp-review-br  | NEW-Code-review-java8-maven-mult-create-edp-review-br  | [EPMDEDP-1111]: test |
      | java11-maven-mult-create-edp-review-br | Create           | Java         | java11          | Maven     | master     | master            | edp              | default               | new           | 1.2.3        | 1.2.4         | NEW-Build-java11-maven-mult-create-edp-review-br | NEW-Code-review-java11-maven-mult-create-edp-review-br | [EPMDEDP-1111]: test |
