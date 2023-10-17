Feature: Deploy applications added using Clone strategy from public repository with default versioning type


  Scenario Outline: Deploy application added using Clone strategy from public repository with Default version (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
#    And User checks 'Codebase Authentication' check-box
#    And User enters "<repositoryLogin>" for Github in repository login field
#    And User enters "<repositoryPassword>" for Github in repository password field
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
      | applicationName                              | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | buildJob                                                  | cdPipelineName               | dockerStream                                        | stageName | stageDescription | qualityGateType | stepName | stageName1 | stageDescription1 | qualityGateType1 | stepName1 | codebaseJenkinsFolder                        | createReleaseJob                                            | applicationVersion | cdPipelineStage | cdPipelineStage1 |
      | java8-maven-clone-github-def-vers-deploy     | Clone            | java8-mavem-github    | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          | MASTER-Build-java8-maven-clone-github-def-vers-deploy     | java8-maven-clone-github-def | java8-maven-clone-github-def-vers-deploy-master     | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-maven-clone-github-def-vers-deploy     | Create-release-java8-maven-clone-github-def-vers-deploy     | latest             | sit             | qa               |
      | java8-gradle-clone-github-def-vers-deploy    | Clone            | java8-gradle-github   | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Gradle    | master     | master            | default          | MASTER-Build-java8-gradle-clone-github-def-vers-deploy    | java8-grad-clone-github-def  | java8-gradle-clone-github-def-vers-deploy-master    | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-gradle-clone-github-def-vers-deploy    | Create-release-java8-gradle-clone-github-def-vers-deploy    | latest             | sit             | qa               |
      | java11-maven-clone-github-def-vers-deploy    | Clone            | java11-mavem-github   | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          | MASTER-Build-java11-maven-clone-github-def-vers-deploy    | java11-mav-clone-github-def  | java11-maven-clone-github-def-vers-deploy-master    | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-maven-clone-github-def-vers-deploy    | Create-release-java11-maven-clone-github-def-vers-deploy    | latest             | sit             | qa               |
      | java11-gradle-clone-github-def-vers-deploy   | Clone            | java11-gradle-github  | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Gradle    | master     | master            | default          | MASTER-Build-java11-gradle-clone-github-def-vers-deploy   | java11-grad-clone-github-def | java11-gradle-clone-github-def-vers-deploy-master   | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-gradle-clone-github-def-vers-deploy   | Create-release-java11-gradle-clone-github-def-vers-deploy   | latest             | sit             | qa               |
      | go-beego-clone-github-def-vers-deploy        | Clone            | go-beego-github       | githubRepositoryLogin | githubRepositoryPassword | Go           | beego           | Go        | master     | master            | default          | MASTER-Build-go-beego-clone-github-def-vers-deploy        | go-beego-clone-github-def    | go-beego-clone-github-def-vers-deploy-master        | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | go-beego-clone-github-def-vers-deploy        | Create-release-go-beego-clone-github-def-vers-deploy        | latest             | sit             | qa               |
      | go-operator-sdk-clone-github-def-vers-deploy | Clone            | go-operatorsdk-github | githubRepositoryLogin | githubRepositoryPassword | Go           | operator-sdk    | Go        | master     | master            | default          | MASTER-Build-go-operator-sdk-clone-github-def-vers-deploy | go-sdk-clone-github-def      | go-operator-sdk-clone-github-def-vers-deploy-master | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | go-operator-sdk-clone-github-def-vers-deploy | Create-release-go-operator-sdk-clone-github-def-vers-deploy | latest             | sit             | qa               |
      | python-3-8-clone-github-def-vers-deploy      | Clone            | python38-github       | githubRepositoryLogin | githubRepositoryPassword | Python       | python-3.8      | Python    | master     | master            | default          | MASTER-Build-python-3-8-clone-github-def-vers-deploy      | python-3-8-clone-github-def  | python-3-8-clone-github-def-vers-deploy-master      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | python-3-8-clone-github-def-vers-deploy      | Create-release-python-3-8-clone-github-def-vers-deploy      | latest             | sit             | qa               |
      | javascript-clone-github-def-vers-deploy      | Clone            | javascript-github     | githubRepositoryLogin | githubRepositoryPassword | JavaScript   | react           | NPM       | master     | master            | default          | MASTER-Build-javascript-clone-github-def-vers-deploy      | javascript-clone-github-def  | javascript-clone-github-def-vers-deploy-master      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | javascript-clone-github-def-vers-deploy      | Create-release-javascript-clone-github-def-vers-deploy      | latest             | sit             | qa               |
      | dotnet-3-1-clone-github-def-vers-deploy      | Clone            | dotnet31-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default          | MASTER-Build-dotnet-3-1-clone-github-def-vers-deploy      | dotnet-3-1-clone-github-def  | dotnet-3-1-clone-github-def-vers-deploy-master      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | dotnet-3-1-clone-github-def-vers-deploy      | Create-release-dotnet-3-1-clone-github-def-vers-deploy      | latest             | sit             | qa               |
      | dotnet-2-1-clone-github-def-vers-deploy      | Clone            | dotnet21-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default          | MASTER-Build-dotnet-2-1-clone-github-def-vers-deploy      | dotnet-2-1-clone-github-def  | dotnet-2-1-clone-github-def-vers-deploy-master      | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | dotnet-2-1-clone-github-def-vers-deploy      | Create-release-dotnet-2-1-clone-github-def-vers-deploy      | latest             | sit             | qa               |



  Scenario Outline: Deploy multi-module application added using Clone strategy from public repository with Default version (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
#    And User checks 'Codebase Authentication' check-box
#    And User enters "<repositoryLogin>" for Github in repository login field
#    And User enters "<repositoryPassword>" for Github in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User checks 'Multi-module Project' checkbox
    And User clicks 'Proceed' button
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
      | applicationName                                | codebaseStrategy | repository                | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | buildJob                                                    | cdPipelineName               | dockerStream                                          | stageName | stageDescription | qualityGateType | stepName | stageName1 | stageDescription1 | qualityGateType1 | stepName1 | codebaseJenkinsFolder                          | createReleaseJob                                              | applicationVersion | cdPipelineStage | cdPipelineStage1 |
      | java8-maven-mult-clone-github-def-vers-deploy  | Clone            | java8-multimodule-github  | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          | MASTER-Build-java8-maven-mult-clone-github-def-vers-deploy  | java8-mult-clone-github-def  | java8-maven-mult-clone-github-def-vers-deploy-master  | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java8-maven-mult-clone-github-def-vers-deploy  | Create-release-java8-maven-mult-clone-github-def-vers-deploy  | latest             | sit             | qa               |
      | java11-maven-mult-clone-github-def-vers-deploy | Clone            | java11-multimodule-github | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          | MASTER-Build-java11-maven-mult-clone-github-def-vers-deploy | java11-mult-clone-github-def | java11-maven-mult-clone-github-def-vers-deploy-master | sit       | sit              | manual          | sit      | qa         | qa                | manual           | qa        | java11-maven-mult-clone-github-def-vers-deploy | Create-release-java11-maven-mult-clone-github-def-vers-deploy | latest             | sit             | qa               |
