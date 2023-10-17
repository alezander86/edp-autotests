Feature: Tekton review and build pipeline with gitlab

  Scenario Outline: Check pipelines for <codeLanguage> added with default version using gitlab import strategy
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User imports default codebase from gitlab
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    When User creates pull request from "<defaultBranchName>" ref branch to "<defaultBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    @TektonGitlab @TektonGitlabSmoke
    Examples:
      | applicationName                    | codeLanguage             | defaultBranchName |
      | java8-mvn-import-def-gitlab-build  | java8_maven_application  | master            |
      | java11-mvn-import-def-gitlab-build | java11_maven_application | master            |
      | js-import-def-gitlab-build         | react_application        | master            |
      | python-3-8-import-def-gitlab-build | python_3_8_application   | master            |

    @TektonGitlab
    Examples:
      | applicationName                         | codeLanguage                 | defaultBranchName |
      | container-lib-import-def-gitlab-build   | docker_library               | master            |
      | dotnet-3-1-import-def-gitlab-build      | dotnet_3_1_application       | master            |
      | dotnet-3-1-lib-import-def-gitlab-build  | dotnet_3_1_library           | master            |
      | dotnet-6-0-import-def-gitlab-build      | dotnet_6_0_application       | master            |
      | dotnet-6-0-lib-import-def-gitlab-build  | dotnet_6_0_library           | master            |
      | go-beego-import-def-gitlab-build        | beego_application            | master            |
      | go-operator-sdk-import-def-gitlab-build | operator_sdk_application     | master            |
      | go-gin-import-def-gitlab-build          | go_go_gin_application        | master            |
      | groovy-lib-import-def-gitlab-build      | codenarc_library             | master            |
      | pipeline-lib-import-def-gitlab-build    | pipeline_library             | master            |
      | java8-grd-import-def-gitlab-build       | java8_gradle_application     | master            |
      | java8-mvn-lib-import-def-gitlab-build   | java8_maven_library          | master            |
      | java8-grd-lib-import-def-gitlab-build   | java8_gradle_library         | master            |
      | java11-grd-import-def-gitlab-build      | java11_gradle_application    | master            |
      | java11-mvn-lib-import-def-gitlab-build  | java11_maven_library         | master            |
      | java11-grd-lib-import-def-gitlab-build  | java11_gradle_library        | master            |
      | java17-mvn-import-def-gitlab-build      | java17_maven_application     | master            |
      | java17-grd-import-def-gitlab-build      | java17_gradle_application    | master            |
      | java17-mvn-lib-import-def-gitlab-build  | java17_maven_library         | master            |
      | java17-grd-lib-import-def-gitlab-build  | java17_gradle_library        | master            |
      | js-lib-import-def-gitlab-build          | react_library                | master            |
      | angular-import-def-gitlab-build         | angular_application          | master            |
      | angular-lib-import-def-gitlab-build     | angular_library              | master            |
      | express-import-def-gitlab-build         | express_application          | master            |
      | express-lib-import-def-gitlab-build     | express_library              | master            |
      | vue-import-def-gitlab-build             | vue_application              | master            |
      | vue-lib-import-def-gitlab-build         | vue_library                  | master            |
      | next-import-def-gitlab-build            | next_application             | master            |
      | antora-import-def-gitlab-build          | antora_application           | main              |
      | python-3-8-lib-import-def-gitlab-build  | python_3_8_library           | master            |
      | python-fastapi-import-def-gitlab-build  | python_fastapi_application   | master            |
      | python-flask-import-def-gitlab-build    | python_flask_application     | master            |
      | rego-opa-lib-import-def-gitlab-build    | opa_library                  | master            |
      | terraform-lib-import-def-gitlab-build   | hcl_terraform_library        | master            |
      | helm-import-def-gitlab-build            | helm_application             | master            |
      | charts-lib-import-def-gitlab-build      | charts_library               | master            |
      | terraform-inf-import-def-gitlab-build   | hcl_terraform_infrastructure | master            |
      | java8-grd-auto-import-def-gitlab-build  | java8_gradle_autotest        | master            |
      | java11-mvn-auto-import-def-gitlab-build | java11_maven_autotest        | master            |
      | java17-grd-auto-import-def-gitlab-build | java17_gradle_autotest       | master            |

  Scenario Outline: Check pipelines for release branch of <codeLanguage> added with edp version using gitlab create strategy
    Given User creates edp codebase on gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | new                |
      | newBranchVersion | 1.2.3-NEW-SNAPSHOT |
    When User creates new release branch
      | applicationName  | <applicationName> |
      | branchName       | release-1.2       |
      | newBranchVersion | 1.2.3-RC          |
    And User deletes "<applicationName>" codebase resources
    @TektonGitlab @TektonGitlabCreate
    Examples:
      | applicationName                         | codeLanguage                 |
      | java8-mvn-create-edp-gitlab-build       | java8_maven_application      |
      | java11-mvn-create-edp-gitlab-build      | java11_maven_application     |
      | js-create-edp-gitlab-build              | react_application            |
      | python-3-8-create-edp-gitlab-build      | python_3_8_application       |
      | container-lib-create-edp-gitlab-build   | docker_library               |
      | dotnet-3-1-create-edp-gitlab-build      | dotnet_3_1_application       |
      | dotnet-3-1-lib-create-edp-gitlab-build  | dotnet_3_1_library           |
      | dotnet-6-0-create-edp-gitlab-build      | dotnet_6_0_application       |
      | dotnet-6-0-lib-create-edp-gitlab-build  | dotnet_6_0_library           |
      | go-beego-create-edp-gitlab-build        | beego_application            |
      | go-operator-sdk-create-edp-gitlab-build | operator_sdk_application     |
      | go-gin-create-edp-gitlab-build          | go_go_gin_application        |
      | groovy-lib-create-edp-gitlab-build      | codenarc_library             |
      | pipeline-create-edp-gitlab-build        | pipeline_library             |
      | java8-grd-create-edp-gitlab-build       | java8_gradle_application     |
      | java8-mvn-lib-create-edp-gitlab-build   | java8_maven_library          |
      | java8-grd-lib-create-edp-gitlab-build   | java8_gradle_library         |
      | java11-grd-create-edp-gitlab-build      | java11_gradle_application    |
      | java11-mvn-lib-create-edp-gitlab-build  | java11_maven_library         |
      | java11-grd-lib-create-edp-gitlab-build  | java11_gradle_library        |
      | java17-mvn-create-edp-gitlab-build      | java17_maven_application     |
      | java17-grd-create-edp-gitlab-build      | java17_gradle_application    |
      | java17-mvn-lib-create-edp-gitlab-build  | java17_maven_library         |
      | java17-grd-lib-create-edp-gitlab-build  | java17_gradle_library        |
      | js-lib-create-edp-gitlab-build          | react_library                |
      | angular-create-edp-gitlab-build         | angular_application          |
      | angular-lib-create-edp-gitlab-build     | angular_library              |
      | express-create-edp-gitlab-build         | express_application          |
      | express-lib-create-edp-gitlab-build     | express_library              |
      | vue-create-edp-gitlab-build             | vue_application              |
      | vue-lib-create-edp-gitlab-build         | vue_library                  |
      | next-create-edp-gitlab-build            | next_application             |
      | antora-create-edp-gitlab-build          | antora_application           |
      | python-3-8-lib-create-edp-gitlab-build  | python_3_8_library           |
      | python-fastapi-create-edp-gitlab-build  | python_fastapi_application   |
      | python-flask-create-edp-gitlab-build    | python_flask_application     |
      | rego-opa-lib-create-edp-gitlab-build    | opa_library                  |
      | terraform-lib-create-edp-gitlab-build   | hcl_terraform_library        |
      | helm-create-edp-gitlab-build            | helm_application             |
      | charts-lib-create-edp-gitlab-build      | charts_library               |
      | terraform-inf-create-edp-gitlab-build   | hcl_terraform_infrastructure |


  Scenario Outline: Check pipelines for <codeLanguage> added with edp version using gitlab import strategy
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User imports edp codebase from gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates pull request from "<defaultBranchName>" ref branch to "<defaultBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    @TektonGitlab
    Examples:
      | applicationName                       | codeLanguage | defaultBranchName | startFrom      |
      | rego-opa-lib-import-edp-gitlab-review | opa_library  | master            | 1.2.3-SNAPSHOT |


  Scenario Outline: Check pipelines for new branch of <codeLanguage> added with default version using gitlab import strategy
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User imports default codebase from gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    When User creates new release branch
      | applicationName | <applicationName> |
      | branchName      | <newBranchName>   |
    When User creates pull request from "<defaultBranchName>" ref branch to "<newBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    @TektonGitlab
    Examples:
      | applicationName                 | codeLanguage       | newBranchName | defaultBranchName |
      | python-3-8-lib-br-def-gitlab-rw | python_3_8_library | new           | master            |


  Scenario Outline: Check pipelines for release branch of <codeLanguage> added with edp version using gitlab import strategy
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User imports edp codebase from gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new release branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    When User creates pull request from "<defaultBranchName>" ref branch to "<newBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in Gitlab
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes gitlab fork project
    @TektonGitlab
    Examples:
      | applicationName                 | codeLanguage      | newBranchName | defaultBranchName | startFrom      | newBranchVersion |
      | js-release-import-gitlab-review | react_application | release-1.2   | master            | 1.2.3-SNAPSHOT | 1.2.3-RC         |

  Scenario Outline: Check pipelines for <codeLanguage> added with edp version using clone strategy
    Given User clones edp codebase on gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | new                |
      | newBranchVersion | 1.2.3-NEW-SNAPSHOT |
    When User creates new release branch
      | applicationName  | <applicationName> |
      | branchName       | release-1.2       |
      | newBranchVersion | 1.2.3-RC          |
    And User deletes "<applicationName>" codebase resources
    @TektonGitlab @TektonGitlabClone
    Examples:
      | applicationName                        | codeLanguage                 |
      | dotnet-3-1-lib-clone-gitlab-edp-build  | dotnet_3_1_library           |
      | java8-mvn-clone-gitlab-edp-build       | java8_maven_application      |
      | js-clone-gitlab-edp-build              | react_application            |
      | python-3-8-lib-clone-gitlab-edp-build  | python_3_8_library           |
      | container-lib-clone-gitlab-edp-build   | docker_library               |
      | dotnet-3-1-clone-gitlab-edp-build      | dotnet_3_1_application       |
      | dotnet-6-0-clone-gitlab-edp-build      | dotnet_6_0_application       |
      | dotnet-6-0-lib-clone-gitlab-edp-build  | dotnet_6_0_library           |
      | go-beego-clone-gitlab-edp-build        | beego_application            |
      | go-operator-sdk-clone-gitlab-edp-build | operator_sdk_application     |
      | go-gin-clone-gitlab-edp-build          | go_go_gin_application        |
      | groovy-lib-clone-gitlab-edp-build      | codenarc_library             |
      | pipeline-clone-gitlab-edp-build        | pipeline_library             |
      | java8-grd-clone-gitlab-edp-build       | java8_gradle_application     |
      | java8-gr-lib-clone-gitlab-edp-build    | java8_gradle_library         |
      | java8-mvn-lib-clone-gitlab-edp-build   | java8_maven_library          |
      | java11-mvn-clone-gitlab-edp-build      | java11_maven_application     |
      | java11-grd-clone-gitlab-edp-build      | java11_gradle_application    |
      | java11-mvn-lib-clone-gitlab-edp-build  | java11_maven_library         |
      | java11-grd-lib-clone-gitlab-edp-build  | java11_gradle_library        |
      | java17-mvn-clone-gitlab-edp-build      | java17_maven_application     |
      | java17-grd-clone-gitlab-edp-build      | java17_gradle_application    |
      | java17-mvn-lib-clone-gitlab-edp-build  | java17_maven_library         |
      | java17-grd-lib-clone-gitlab-edp-build  | java17_gradle_library        |
      | js-lib-clone-gitlab-edp-build          | react_library                |
      | angular-clone-gitlab-edp-build         | angular_application          |
      | angular-lib-clone-gitlab-edp-build     | angular_library              |
      | express-clone-gitlab-edp-build         | express_application          |
      | express-lib-clone-gitlab-edp-build     | express_library              |
      | vue-clone-gitlab-edp-build             | vue_application              |
      | vue-lib-clone-gitlab-edp-build         | vue_library                  |
      | next-clone-gitlab-edp-build            | next_application             |
      | antora-clone-gitlab-edp-build          | antora_application           |
      | python-3-8-clone-gitlab-edp-build      | python_3_8_application       |
      | python-fastapi-clone-gitlab-edp-build  | python_fastapi_application   |
      | python-flask-clone-gitlab-edp-build    | python_flask_application     |
      | rego-opa-lib-clone-gitlab-edp-build    | opa_library                  |
      | terraform-lib-clone-gitlab-edp-build   | hcl_terraform_library        |
      | helm-clone-gitlab-edp-build            | helm_application             |
      | charts-lib-clone-gitlab-edp-build      | charts_library               |
      | java17-multimodule-clone-edp-build     | java17_multimodule_tekton    |
      | terraform-inf-clone-gitlab-edp-build   | hcl_terraform_infrastructure |
      | java8-mvn-auto-clone-gitlab-edp-build  | java8_maven_autotest         |
      | java11-grd-auto-clone-gitlab-edp-build | java11_gradle_autotest       |
      | java17-mvn-auto-clone-gitlab-edp-build | java17_maven_autotest        |

  Scenario Outline: Check empty project codebase creation for <codeLanguage> added with default version
    Given User creates default codebase on gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | isProjectEmpty  | true              |
    And User deletes "<applicationName>" codebase resources
    @TektonGitlab @TektonCreate @TektonEmptyProject
    Examples:
      | applicationName                     | codeLanguage                 |
      | java17-multimodule-create-def-empty | java17_multimodule_tekton    |
      | dotnet-6-0-create-def-empty         | dotnet_6_0_application       |
      | dotnet-6-0-lib-create-def-empty     | dotnet_6_0_library           |
      | java11-mvn-create-def-empty         | java11_maven_application     |
      | java11-grd-create-def-empty         | java11_gradle_application    |
      | java11-mvn-lib-create-def-empty     | java11_maven_library         |
      | java11-grd-lib-create-def-empty     | java11_gradle_library        |
      | go-operator-sdk-create-def-empty    | operator_sdk_application     |
      | angular-create-def-empty            | angular_application          |
      | angular-lib-create-def-empty        | angular_library              |
      | express-create-def-empty            | express_application          |
      | express-lib-create-def-empty        | express_library              |
      | terraform-inf-create-def-empty      | hcl_terraform_infrastructure |
      | charts-lib-create-def-empty         | charts_library               |