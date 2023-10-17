Feature: Tekton review and build pipeline with github

  Scenario Outline: Check pipelines for <codeLanguage> added with default version using github import strategy
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    And User imports default codebase from github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    When User creates pull request to "<defaultBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @TektonGithub @TektonGithubSmoke
    Examples:
      | applicationName                    | codeLanguage             | defaultBranchName |
      | java8-mvn-import-def-github-build  | java8_maven_application  | master            |
      | java11-mvn-import-def-github-build | java11_maven_application | master            |
      | js-import-def-github-build         | react_application        | master            |
      | python-3-8-import-def-github-build | python_3_8_application   | master            |

    @TektonGithub
    Examples:
      | applicationName                         | codeLanguage                 | defaultBranchName |
      | container-lib-import-def-github-build   | docker_library               | master            |
      | dotnet-3-1-import-def-github-build      | dotnet_3_1_application       | master            |
      | dotnet-3-1-lib-import-def-github-build  | dotnet_3_1_library           | master            |
      | dotnet-6-0-import-def-github-build      | dotnet_6_0_application       | master            |
      | dotnet-6-0-lib-import-def-github-build  | dotnet_6_0_library           | master            |
      | go-beego-import-def-github-build        | beego_application            | master            |
      | go-operator-sdk-import-def-github-build | operator_sdk_application     | master            |
      | go-gin-import-def-github-build          | go_go_gin_application        | master            |
      | groovy-lib-import-def-github-build      | codenarc_library             | master            |
      | pipeline-import-def-github-build        | pipeline_library             | master            |
      | java8-grd-import-def-github-build       | java8_gradle_application     | master            |
      | java8-mvn-lib-import-def-github-build   | java8_maven_library          | master            |
      | java8-grd-lib-import-def-github-build   | java8_gradle_library         | master            |
      | java11-grd-import-def-github-build      | java11_gradle_application    | master            |
      | java11-mvn-lib-import-def-github-build  | java11_maven_library         | master            |
      | java11-grd-lib-import-def-github-build  | java11_gradle_library        | master            |
      | java17-mvn-import-def-github-build      | java17_maven_application     | master            |
      | java17-grd-import-def-github-build      | java17_gradle_application    | master            |
      | java17-mvn-lib-import-def-github-build  | java17_maven_library         | master            |
      | java17-grd-lib-import-def-github-build  | java17_gradle_library        | master            |
      | js-lib-import-def-github-build          | react_library                | master            |
      | angular-import-def-github-build         | angular_application          | master            |
      | angular-lib-import-def-github-build     | angular_library              | master            |
      | express-import-def-github-build         | express_application          | master            |
      | express-lib-import-def-github-build     | express_library              | master            |
      | vue-import-def-github-build             | vue_application              | master            |
      | vue-lib-import-def-github-build         | vue_library                  | master            |
      | next-import-def-github-build            | next_application             | master            |
      | antora-import-def-github-build          | antora_application           | main              |
      | python-3-8-lib-import-def-github-build  | python_3_8_library           | master            |
      | python-fastapi-import-def-github-build  | python_fastapi_application   | master            |
      | python-flask-import-def-github-build    | python_flask_application     | master            |
      | rego-opa-lib-import-def-github-build    | opa_library                  | master            |
      | terraform-lib-import-def-github-build   | hcl_terraform_library        | master            |
      | helm-import-def-github-build            | helm_application             | master            |
      | charts-lib-import-def-github-build      | charts_library               | master            |
      | terraform-inf-create-def-github-build   | hcl_terraform_infrastructure | master            |
      | java8-grd-auto-import-def-github-build  | java8_gradle_autotest        | master            |
      | java11-mvn-auto-import-def-github-build | java11_maven_autotest        | master            |
      | java17-grd-auto-import-def-github-build | java17_gradle_autotest       | master            |

  Scenario Outline: Check pipelines for release branch of <codeLanguage> added with edp version using github create strategy
    Given User creates edp codebase on github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | new                |
      | newBranchVersion | 1.2.3-NEW-SNAPSHOT |
    When User creates pull request to "new" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "new" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "new" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @TektonGithub @TektonGithubShortRegression
    Examples:
      | applicationName                         | codeLanguage                 |
      | python-fastapi-create-edp-github-build  | python_fastapi_application   |
      | terraform-inf-create-edp-github-build   | hcl_terraform_infrastructure |
      | go-beego-create-edp-github-build        | beego_application            |
      | vue-lib-create-edp-github-build         | vue_library                  |
      | rego-opa-lib-create-edp-github-build    | opa_library                  |

    @TektonGithub @TektonGithubCreate
    Examples:
      | applicationName                         | codeLanguage                 |
      | java8-mvn-create-edp-github-build       | java8_maven_application      |
      | java11-mvn-create-edp-github-build      | java11_maven_application     |
      | js-create-edp-github-build              | react_application            |
      | python-3-8-create-edp-github-build      | python_3_8_application       |
      | container-lib-create-edp-github-build   | docker_library               |
      | dotnet-3-1-create-edp-github-build      | dotnet_3_1_application       |
      | dotnet-3-1-lib-create-edp-github-build  | dotnet_3_1_library           |
      | dotnet-6-0-create-edp-github-build      | dotnet_6_0_application       |
      | dotnet-6-0-lib-create-edp-github-build  | dotnet_6_0_library           |
      | go-operator-sdk-create-edp-github-build | operator_sdk_application     |
      | go-gin-create-edp-github-build          | go_go_gin_application        |
      | groovy-lib-create-edp-github-build      | codenarc_library             |
      | pipeline-create-edp-github-build        | pipeline_library             |
      | java8-grd-create-edp-github-build       | java8_gradle_application     |
      | java8-mvn-lib-create-edp-github-build   | java8_maven_library          |
      | java8-grd-lib-create-edp-github-build   | java8_gradle_library         |
      | java11-grd-create-edp-github-build      | java11_gradle_application    |
      | java11-mvn-lib-create-edp-github-build  | java11_maven_library         |
      | java11-grd-lib-create-edp-github-build  | java11_gradle_library        |
      | java17-mvn-create-edp-github-build      | java17_maven_application     |
      | java17-grd-create-edp-github-build      | java17_gradle_application    |
      | java17-mvn-lib-create-edp-github-build  | java17_maven_library         |
      | java17-grd-lib-create-edp-github-build  | java17_gradle_library        |
      | js-lib-create-edp-github-build          | react_library                |
      | angular-create-edp-github-build         | angular_application          |
      | angular-lib-create-edp-github-build     | angular_library              |
      | express-create-edp-github-build         | express_application          |
      | express-lib-create-edp-github-build     | express_library              |
      | vue-create-edp-github-build             | vue_application              |
      | next-create-edp-github-build            | next_application             |
      | antora-create-edp-github-build          | antora_application           |
      | python-3-8-lib-create-edp-github-build  | python_3_8_library           |
      | python-flask-create-edp-github-build    | python_flask_application     |
      | terraform-lib-create-edp-github-build   | hcl_terraform_library        |
      | helm-create-edp-github-build            | helm_application             |
      | charts-lib-create-edp-github-build      | charts_library               |


  Scenario Outline: Check pipelines for <codeLanguage> added with edp version using github import strategy
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    And User imports edp codebase from github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates pull request to "<defaultBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @TektonGithub @TektonGithubShortRegression
    Examples:
      | applicationName                  | codeLanguage      | defaultBranchName | startFrom      |
      | go-beego-import-edp-github-build | beego_application | master            | 1.2.3-SNAPSHOT |


  Scenario Outline: Check pipelines for new branch of <codeLanguage> added with default version using github import strategy
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    And User imports default codebase from github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    When User creates new branch
      | applicationName | <applicationName> |
      | branchName      | <newBranchName>   |
    When User creates pull request to "<newBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @TektonGithub @TektonGithubShortRegression
    Examples:
      | applicationName                           | codeLanguage       | newBranchName |
      | dotnet-3-1-lib-br-import-def-github-build | dotnet_3_1_library | new           |


  Scenario Outline: Check pipelines for release branch of <codeLanguage> added with edp version using github import strategy
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    And User imports edp codebase from github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new release branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    When User creates pull request to "<newBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @TektonGithub @TektonGithubShortRegression
    Examples:
      | applicationName                        | codeLanguage             | newBranchName | startFrom      | newBranchVersion |
      | java11-mvn-release-import-github-build | java11_maven_application | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |


  Scenario Outline: Check pipelines for <codeLanguage> added with edp version using clone strategy
    Given User clones edp codebase on github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | new                |
      | newBranchVersion | 1.2.3-NEW-SNAPSHOT |
    When User creates pull request to "new" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "new" branch in "<applicationName>" codebase
    And User merges pull request in github "<applicationName>" project
    Then User checks build pipeline status for "new" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @TektonGithub @TektonGithubShortRegression
    Examples:
      | applicationName                        | codeLanguage                 |
      | dotnet-6-0-clone-github-edp-build      | dotnet_6_0_application       |
      | java8-gr-lib-clone-github-edp-build    | java8_gradle_library         |
      | express-clone-github-edp-build         | express_application          |
      | helm-clone-github-edp-build            | helm_application             |
      | charts-lib-clone-github-edp-build      | charts_library               |

    @TektonGithub @TektonGithubClone
    Examples:
      | applicationName                        | codeLanguage                 |
      | dotnet-3-1-lib-clone-github-edp-build  | dotnet_3_1_library           |
      | java8-mvn-clone-github-edp-build       | java8_maven_application      |
      | js-clone-github-edp-build              | react_application            |
      | python-3-8-lib-clone-github-edp-build  | python_3_8_library           |
      | container-lib-clone-github-edp-build   | docker_library               |
      | dotnet-3-1-clone-github-edp-build      | dotnet_3_1_application       |
      | dotnet-6-0-lib-clone-github-edp-build  | dotnet_6_0_library           |
      | go-beego-clone-github-edp-build        | beego_application            |
      | go-operator-sdk-clone-github-edp-build | operator_sdk_application     |
      | go-gin-clone-github-edp-build          | go_go_gin_application        |
      | groovy-lib-clone-github-edp-build      | codenarc_library             |
      | pipeline-clone-github-edp-build        | pipeline_library             |
      | java8-grd-clone-github-edp-build       | java8_gradle_application     |
      | java8-mvn-lib-clone-github-edp-build   | java8_maven_library          |
      | java11-mvn-clone-github-edp-build      | java11_maven_application     |
      | java11-grd-clone-github-edp-build      | java11_gradle_application    |
      | java11-mvn-lib-clone-github-edp-build  | java11_maven_library         |
      | java11-grd-lib-clone-github-edp-build  | java11_gradle_library        |
      | java17-mvn-clone-github-edp-build      | java17_maven_application     |
      | java17-grd-clone-github-edp-build      | java17_gradle_application    |
      | java17-mvn-lib-clone-github-edp-build  | java17_maven_library         |
      | java17-grd-lib-clone-github-edp-build  | java17_gradle_library        |
      | js-lib-clone-github-edp-build          | react_library                |
      | angular-clone-github-edp-build         | angular_application          |
      | angular-lib-clone-github-edp-build     | angular_library              |
      | express-lib-clone-github-edp-build     | express_library              |
      | vue-clone-github-edp-build             | vue_application              |
      | vue-lib-clone-github-edp-build         | vue_library                  |
      | next-clone-github-edp-build            | next_application             |
      | antora-clone-github-edp-build30        | antora_application           |
      | python-3-8-clone-github-edp-build      | python_3_8_application       |
      | python-fastapi-clone-github-edp-build  | python_fastapi_application   |
      | python-flask-clone-github-edp-build    | python_flask_application     |
      | rego-opa-lib-clone-github-edp-build    | opa_library                  |
      | terraform-lib-clone-github-edp-build   | hcl_terraform_library        |
      | java17-multimodule-clone-edp-build     | java17_multimodule_tekton    |
      | terraform-inf-clone-github-edp-build   | hcl_terraform_infrastructure |
      | java8-mvn-auto-clone-github-edp-build  | java8_maven_autotest         |
      | java11-grd-auto-clone-github-edp-build | java11_gradle_autotest       |
      | java17-mvn-auto-clone-github-edp-build | java17_maven_autotest        |

  Scenario Outline: Check empty project codebase creation for <codeLanguage> added with edp version
    Given User creates edp codebase on github
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
      | isProjectEmpty  | true              |
    And User deletes "<applicationName>" codebase resources
    @TektonGithub @TektonCreate @TektonEmptyProject
    Examples:
      | applicationName                 | codeLanguage               |
      | go-gin-create-edp-empty         | go_go_gin_application      |
      | groovy-lib-create-edp-empty     | codenarc_library           |
      | pipeline-create-edp-empty       | pipeline_library           |
      | java17-mvn-create-edp-empty     | java17_maven_application   |
      | java17-grd-create-edp-empty     | java17_gradle_application  |
      | java17-mvn-lib-create-edp-empty | java17_maven_library       |
      | java17-grd-lib-create-edp-empty | java17_gradle_library      |
      | vue-create-edp-empty            | vue_application            |
      | vue-lib-create-edp-empty        | vue_library                |
      | next-create-edp-empty           | next_application           |
      | python-fastapi-create-edp-empty | python_fastapi_application |
      | python-flask-create-edp-empty   | python_flask_application   |
      | rego-opa-lib-create-edp-empty   | opa_library                |
