Feature: Check builds for applications added with default versioning


  Scenario Outline: Create application using Create strategy
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
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User clicks 'Overview' tab
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
#    And User sees success status for "<buildJob>" build job
    And User checks success status for "<buildJob>" build job
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                 | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | codebaseJenkinsFolder           | createReleaseJob                               | buildJob                                     |
      | java8-maven-create-def-vers     | Create           | Java         | java8           | Maven     | master     | master            | default          | java8-maven-create-def-vers     | Create-release-java8-maven-create-def-vers     | MASTER-Build-java8-maven-create-def-vers     |
      | java11-maven-create-def-vers    | Create           | Java         | java11          | Maven     | master     | master            | default          | java11-maven-create-def-vers    | Create-release-java11-maven-create-def-vers    | MASTER-Build-java11-maven-create-def-vers    |
      | java8-gradle-create-def-vers    | Create           | Java         | java8           | Gradle    | master     | master            | default          | java8-gradle-create-def-vers    | Create-release-java8-gradle-create-def-vers    | MASTER-Build-java8-gradle-create-def-vers    |
      | java11-gradle-create-def-vers   | Create           | Java         | java11          | Gradle    | master     | master            | default          | java11-gradle-create-def-vers   | Create-release-java11-gradle-create-def-vers   | MASTER-Build-java11-gradle-create-def-vers   |
      | dotnet-2-1-create-def-vers      | Create           | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default          | dotnet-2-1-create-def-vers      | Create-release-dotnet-2-1-create-def-vers      | MASTER-Build-dotnet-2-1-create-def-vers      |
      | dotnet-3-1-create-def-vers      | Create           | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default          | dotnet-3-1-create-def-vers      | Create-release-dotnet-3-1-create-def-vers      | MASTER-Build-dotnet-3-1-create-def-vers      |
      | python-3-8-create-def-vers      | Create           | Python       | python-3.8      | Python    | master     | master            | default          | python-3-8-create-def-vers      | Create-release-python-3-8-create-def-vers      | MASTER-Build-python-3-8-create-def-vers      |
      | javascript-create-def-vers      | Create           | JavaScript   | react           | NPM       | master     | master            | default          | javascript-create-def-vers      | Create-release-javascript-create-def-vers      | MASTER-Build-javascript-create-def-vers      |
      | go-beego-create-def-vers        | Create           | Go           | beego           | Go        | master     | master            | default          | go-beego-create-def-vers        | Create-release-go-beego-create-def-vers        | MASTER-Build-go-beego-create-def-vers        |
      | go-operator-sdk-create-def-vers | Create           | Go           | operator-sdk    | Go        | master     | master            | default          | go-operator-sdk-create-def-vers | Create-release-go-operator-sdk-create-def-vers | MASTER-Build-go-operator-sdk-create-def-vers |


  Scenario Outline: Check pipelines in Jenkins for added Applications using Create strategy
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder           | createReleaseJob                               | buildJob                                     |
        | java8-maven-create-def-vers     | Create-release-java8-maven-create-def-vers     | MASTER-Build-java8-maven-create-def-vers     |
        | java11-maven-create-def-vers    | Create-release-java11-maven-create-def-vers    | MASTER-Build-java11-maven-create-def-vers    |
        | java8-gradle-create-def-vers    | Create-release-java8-gradle-create-def-vers    | MASTER-Build-java8-gradle-create-def-vers    |
        | java11-gradle-create-def-vers   | Create-release-java11-gradle-create-def-vers   | MASTER-Build-java11-gradle-create-def-vers   |
        | dotnet-2-1-create-def-vers      | Create-release-dotnet-2-1-create-def-vers      | MASTER-Build-dotnet-2-1-create-def-vers      |
        | dotnet-3-1-create-def-vers      | Create-release-dotnet-3-1-create-def-vers      | MASTER-Build-dotnet-3-1-create-def-vers      |
        | python-3-8-create-def-vers      | Create-release-python-3-8-create-def-vers      | MASTER-Build-python-3-8-create-def-vers      |
        | javascript-create-def-vers      | Create-release-javascript-create-def-vers      | MASTER-Build-javascript-create-def-vers      |
        | go-beego-create-def-vers        | Create-release-go-beego-create-def-vers        | MASTER-Build-go-beego-create-def-vers        |
        | go-operator-sdk-create-def-vers | Create-release-go-operator-sdk-create-def-vers | MASTER-Build-go-operator-sdk-create-def-vers |


  Scenario Outline: Delete added Applications using Create strategy
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase
#
    Examples:
        | applicationName                 |
        | java8-maven-create-def-vers     |
        | java11-maven-create-def-vers    |
        | java8-gradle-create-def-vers    |
        | java11-gradle-create-def-vers   |
        | dotnet-2-1-create-def-vers      |
        | dotnet-3-1-create-def-vers      |
        | python-3-8-create-def-vers      |
        | javascript-create-def-vers      |
        | go-beego-create-def-vers        |
        | go-operator-sdk-create-def-vers |



  Scenario Outline: Create multi-module application using Create strategy
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
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                   | codebaseStrategy | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   |
      | java8-maven-mult-create-def-vers  | Create           | Java         | java8           | Maven     | master     | master            | default          |
      | java11-maven-mult-create-def-vers | Create           | Java         | java11          | Maven     | master     | master            | default          |


  Scenario Outline: Check pipelines in Jenkins for added multimodule Applications using Create strategy
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder             | createReleaseJob                                 | buildJob                                       |
        | java8-maven-mult-create-def-vers  | Create-release-java8-maven-mult-create-def-vers  | MASTER-Build-java8-maven-mult-create-def-vers  |
        | java11-maven-mult-create-def-vers | Create-release-java11-maven-mult-create-def-vers | MASTER-Build-java11-maven-mult-create-def-vers |
#
#

  Scenario Outline: Delete added multimodule Applications using Create strategy
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName                   |
        | java8-maven-mult-create-def-vers  |
        | java11-maven-mult-create-def-vers |


  Scenario Outline: Create application using Clone strategy (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
    And User checks 'Codebase Authentication' check-box
    And User enters "<repositoryLogin>" for Gitlab in repository login field
    And User enters "<repositoryPassword>" for Gitlab in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User clicks 'Proceed' button
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName                       | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   |
      | java8-maven-clone-gitlab-def-vers     | Clone            | java8-gitlab          | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          |
      | java8-gradle-clone-gitlab-def-vers    | Clone            | java8-gradle-gitlab   | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Gradle    | master     | master            | default          |
      | java11-gradle-clone-gitlab-def-vers   | Clone            | java11-gitlab         | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Gradle    | master     | master            | default          |
      | java11-maven-clone-gitlab-def-vers    | Clone            | java11-maven-gitlab   | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          |
      | dotnet-3-1-clone-gitlab-def-vers      | Clone            | dotnet31-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default          |
      | dotnet-2-1-clone-gitlab-def-vers      | Clone            | dotnet21-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default          |
      | python-3-8-clone-gitlab-def-vers      | Clone            | python38-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | Python       | python-3.8      | Python    | master     | master            | default          |
      | javascript-clone-gitlab-def-vers      | Clone            | javascript-gitlab     | gitlabRepositoryLogin | gitlabRepositoryPassword | JavaScript   | react           | NPM       | master     | master            | default          |
      | go-beego-clone-gitlab-def-vers        | Clone            | go-beego-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | Go           | beego           | Go        | master     | master            | default          |
      | go-operator-sdk-clone-gitlab-def-vers | Clone            | go-operatorsdk-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Go           | operator-sdk    | Go        | master     | master            | default          |



  Scenario Outline: Check pipelines in Jenkins for added Applications using Clone strategy (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder                 | createReleaseJob                                     | buildJob                                           |
        | java8-maven-clone-gitlab-def-vers     | Create-release-java8-maven-clone-gitlab-def-vers     | MASTER-Build-java8-maven-clone-gitlab-def-vers     |
        | java8-gradle-clone-gitlab-def-vers    | Create-release-java8-gradle-clone-gitlab-def-vers    | MASTER-Build-java8-gradle-clone-gitlab-def-vers    |
        | java11-gradle-clone-gitlab-def-vers   | Create-release-java11-gradle-clone-gitlab-def-vers   | MASTER-Build-java11-gradle-clone-gitlab-def-vers   |
        | java11-maven-clone-gitlab-def-vers    | Create-release-java11-maven-clone-gitlab-def-vers    | MASTER-Build-java11-maven-clone-gitlab-def-vers    |
        | dotnet-3-1-clone-gitlab-def-vers      | Create-release-dotnet-3-1-clone-gitlab-def-vers      | MASTER-Build-dotnet-3-1-clone-gitlab-def-vers      |
        | dotnet-2-1-clone-gitlab-def-vers      | Create-release-dotnet-2-1-clone-gitlab-def-vers      | MASTER-Build-dotnet-2-1-clone-gitlab-def-vers      |
        | python-3-8-clone-gitlab-def-vers      | Create-release-python-3-8-clone-gitlab-def-vers      | MASTER-Build-python-3-8-clone-gitlab-def-vers      |
        | javascript-clone-gitlab-def-vers      | Create-release-javascript-clone-gitlab-def-vers      | MASTER-Build-javascript-clone-gitlab-def-vers      |
        | go-beego-clone-gitlab-def-vers        | Create-release-go-beego-clone-gitlab-def-vers        | MASTER-Build-go-beego-clone-gitlab-def-vers        |
        | go-operator-sdk-clone-gitlab-def-vers | Create-release-go-operator-sdk-clone-gitlab-def-vers | MASTER-Build-go-operator-sdk-clone-gitlab-def-vers |



  Scenario Outline: Delete added Applications using Clone strategy (Gitlab)
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName                       |
        | java8-maven-clone-gitlab-def-vers     |
        | java11-gradle-clone-gitlab-def-vers   |
        | dotnet-3-1-clone-gitlab-def-vers      |
        | python-3-8-clone-gitlab-def-vers      |
        | javascript-clone-gitlab-def-vers      |
        | go-beego-clone-gitlab-def-vers        |
        | go-operator-sdk-clone-gitlab-def-vers |
        | dotnet-2-1-clone-gitlab-def-vers      |


  Scenario Outline: Create multi-module application using Clone strategy (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
    And User checks 'Codebase Authentication' check-box
    And User enters "<repositoryLogin>" for Gitlab in repository login field
    And User enters "<repositoryPassword>" for Gitlab in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User checks 'Multi-module Project' checkbox
    And User clicks 'Proceed' button
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName                         | codebaseStrategy | repository               | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   |
      | java8-maven-mult-clone-gitlab-def-vers  | Clone            | java8-multimodule-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          |
      | java11-maven-mult-clone-gitlab-def-vers | Clone            | java8-multimodule-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          |


  Scenario Outline: Check pipelines in Jenkins for added multimodule Applications using Clone strategy
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder                   | createReleaseJob                                       | buildJob                                             |
        | java8-maven-mult-clone-gitlab-def-vers  | Create-release-java8-maven-mult-clone-gitlab-def-vers  | MASTER-Build-java8-maven-mult-clone-gitlab-def-vers  |
        | java11-maven-mult-clone-gitlab-def-vers | Create-release-java11-maven-mult-clone-gitlab-def-vers | MASTER-Build-java11-maven-mult-clone-gitlab-def-vers |



  Scenario Outline: Delete added multimodule Applications using Create strategy
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName                         |
        | java8-maven-mult-clone-gitlab-def-vers  |
        | java11-maven-mult-clone-gitlab-def-vers |
#

  Scenario Outline: Create application using Clone strategy (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
    And User checks 'Codebase Authentication' check-box
    And User enters "<repositoryLogin>" for Github in repository login field
    And User enters "<repositoryPassword>" for Github in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User clicks 'Proceed' button
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName                       | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   |
      | java8-maven-clone-github-def-vers     | Clone            | java8-mavem-github    | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          |
      | java8-gradle-clone-github-def-vers    | Clone            | java8-gradle-github   | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Gradle    | master     | master            | default          |
      | java11-maven-clone-github-def-vers    | Clone            | java11-mavem-github   | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          |
      | java11-gradle-clone-github-def-vers   | Clone            | java11-gradle-github  | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Gradle    | master     | master            | default          |
      | go-beego-clone-github-def-vers        | Clone            | go-beego-github       | githubRepositoryLogin | githubRepositoryPassword | Go           | beego           | Go        | master     | master            | default          |
      | go-operator-sdk-clone-github-def-vers | Clone            | go-operatorsdk-github | githubRepositoryLogin | githubRepositoryPassword | Go           | operator-sdk    | Go        | master     | master            | default          |
      | python-3-8-clone-github-def-vers      | Clone            | python38-github       | githubRepositoryLogin | githubRepositoryPassword | Python       | python-3.8      | Python    | master     | master            | default          |
      | javascript-clone-github-def-vers      | Clone            | javascript-github     | githubRepositoryLogin | githubRepositoryPassword | JavaScript   | react           | NPM       | master     | master            | default          |
      | dotnet-3-1-clone-github-def-vers      | Clone            | dotnet31-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet       | dotnet-3.1      | dotnet    | master     | master            | default          |
      | dotnet-2-1-clone-github-def-vers      | Clone            | dotnet21-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet       | dotnet-2.1      | dotnet    | master     | master            | default          |


  Scenario Outline: Check pipelines in Jenkins for added Applications using Clone strategy (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder                 | createReleaseJob                                     | buildJob                                           |
        | java8-maven-clone-github-def-vers     | Create-release-java8-maven-clone-github-def-vers     | MASTER-Build-java8-maven-clone-github-def-vers     |
        | java8-gradle-clone-github-def-vers    | Create-release-java8-gradle-clone-github-def-vers    | MASTER-Build-java8-gradle-clone-github-def-vers    |
        | java11-maven-clone-github-def-vers    | Create-release-java11-maven-clone-github-def-vers    | MASTER-Build-java11-maven-clone-github-def-vers    |
        | java11-gradle-clone-github-def-vers   | Create-release-java11-gradle-clone-github-def-vers   | MASTER-Build-java11-gradle-clone-github-def-vers   |
        | go-beego-clone-github-def-vers        | Create-release-go-beego-clone-github-def-vers        | MASTER-Build-go-beego-clone-github-def-vers        |
        | go-operator-sdk-clone-github-def-vers | Create-release-go-operator-sdk-clone-github-def-vers | MASTER-Build-go-operator-sdk-clone-github-def-vers |
        | python-3-8-clone-github-def-vers      | Create-release-python-3-8-clone-github-def-vers      | MASTER-Build-python-3-8-clone-github-def-vers      |
        | javascript-clone-github-def-vers      | Create-release-javascript-clone-github-def-vers      | MASTER-Build-javascript-clone-github-def-vers      |
        | dotnet-3-1-clone-github-def-vers      | Create-release-dotnet-3-1-clone-github-def-vers      | MASTER-Build-dotnet-3-1-clone-github-def-vers      |
        | dotnet-2-1-clone-github-def-vers      | Create-release-dotnet-2-1-clone-github-def-vers      | MASTER-Build-dotnet-2-1-clone-github-def-vers      |


  Scenario Outline: Delete added Applications using Clone strategy (Github)
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName                       |
        | java8-maven-clone-github-def-vers     |
        | java8-gradle-clone-github-def-vers    |
        | java11-maven-clone-github-def-vers    |
        | java11-gradle-clone-github-def-vers   |
        | go-beego-clone-github-def-vers        |
        | go-operator-sdk-clone-github-def-vers |
        | python-3-8-clone-github-def-vers      |
        | javascript-clone-github-def-vers      |
        | dotnet-3-1-clone-github-def-vers      |
        | dotnet-2-1-clone-github-def-vers      |


  Scenario Outline: Create multi-module application using Clone strategy (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks on Application tab
    And User clicks 'Create' button
    And User selects "<codebaseStrategy>" codebase integration strategy
    And User enters "<repository>" in git repository url field
    And User checks 'Codebase Authentication' check-box
    And User enters "<repositoryLogin>" for Github in repository login field
    And User enters "<repositoryPassword>" for Github in repository password field
    And User clicks 'Proceed' button
    And User enters "<applicationName>" in application name field
    And User enters "<defaultBranchName>" default branch name
    And User selects "<codeLanguage>" application code language
    And User selects "<languageVersion>" language version
    And User selects "<buildTool>" build tool
    And User checks 'Multi-module Project' checkbox
    And User clicks 'Proceed' button
    And User selects "<versioningType>" codebase versioning type
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                         | codebaseStrategy | repository                | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   |
      | java8-maven-mult-clone-github-def-vers  | Clone            | java8-multimodule-github  | githubRepositoryLogin | githubRepositoryPassword | Java         | java8           | Maven     | master     | master            | default          |
      | java11-maven-mult-clone-github-def-vers | Clone            | java11-multimodule-github | githubRepositoryLogin | githubRepositoryPassword | Java         | java11          | Maven     | master     | master            | default          |


  Scenario Outline: Check pipelines in Jenkins for added multimodule Applications using Clone strategy (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder                   | createReleaseJob                                       | buildJob                                             |
        | java8-maven-mult-clone-github-def-vers  | Create-release-java8-maven-mult-clone-github-def-vers  | MASTER-Build-java8-maven-mult-clone-github-def-vers  |
        | java11-maven-mult-clone-github-def-vers | Create-release-java11-maven-mult-clone-github-def-vers | MASTER-Build-java11-maven-mult-clone-github-def-vers |


  Scenario Outline: Delete added multimodule Applications using Clone strategy (Github)
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName                         |
        | java8-maven-mult-clone-github-def-vers  |
        | java11-maven-mult-clone-github-def-vers |
#

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
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName  | codebaseStrategy | gitServer | relativePath          | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   |
      | java8-gradle     | Import           | git-epam  | java8-gradle-gitlab   | Java         | java8           | Gradle    | master     | master            | gitlab                | default          |
      | java8-maven      | Import           | git-epam  | java8-gitlab          | Java         | java8           | Maven     | master     | master            | gitlab                | default          |
      | java11-gradle    | Import           | git-epam  | java11-gitlab         | Java         | java11          | Gradle    | master     | master            | gitlab                | default          |
      | java11-maven     | Import           | git-epam  | java11-maven-gitlab   | Java         | java11          | Maven     | master     | master            | gitlab                | default          |
      | dotnet-3-1       | Import           | git-epam  | dotnet31-gitlab       | DotNet       | dotnet-3.1      | dotnet    | master     | master            | gitlab                | default          |
      | dotnet-2-1       | Import           | git-epam  | dotnet21-gitlab       | DotNet       | dotnet-2.1      | dotnet    | master     | master            | gitlab                | default          |
      | python-3-8       | Import           | git-epam  | python38-gitlab       | Python       | python-3.8      | Python    | master     | master            | gitlab                | default          |
      | javascript-react | Import           | git-epam  | javascript-gitlab     | JavaScript   | react           | NPM       | master     | master            | gitlab                | default          |
      | go-beego         | Import           | git-epam  | go-beego-gitlab       | Go           | beego           | Go        | master     | master            | gitlab                | default          |
      | go-operator-sdk  | Import           | git-epam  | go-operatorsdk-gitlab | Go           | operator-sdk    | Go        | master     | master            | gitlab                | default          |


  Scenario Outline: Check pipelines in Jenkins for added Applications using Import strategy (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder | createReleaseJob                | buildJob                      |
        | java8-gradle          | Create-release-java8-gradle     | MASTER-Build-java8-gradle     |
        | java8-maven           | Create-release-java8-maven      | MASTER-Build-java8-maven      |
        | java11-gradle         | Create-release-java11-gradle    | MASTER-Build-java11-gradle    |
        | java11-maven          | Create-release-java11-maven     | MASTER-Build-java11-maven     |
        | dotnet-3-1            | Create-release-dotnet-3-1       | MASTER-Build-dotnet-3-1       |
        | dotnet-2-1            | Create-release-dotnet-2-1       | MASTER-Build-dotnet-2-1       |
        | python-3-8            | Create-release-python-3-8       | MASTER-Build-python-3-8       |
        | javascript-react      | Create-release-javascript-react | MASTER-Build-javascript-react |
        | go-beego              | Create-release-go-beego         | MASTER-Build-go-beego         |
        | go-operator-sdk       | Create-release-go-operator-sdk  | MASTER-Build-go-operator-sdk  |


  Scenario Outline: Delete added Applications using Import strategy (Gitlab)
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName  |
        | java8-gradle     |
        | java8-maven      |
        | java11-gradle    |
        | java11-maven     |
        | dotnet-3-1       |
        | dotnet-2-1       |
        | python-3-8       |
        | javascript-react |
        | go-beego         |
        | go-operator-sdk  |


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
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName          | codebaseStrategy | gitServer | relativePath              | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   |
      | java8-maven-multimodule  | Import           | git-epam  | java8-multimodule-gitlab  | Java         | java8           | Maven     | master     | master            | gitlab                | default          |
      | java11-maven-multimodule | Import           | git-epam  | java11-multimodule-gitlab | Java         | java11          | Maven     | master     | master            | gitlab                | default          |


  Scenario Outline: Check pipelines in Jenkins for added multimodule Applications using Import strategy (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder    | createReleaseJob                        | buildJob                              |
        | java8-maven-multimodule  | Create-release-java8-maven-multimodule  | MASTER-Build-java8-maven-multimodule  |
        | java11-maven-multimodule | Create-release-java11-maven-multimodule | MASTER-Build-java11-maven-multimodule |


  Scenario Outline: Delete added multimodule Applications using Import strategy (Gitlab)
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName          |
        | java8-maven-multimodule  |
        | java11-maven-multimodule |
#

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
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase
    Examples:
      | applicationName          | codebaseStrategy | gitServer | relativePath          | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   |
      | java-maven-java8         | Import           | github    | java8-mavem-github    | Java         | java8           | Maven     | master     | master            | github                | default          |
      | java-gradle-java8        | Import           | github    | java8-gradle-github   | Java         | java8           | Gradle    | master     | master            | github                | default          |
      | java-maven-java11        | Import           | github    | java11-mavem-github   | Java         | java11          | Maven     | master     | master            | github                | default          |
      | java-gradle-java11       | Import           | github    | java11-gradle-github  | Java         | java11          | Gradle    | master     | master            | github                | default          |
      | python-python-python-3-8 | Import           | github    | python38-github       | Python       | python-3.8      | Python    | master     | master            | github                | default          |
      | javascript-npm-react     | Import           | github    | javascript-github     | JavaScript   | react           | NPM       | master     | master            | github                | default          |
      | dotnet-dotnet-dotnet-3-1 | Import           | github    | dotnet31-github       | DotNet       | dotnet-3.1      | dotnet    | master     | master            | gitlab                | default          |
      | dotnet-dotnet-dotnet-2-1 | Import           | github    | dotnet21-github       | DotNet       | dotnet-2.1      | dotnet    | master     | master            | gitlab                | default          |
      | go-go-beego              | Import           | github    | go-beego-github       | Go           | beego           | Go        | master     | master            | gitlab                | default          |
      | go-go-operator-sdk       | Import           | github    | go-operatorsdk-github | Go           | operator-sdk    | Go        | master     | master            | gitlab                | default          |


  Scenario Outline: Check pipelines in Jenkins for added Applications using Import strategy (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder    | createReleaseJob                        | buildJob                              |
        | java-maven-java8         | Create-release-java-maven-java8         | MASTER-Build-java-maven-java8         |
        | java-gradle-java8        | Create-release-java-gradle-java8        | MASTER-Build-java-gradle-java8        |
        | java-maven-java11        | Create-release-java-maven-java11        | MASTER-Build-java-maven-java11        |
        | java-gradle-java11       | Create-release-java-gradle-java11       | MASTER-Build-java-gradle-java11       |
        | python-python-python-3-8 | Create-release-python-python-python-3-8 | MASTER-Build-python-python-python-3-8 |
        | javascript-npm-react     | Create-release-javascript-npm-react     | MASTER-Build-javascript-npm-react     |
        | dotnet-dotnet-dotnet-3-1 | Create-release-dotnet-dotnet-dotnet-3-1 | MASTER-Build-dotnet-dotnet-dotnet-3-1 |
        | dotnet-dotnet-dotnet-2-1 | dotnet-dotnet-dotnet-2-1                | MASTER-Build-dotnet-dotnet-dotnet-2-1 |
        | go-go-beego              | Create-release-go-go-beego              | MASTER-Build-go-go-beego              |
        | go-go-operator-sdk       | Create-release-go-go-operator-sdk       | MASTER-Build-go-go-operator-sdk       |


  Scenario Outline: Delete added Applications using Import strategy (Github)
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName          |
        | java-maven-java8         |
        | java-gradle-java8        |
        | java-maven-java11        |
        | java-gradle-java11       |
        | python-python-python-3-8 |
        | javascript-npm-react     |
        | dotnet-dotnet-dotnet-3-1 |
        | dotnet-dotnet-dotnet-2-1 |
        | go-go-beego              |
        | go-go-operator-sdk       |



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
    And User clicks 'Proceed' button
    And User clicks 'Proceed' button
    And User clicks 'Create' button
    And User clicks 'Continue' button in confirmation popup
    Then User sees success status for "<applicationName>" application name
    And User clicks "<applicationName>" application name
    And User sees success status in Branches section for "<branchName>" branch
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName               | codebaseStrategy | gitServer | relativePath              | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | ciPipelineProvisioner | versioningType   |
      | java-maven-java8-multimodule  | Import           | github    | java8-multimodule-github  | Java         | java8           | Maven     | master     | master            | github                | default          |
      | java-maven-java11-multimodule | Import           | github    | java11-multimodule-github | Java         | java11          | Maven     | master     | master            | github                | default          |


  Scenario Outline: Check pipelines in Jenkins for added multimodule Applications using Import strategy (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    And User clicks 'Jenkins' link
    And User clicks "<codebaseJenkinsFolder>" codebase jenkins folder
    And User sees success status for "<createReleaseJob>" create release job
    And User sees success status for "<buildJob>" build job
    Examples:
        | codebaseJenkinsFolder         | createReleaseJob                             | buildJob                                   |
        | java-maven-java8-multimodule  | Create-release-java-maven-java8-multimodule  | MASTER-Build-java-maven-java8-multimodule  |
        | java-maven-java11-multimodule | Create-release-java-maven-java11-multimodule | MASTER-Build-java-maven-java11-multimodule |


  Scenario Outline: Delete added multimodule Applications using Import strategy (Github)
#    Given User opens EDP Admin Console
#    When User enters "<username>" in username field
#    And User enters "<password>" in password field
#    And User clicks 'login' button
#    And User clicks on Application tab
#    And User clicks 'delete codebase' button
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User sends request to get ac-creator secret
    And User sends request to get admin-console-client secret
    And User sends request to get token
    And User deletes "<applicationName>" codebase

    Examples:
        | applicationName               |
        | java-maven-java8-multimodule  |
        | java-maven-java11-multimodule |