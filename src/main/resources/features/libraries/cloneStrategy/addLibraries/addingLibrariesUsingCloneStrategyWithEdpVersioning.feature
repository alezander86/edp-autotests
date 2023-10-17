Feature: Libraries provisioning using Clone strategy with EDP versioning type


  Scenario Outline: Create library using Clone strategy from private repository (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Libraries tab
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
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
#    And User clicks on Libraries tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                           | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage    | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                               | codeReviewJob                                                |
      | java8-maven-lib-clone-gitlab-edp-vers     | Clone            | java8-gitlab          | gitlabRepositoryLogin | gitlabRepositoryPassword | Java            | java8           | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-maven-lib-clone-gitlab-edp-vers     | MASTER-Code-review-java8-maven-lib-clone-gitlab-edp-vers     |
      | java8-gradle-lib-clone-gitlab-edp-vers    | Clone            | java8-gradle-gitlab   | gitlabRepositoryLogin | gitlabRepositoryPassword | Java            | java8           | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-gradle-lib-clone-gitlab-edp-vers    | MASTER-Code-review-java8-gradle-lib-clone-gitlab-edp-vers    |
      | java11-gradle-lib-clone-gitlab-edp-vers   | Clone            | java11-gitlab         | gitlabRepositoryLogin | gitlabRepositoryPassword | Java            | java11          | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-gradle-lib-clone-gitlab-edp-vers   | MASTER-Code-review-java11-gradle-lib-clone-gitlab-edp-vers   |
      | java11-maven-lib-clone-gitlab-edp-vers    | Clone            | java11-maven-gitlab   | gitlabRepositoryLogin | gitlabRepositoryPassword | Java            | java11          | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-maven-lib-clone-gitlab-edp-vers    | MASTER-Code-review-java11-maven-lib-clone-gitlab-edp-vers    |
      | dotnet-3-1-lib-clone-gitlab-edp-vers      | Clone            | dotnet31-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | DotNet          | dotnet-3.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-3-1-lib-clone-gitlab-edp-vers      | MASTER-Code-review-dotnet-3-1-lib-clone-gitlab-edp-vers      |
      | dotnet-2-1-lib-clone-gitlab-edp-vers      | Clone            | dotnet21-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | DotNet          | dotnet-2.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-2-1-lib-clone-gitlab-edp-vers      | MASTER-Code-review-dotnet-2-1-lib-clone-gitlab-edp-vers      |
      | python-3-8-lib-clone-gitlab-edp-vers      | Clone            | python38-gitlab       | gitlabRepositoryLogin | gitlabRepositoryPassword | Python          | python-3.8      | Python    | master     | master            | edp              | 1.2.3        | MASTER-Build-python-3-8-lib-clone-gitlab-edp-vers      | MASTER-Code-review-python-3-8-lib-clone-gitlab-edp-vers      |
      | javascript-lib-clone-gitlab-edp-vers      | Clone            | javascript-gitlab     | gitlabRepositoryLogin | gitlabRepositoryPassword | JavaScript      | react           | NPM       | master     | master            | edp              | 1.2.3        | MASTER-Build-javascript-lib-clone-gitlab-edp-vers      | MASTER-Code-review-javascript-lib-clone-gitlab-edp-vers      |
      | groovy-pipeline-lib-clone-gitlab-edp-vers | Clone            | groovyCodenarc-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Groovy-pipeline | Groovy          | Codenarc  | master     | master            | edp              | 1.2.3        | MASTER-Build-groovy-pipeline-lib-clone-gitlab-edp-vers | MASTER-Code-review-groovy-pipeline-lib-clone-gitlab-edp-vers |
      | rego-opa-lib-clone-gitlab-edp-vers        | Clone            | regoOpa-gitlab        | gitlabRepositoryLogin | gitlabRepositoryPassword | Rego            | opa             | OPA       | master     | master            | edp              | 1.2.3        | MASTER-Build-rego-opa-lib-clone-gitlab-edp-vers        | MASTER-Code-review-rego-opa-lib-clone-gitlab-edp-vers        |


  Scenario Outline: Create Terraform library using Clone strategy from private repository (Gitlab)
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Libraries tab
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
    And User switch to first tab
#    And User clicks on Libraries tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                     | codebaseStrategy | repository       | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                         | codeReviewJob                                          |
      | terraform-lib-clone-gitlab-edp-vers | Clone            | terraform-gitlab | gitlabRepositoryLogin | gitlabRepositoryPassword | Terraform    | terraform       | Terraform | master     | master            | edp              | 1.2.3        | MASTER-Build-terraform-lib-clone-gitlab-edp-vers | MASTER-Code-review-terraform-lib-clone-gitlab-edp-vers |


  Scenario Outline: Create library using Clone strategy from public repository (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Libraries tab
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
    And User checks success status for "<buildJob>" build job
    And User switch to first tab
#    And User clicks on Libraries tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                           | codebaseStrategy | repository            | repositoryLogin       | repositoryPassword       | codeLanguage    | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                               | codeReviewJob                                                |
      | java8-maven-lib-clone-github-edp-vers     | Clone            | java8-mavem-github    | githubRepositoryLogin | githubRepositoryPassword | Java            | java8           | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-maven-lib-clone-github-edp-vers     | MASTER-Code-review-java8-maven-lib-clone-github-edp-vers     |
      | java8-gradle-lib-clone-github-edp-vers    | Clone            | java8-gradle-github   | githubRepositoryLogin | githubRepositoryPassword | Java            | java8           | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java8-gradle-lib-clone-github-edp-vers    | MASTER-Code-review-java8-gradle-lib-clone-github-edp-vers    |
      | java11-maven-lib-clone-github-edp-vers    | Clone            | java11-mavem-github   | githubRepositoryLogin | githubRepositoryPassword | Java            | java11          | Maven     | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-maven-lib-clone-github-edp-vers    | MASTER-Code-review-java11-maven-lib-clone-github-edp-vers    |
      | java11-gradle-lib-clone-github-edp-vers   | Clone            | java11-gradle-github  | githubRepositoryLogin | githubRepositoryPassword | Java            | java11          | Gradle    | master     | master            | edp              | 1.2.3        | MASTER-Build-java11-gradle-lib-clone-github-edp-vers   | MASTER-Code-review-java11-gradle-lib-clone-github-edp-vers   |
      | python-3-8-lib-clone-github-edp-vers      | Clone            | python38-github       | githubRepositoryLogin | githubRepositoryPassword | Python          | python-3.8      | Python    | master     | master            | edp              | 1.2.3        | MASTER-Build-python-3-8-lib-clone-github-edp-vers      | MASTER-Code-review-python-3-8-lib-clone-github-edp-vers      |
      | javascript-lib-clone-github-edp-vers      | Clone            | javascript-github     | githubRepositoryLogin | githubRepositoryPassword | JavaScript      | react           | NPM       | master     | master            | edp              | 1.2.3        | MASTER-Build-javascript-lib-clone-github-edp-vers      | MASTER-Code-review-javascript-lib-clone-github-edp-vers      |
      | dotnet-3-1-lib-clone-github-edp-vers      | Clone            | dotnet31-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet          | dotnet-3.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-3-1-lib-clone-github-edp-vers      | MASTER-Code-review-dotnet-3-1-lib-clone-github-edp-vers      |
      | dotnet-2-1-lib-clone-github-edp-vers      | Clone            | dotnet21-github       | githubRepositoryLogin | githubRepositoryPassword | DotNet          | dotnet-2.1      | dotnet    | master     | master            | edp              | 1.2.3        | MASTER-Build-dotnet-2-1-lib-clone-github-edp-vers      | MASTER-Code-review-dotnet-2-1-lib-clone-github-edp-vers      |
      | groovy-pipeline-lib-clone-github-edp-vers | Clone            | groovyCodenarc-github | githubRepositoryLogin | githubRepositoryPassword | Groovy-pipeline | Groovy          | Codenarc  | master     | master            | edp              | 1.2.3        | MASTER-Build-groovy-pipeline-lib-clone-github-edp-vers | MASTER-Code-review-groovy-pipeline-lib-clone-github-edp-vers |
      | rego-opa-lib-clone-github-edp-vers        | Clone            | regoOpa-github        | githubRepositoryLogin | githubRepositoryPassword | Rego            | opa             | OPA       | master     | master            | edp              | 1.2.3        | MASTER-Build-rego-opa-lib-clone-github-edp-vers        | MASTER-Code-review-rego-opa-lib-clone-github-edp-vers        |


  Scenario Outline: Create Tettaform library using Clone strategy from public repository (Github)
    Given User opens EDP Admin Console
    When User logins with default credentials
    When User clicks on Libraries tab
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
    And User switch to first tab
#    And User clicks on Libraries tab
#    And User clicks 'delete' button for "<applicationName>" codebase
#    And User enters "<applicationName>" in confirmation name field
#    And User clicks 'Delete confirmation' button
    And User deletes "<applicationName>" codebase

    Examples:
      | applicationName                     | codebaseStrategy | repository       | repositoryLogin       | repositoryPassword       | codeLanguage | languageVersion | buildTool | branchName | defaultBranchName | versioningType   | startVersion | buildJob                                         | codeReviewJob                                          |
      | terraform-lib-clone-github-edp-vers | Clone            | terraform-github | githubRepositoryLogin | githubRepositoryPassword | Terraform    | terraform       | Terraform | master     | master            | edp              | 1.2.3        | MASTER-Build-terraform-lib-clone-github-edp-vers | MASTER-Code-review-terraform-lib-clone-github-edp-vers |
