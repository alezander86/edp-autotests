Feature: Deploy applications added using Create strategy with default versioning type from new branch


  Scenario Outline: Deploy added application using Create strategy with Default version from new branch
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
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks on Continuous Delivery tab
    And User clicks 'Create' button in CD pipeline tab
    And User enters "<cdPipelineName>" cd pipeline name
    And User clicks 'Proceed' button
    And User selects "<applicationName>" application by checkbox
    And User selects "<dockerStream>" docker stream for "<applicationName>"
    And User clicks 'Proceed' button
    And User clicks 'Add CD pipeline stage' button
    And User enters "<stageName>" cd pipeline stage name
    And User enters "<stageDescription>" description
    And User selects "<qualityGateType>" quality gate type
    And User enters "<stepName>" step name
    And User clicks 'Add' button
    And User clicks 'Add CD pipeline stage' button
    And User enters "<stageName1>" cd pipeline stage name
    And User enters "<stageDescription1>" description
    And User selects "<qualityGateType1>" quality gate type
    And User enters "<stepName1>" step name
    And User clicks 'Add' button
#    And User clicks 'Add CD pipeline stage' button
#    And User enters "<stageName2>" cd pipeline stage name
#    And User enters "<stageDescription2>" description
#    And User selects "<qualityGateType2>" quality gate type
#    And User enters "<stepName2>" step name
#    And User clicks 'Add' button
#    And User clicks 'Proceed' button
#    And User clicks 'Services' section
    And User clicks 'Create' button
    Then User sees success status for "<cdPipelineName>" cd pipeline name
    And User clicks 'Overview' tab
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    And User clicks 'Dashboard' button
    And User clicks "<cdPipelineName>" codebase jenkins folder
    And User clicks "<stageName>" job
    And User clicks 'Build with Parameters' button
    And User clicks 'Build' button
    And User opens 'job info' page
    And User clicks progress bar
    And User clicks 'Input requested' button
    And User selects "<applicationVersion>" application version for deploy
    Then User clicks 'Proceed' button in version info popup
    And User clicks Proceed' button to promote image
    And User opens "<cdPipelineName>" cd pipeline overview
    And User sees success status for "<cdPipelineStage>" cd pipeline stage
    And User clicks "<stageName1>" job
    And User clicks 'Build with Parameters' button
    And User clicks 'Build' button
    And User opens 'job info' page
    And User clicks progress bar
    And User clicks 'Input requested' button
    And User selects "<applicationVersion>" application version for deploy
    Then User clicks 'Proceed' button in version info popup
    And User clicks Proceed' button to promote image
    And User opens "<cdPipelineName>" cd pipeline overview
#    And User sees success status for "<cdPipelineStage1>" cd pipeline stage
    And User sees success status for "<cdPipelineStage1>" stage
#    And User clicks "<stageName2>" job
#    And User clicks 'Build with Parameters' button
#    And User clicks 'Build' button
#    And User opens 'job info' page
#    And User clicks progress bar
#    And User clicks 'Input requested' button
#    And User selects "<applicationVersion>" application version for deploy
#    Then User clicks 'Proceed' button in version info popup
#    And User clicks Proceed' button to promote image
#    And User opens "<cdPipelineName>" cd pipeline overview
#    And User sees success status for "<cdPipelineStage2>" cd pipeline stage
#    And User sees success status for "<cdPipelineStage2>" stage
    And User clicks on Continuous Delivery tab
    And User clicks 'delete' button for "<cdPipelineName>" cd pipeline
    And User enters "<cdPipelineName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                           | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                                            | cdPipelineName              | dockerStream                                  | stageName | stageDescription | qualityGateType | stepName | stageName1 | stageDescription1 | qualityGateType1 | stepName1 | codebaseJenkinsFolder                     | createReleaseJob                                         | applicationVersion | cdPipelineStage | cdPipelineStage1 |
      | java8-maven-create-def-vers-deploy-br     | Create           | Java         | java8           | Maven     | master     | new           | master            | default               | default          | NEW-Build-java8-maven-create-def-vers-deploy-br     | java8-maven-create-def-br   | java8-maven-create-def-vers-deploy-br-new     | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-maven-create-def-vers-deploy-br     | Create-release-java8-maven-create-def-vers-deploy-br     | latest             | sit             | qa               |
      | java11-maven-create-def-vers-deploy-br    | Create           | Java         | java11          | Maven     | master     | new           | master            | default               | default          | NEW-Build-java11-maven-create-def-vers-deploy-br    | java11-maven-create-def-br  | java11-maven-create-def-vers-deploy-br-new    | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-maven-create-def-vers-deploy-br    | Create-release-java11-maven-create-def-vers-deploy-br    | latest             | sit             | qa               |
      | java8-gradle-create-def-vers-deploy-br    | Create           | Java         | java8           | Gradle    | master     | new           | master            | default               | default          | NEW-Build-java8-gradle-create-def-vers-deploy-br    | java8-gradle-create-def-br  | java8-gradle-create-def-vers-deploy-br-new    | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-gradle-create-def-vers-deploy-br    | Create-release-java8-gradle-create-def-vers-deploy-br    | latest             | sit             | qa               |
      | java11-gradle-create-def-vers-deploy-br   | Create           | Java         | java11          | Gradle    | master     | new           | master            | default               | default          | NEW-Build-java11-gradle-create-def-vers-deploy-br   | java11-gradle-create-def-br | java11-gradle-create-def-vers-deploy-br-new   | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-gradle-create-def-vers-deploy-br   | Create-release-java11-gradle-create-def-vers-deploy-br   | latest             | sit             | qa               |
      | dotnet-2-1-create-def-vers-deploy-br      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | new           | master            | default               | default          | NEW-Build-dotnet-2-1-create-def-vers-deploy-br      | dotnet-2-1-create-def-br    | dotnet-2-1-create-def-vers-deploy-br-new      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | dotnet-2-1-create-def-vers-deploy-br      | Create-release-dotnet-2-1-create-def-vers-deploy-br      | latest             | sit             | qa               |
      | dotnet-3-1-create-def-vers-deploy-br      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | new           | master            | default               | default          | NEW-Build-dotnet-3-1-create-def-vers-deploy-br      | dotnet-3-1-create-def-br    | dotnet-3-1-create-def-vers-deploy-br-new      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | dotnet-3-1-create-def-vers-deploy-br      | Create-release-dotnet-3-1-create-def-vers-deploy-br      | latest             | sit             | qa               |
      | python-3-8-create-def-vers-deploy-br      | Create           | Python       | python-3.8      | Python    | master     | new           | master            | default               | default          | NEW-Build-python-3-8-create-def-vers-deploy-br      | python-3-8-create-def-br    | python-3-8-create-def-vers-deploy-br-new      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | python-3-8-create-def-vers-deploy-br      | Create-release-python-3-8-create-def-vers-deploy-br      | latest             | sit             | qa               |
      | javascript-create-def-vers-deploy-br      | Create           | JavaScript   | react           | NPM       | master     | new           | master            | default               | default          | NEW-Build-javascript-create-def-vers-deploy-br      | javascript-create-def-br    | javascript-create-def-vers-deploy-br-new      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | javascript-create-def-vers-deploy-br      | Create-release-javascript-create-def-vers-deploy-br      | latest             | sit             | qa               |
      | go-beego-create-def-vers-deploy-br        | Create           | Go           | beego           | Go        | master     | new           | master            | default               | default          | NEW-Build-go-beego-create-def-vers-deploy-br        | go-beego-create-def-br      | go-beego-create-def-vers-deploy-br-new        | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | go-beego-create-def-vers-deploy-br        | Create-release-go-beego-create-def-vers-deploy-br        | latest             | sit             | qa               |
      | go-operator-sdk-create-def-vers-deploy-br | Create           | Go           | operator-sdk    | Go        | master     | new           | master            | default               | default          | NEW-Build-go-operator-sdk-create-def-vers-deploy-br | go-sdk-create-def-br        | go-operator-sdk-create-def-vers-deploy-br-new | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | go-operator-sdk-create-def-vers-deploy-br | Create-release-go-operator-sdk-create-def-vers-deploy-br | latest             | sit             | qa               |


  Scenario Outline: Deploy added multi-module application using Create strategy with Default version from new branch
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
#    And User search "<applicationName>" application name
    Then User sees success status for "<applicationName>" application name
#    And User search "<applicationName>" application name
#    And User clicks "<applicationName>" application name
#    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Create' button
    And User enters "<newBranchName>" branch name
    And User clicks 'Proceed' button
    And User sees success status in Branches section for "<newBranchName>" branch
    And User clicks on Continuous Delivery tab
    And User clicks 'Create' button in CD pipeline tab
    And User enters "<cdPipelineName>" cd pipeline name
    And User clicks 'Proceed' button
    And User selects "<applicationName>" application by checkbox
    And User selects "<dockerStream>" docker stream for "<applicationName>"
    And User clicks 'Proceed' button
    And User clicks 'Add CD pipeline stage' button
    And User enters "<stageName>" cd pipeline stage name
    And User enters "<stageDescription>" description
    And User selects "<qualityGateType>" quality gate type
    And User enters "<stepName>" step name
    And User clicks 'Add' button
    And User clicks 'Add CD pipeline stage' button
    And User enters "<stageName1>" cd pipeline stage name
    And User enters "<stageDescription1>" description
    And User selects "<qualityGateType1>" quality gate type
    And User enters "<stepName1>" step name
    And User clicks 'Add' button
#    And User clicks 'Add CD pipeline stage' button
#    And User enters "<stageName2>" cd pipeline stage name
#    And User enters "<stageDescription2>" description
#    And User selects "<qualityGateType2>" quality gate type
#    And User enters "<stepName2>" step name
#    And User clicks 'Add' button
#    And User clicks 'Proceed' button
#    And User clicks 'Services' section
    And User clicks 'Create' button
    Then User sees success status for "<cdPipelineName>" cd pipeline name
    And User clicks 'Overview' tab
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    And User clicks 'Dashboard' button
    And User clicks "<cdPipelineName>" codebase jenkins folder
    And User clicks "<stageName>" job
    And User clicks 'Build with Parameters' button
    And User clicks 'Build' button
    And User opens 'job info' page
    And User clicks progress bar
    And User clicks 'Input requested' button
    And User selects "<applicationVersion>" application version for deploy
    Then User clicks 'Proceed' button in version info popup
    And User clicks Proceed' button to promote image
    And User opens "<cdPipelineName>" cd pipeline overview
    And User sees success status for "<cdPipelineStage>" cd pipeline stage
    And User clicks "<stageName1>" job
    And User clicks 'Build with Parameters' button
    And User clicks 'Build' button
    And User opens 'job info' page
    And User clicks progress bar
    And User clicks 'Input requested' button
    And User selects "<applicationVersion>" application version for deploy
    Then User clicks 'Proceed' button in version info popup
    And User clicks Proceed' button to promote image
    And User opens "<cdPipelineName>" cd pipeline overview
#    And User sees success status for "<cdPipelineStage1>" cd pipeline stage
    And User sees success status for "<cdPipelineStage1>" stage
#    And User clicks "<stageName2>" job
#    And User clicks 'Build with Parameters' button
#    And User clicks 'Build' button
#    And User opens 'job info' page
#    And User clicks progress bar
#    And User clicks 'Input requested' button
#    And User selects "<applicationVersion>" application version for deploy
#    Then User clicks 'Proceed' button in version info popup
#    And User clicks Proceed' button to promote image
#    And User opens "<cdPipelineName>" cd pipeline overview
#    And User sees success status for "<cdPipelineStage2>" cd pipeline stage
#    And User sees success status for "<cdPipelineStage2>" stage
    And User clicks on Continuous Delivery tab
    And User clicks 'delete' button for "<cdPipelineName>" cd pipeline
    And User enters "<cdPipelineName>" in confirmation name field
    And User clicks 'Delete confirmation' button
#    And User clicks on Application tab
#    And User search "<applicationName>" application name
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                             | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | newBranchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                                              | cdPipelineName            | dockerStream                                    | stageName | stageDescription | qualityGateType | stepName | stageName1 | stageDescription1 | qualityGateType1 | stepName1 | codebaseJenkinsFolder                       | createReleaseJob                                           | applicationVersion | cdPipelineStage | cdPipelineStage1 |
      | java8-maven-mult-create-def-vers-deploy-br  | Create           | Java         | java8           | Maven     | master     | new           | master            | default               | default          | NEW-Build-java8-maven-mult-create-def-vers-deploy-br  | java8-mult-create-def-br  | java8-maven-mult-create-def-vers-deploy-br-new  | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-maven-mult-create-def-vers-deploy-br  | Create-release-java8-maven-mult-create-def-vers-deploy-br  | latest             | sit             | qa               |
      | java11-maven-mult-create-def-vers-deploy-br | Create           | Java         | java11          | Maven     | master     | new           | master            | default               | default          | NEW-Build-java11-maven-mult-create-def-vers-deploy-br | java11-mult-create-def-br | java11-maven-mult-create-def-vers-deploy-br-new | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-maven-mult-create-def-vers-deploy-br | Create-release-java11-maven-mult-create-def-vers-deploy-br | latest             | sit             | qa               |
