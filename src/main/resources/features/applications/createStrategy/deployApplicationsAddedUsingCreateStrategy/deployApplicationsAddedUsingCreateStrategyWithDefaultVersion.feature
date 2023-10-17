Feature: Deploy applications added using Create strategy with default versioning type


  Scenario Outline: Deploy added application using Create strategy with Default version
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
    And User sees success status in Branches section for "<branchName>" branch
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
      | applicationName                        | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                                            | cdPipelineName           | dockerStream                                  | stageName | stageDescription | qualityGateType | stepName | stageName1 | stageDescription1 | qualityGateType1 | stepName1 | codebaseJenkinsFolder                  | createReleaseJob                                      | applicationVersion | cdPipelineStage | cdPipelineStage1 |
      | java8-maven-create-def-vers-deploy     | Create           | Java         | java8           | Maven     | master     | master            | default               | default          | MASTER-Build-java8-maven-create-def-vers-deploy     | java8-maven-create-def   | java8-maven-create-def-vers-deploy-master     | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-maven-create-def-vers-deploy     | Create-release-java8-maven-create-def-vers-deploy     | latest             | sit             | qa               |
      | java11-maven-create-def-vers-deploy    | Create           | Java         | java11          | Maven     | master     | master            | default               | default          | MASTER-Build-java11-maven-create-def-vers-deploy    | java11-maven-create-def  | java11-maven-create-def-vers-deploy-master    | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-maven-create-def-vers-deploy    | Create-release-java11-maven-create-def-vers-deploy    | latest             | sit             | qa               |
      | java8-gradle-create-def-vers-deploy    | Create           | Java         | java8           | Gradle    | master     | master            | default               | default          | MASTER-Build-java8-gradle-create-def-vers-deploy    | java8-gradle-create-def  | java8-gradle-create-def-vers-deploy-master    | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-gradle-create-def-vers-deploy    | Create-release-java8-gradle-create-def-vers-deploy    | latest             | sit             | qa               |
      | java11-gradle-create-def-vers-deploy   | Create           | Java         | java11          | Gradle    | master     | master            | default               | default          | MASTER-Build-java11-gradle-create-def-vers-deploy   | java11-gradle-create-def | java11-gradle-create-def-vers-deploy-master   | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-gradle-create-def-vers-deploy   | Create-release-java11-gradle-create-def-vers-deploy   | latest             | sit             | qa               |
      | dotnet-2-1-create-def-vers-deploy      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default               | default          | MASTER-Build-dotnet-2-1-create-def-vers-deploy      | dotnet-2-1-create-def    | dotnet-2-1-create-def-vers-deploy-master      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | dotnet-2-1-create-def-vers-deploy      | Create-release-dotnet-2-1-create-def-vers-deploy      | latest             | sit             | qa               |
      | dotnet-3-1-create-def-vers-deploy      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default               | default          | MASTER-Build-dotnet-3-1-create-def-vers-deploy      | dotnet-3-1-create-def    | dotnet-3-1-create-def-vers-deploy-master      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | dotnet-3-1-create-def-vers-deploy      | Create-release-dotnet-3-1-create-def-vers-deploy      | latest             | sit             | qa               |
      | python-3-8-create-def-vers-deploy      | Create           | Python       | python-3.8      | Python    | master     | master            | default               | default          | MASTER-Build-python-3-8-create-def-vers-deploy      | python-3-8-create-def    | python-3-8-create-def-vers-deploy-master      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | python-3-8-create-def-vers-deploy      | Create-release-python-3-8-create-def-vers-deploy      | latest             | sit             | qa               |
      | javascript-create-def-vers-deploy      | Create           | JavaScript   | react           | NPM       | master     | master            | default               | default          | MASTER-Build-javascript-create-def-vers-deploy      | javascript-create-def    | javascript-create-def-vers-deploy-master      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | javascript-create-def-vers-deploy      | Create-release-javascript-create-def-vers-deploy      | latest             | sit             | qa               |
      | go-beego-create-def-vers-deploy        | Create           | Go           | beego           | Go        | master     | master            | default               | default          | MASTER-Build-go-beego-create-def-vers-deploy        | go-beego-create-def      | go-beego-create-def-vers-deploy-master        | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | go-beego-create-def-vers-deploy        | Create-release-go-beego-create-def-vers-deploy        | latest             | sit             | qa               |
      | go-operator-sdk-create-def-vers-deploy | Create           | Go           | operator-sdk    | Go        | master     | master            | default               | default          | MASTER-Build-go-operator-sdk-create-def-vers-deploy | go-sdk-create-def        | go-operator-sdk-create-def-vers-deploy-master | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | go-operator-sdk-create-def-vers-deploy | Create-release-go-operator-sdk-create-def-vers-deploy | latest             | sit             | qa               |


  Scenario Outline: Deploy added multi-module application using Create strategy with Default version
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
    And User sees success status in Branches section for "<branchName>" branch
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
      | applicationName                          | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   | buildJob                                              | cdPipelineName         | dockerStream                                    | stageName | stageDescription | qualityGateType | stepName | stageName1 | stageDescription1 | qualityGateType1 | stepName1 | codebaseJenkinsFolder                    | createReleaseJob                                        | applicationVersion | cdPipelineStage | cdPipelineStage1 |
      | java8-maven-mult-create-def-vers-deploy  | Create           | Java         | java8           | Maven     | master     | master            | default               | default          | MASTER-Build-java8-maven-mult-create-def-vers-deploy  | java8-mult-create-def  | java8-maven-mult-create-def-vers-deploy-master  | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-maven-mult-create-def-vers-deploy  | Create-release-java8-maven-mult-create-def-vers-deploy  | latest             | sit             | qa               |
      | java11-maven-mult-create-def-vers-deploy | Create           | Java         | java11          | Maven     | master     | master            | default               | default          | MASTER-Build-java11-maven-mult-create-def-vers-deploy | java11-mult-create-def | java11-maven-mult-create-def-vers-deploy-master | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-maven-mult-create-def-vers-deploy | Create-release-java11-maven-mult-create-def-vers-deploy | latest             | sit             | qa               |
