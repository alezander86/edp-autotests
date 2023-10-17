Feature: Tekton review and build pipeline with gerrit

  Scenario Outline: Check pipelines for <codeLanguage> added with default version using create strategy
    Given User creates default codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    When User creates change in "<defaultBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    @TektonGerrit @TektonCreate @TektonSmoke
    Examples:
      | applicationName                 | codeLanguage             | defaultBranchName |
      | java11-mvn-create-def-build     | java11_maven_application | master            |

    @TektonGerrit @TektonCreate
    Examples:
      | applicationName                 | codeLanguage             | defaultBranchName |
      | dotnet-6-0-lib-create-def-build | dotnet_6_0_library       | master            |
      | python-3-8-create-def-build     | python_3_8_application   | master            |
      | go-sdk-create-def-build         | operator_sdk_application | master            |
      | vue-lib-create-def-build        | vue_library              | master            |

  Scenario Outline: Check pipelines for new branch of <codeLanguage> added with edp version using create strategy
    Given User creates edp codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    @TektonGerrit @TektonNewBranchEdp @TektonNewBranchEdpSmoke @TektonSmoke
    Examples:
      | applicationName        | codeLanguage      | newBranchName | startFrom      | newBranchVersion   |
      | js-create-br-edp-build | react_application | new           | 1.2.3-snapshot | 1.2.3-new-snapshot |

  Scenario Outline: Check pipelines for release branch of <codeLanguage> added with edp version using create strategy
    Given User creates edp codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new release branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    @TektonGerrit @TektonGerritRelease @TektonReleaseSmoke @TektonSmoke
    Examples:
      | applicationName                     | codeLanguage           | newBranchName | startFrom      | newBranchVersion |
      | python-3-8-release-create-build     | python_3_8_application | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-6-0-lib-release-create-build | dotnet_6_0_library     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |

    @TektonGerrit @TektonGerritRelease
    Examples:
      | applicationName                     | codeLanguage                 | newBranchName | startFrom      | newBranchVersion |
      | container-lib-release-create-build  | docker_library               | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-3-1-release-create-build     | dotnet_3_1_application       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-3-1-lib-release-create-build | dotnet_3_1_library           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-6-0-release-create-build     | dotnet_6_0_application       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-beego-release-create-build       | beego_application            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-sdk-release-create-build         | operator_sdk_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-gin-release-create-build         | go_go_gin_application        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | groovy-lib-release-create-build     | codenarc_library             | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | pipeline-lib-release-create-build   | pipeline_library             | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-mvn-release-create-build      | java8_maven_application      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-grd-release-create-build      | java8_gradle_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-mvn-lib-release-create-build  | java8_maven_library          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-grd-lib-release-create-build  | java8_gradle_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-mvn-release-create-build     | java11_maven_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-mvn-lib-release-create-build | java11_maven_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-grd-release-create-build     | java11_gradle_application    | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-grd-lib-release-create-build | java11_gradle_library        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-mvn-release-create-build     | java17_maven_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-grd-release-create-build     | java17_gradle_application    | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-mvn-lib-release-create-build | java17_maven_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-grd-lib-release-create-build | java17_gradle_library        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | js-release-create-build             | react_application            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | js-lib-release-create-build         | react_library                | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | angular-release-create-build        | angular_application          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | angular-lib-release-create-build    | angular_library              | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | express-release-create-build        | express_application          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | express-lib-release-create-build    | express_library              | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | vue-release-create-build            | vue_application              | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | vue-lib-release-create-build        | vue_library                  | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | next-release-create-build           | next_application             | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | antora-release-create-build         | antora_application           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-3-8-lib-release-create-build | python_3_8_library           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-fastapi-release-create-build | python_fastapi_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-flask-release-create-build   | python_flask_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | rego-opa-lib-release-create-build   | opa_library                  | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | terraform-lib-release-create-build  | hcl_terraform_library        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | helm-release-create-build           | helm_application             | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | charts-lib-release-create-build     | charts_library               | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | terraform-inf-release-create-build  | hcl_terraform_infrastructure | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |

  Scenario Outline: Check pipelines for <codeLanguage> added with default version using clone strategy
    Given User clones default codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
    And User deletes "<applicationName>" codebase resources
    @TektonGerrit @TektonClone @TektonCloneSmoke
    Examples:
      | applicationName                | codeLanguage            |
      | dotnet-3-1-lib-clone-def-build | dotnet_3_1_library      |
      | java8-mvn-clone-def-build      | java8_maven_application |
      | js-clone-def-build             | react_application       |
      | python-3-8-lib-clone-def-build | python_3_8_library      |

    @TektonGerrit @TektonClone
    Examples:
      | applicationName                    | codeLanguage                 |
      | container-lib-clone-def-build      | docker_library               |
      | dotnet-3-1-clone-def-build         | dotnet_3_1_application       |
      | dotnet-6-0-clone-def-build         | dotnet_6_0_application       |
      | dotnet-6-0-lib-clone-def-build     | dotnet_6_0_library           |
      | go-beego-clone-def-build           | beego_application            |
      | go-operator-sdk-clone-def-build    | operator_sdk_application     |
      | go-gin-clone-def-build             | go_go_gin_application        |
      | groovy-lib-clone-def-build         | codenarc_library             |
      | pipeline-clone-def-build           | pipeline_library             |
      | java8-grd-clone-def-build          | java8_gradle_application     |
      | java8-gr-lib-clone-def-build       | java8_gradle_library         |
      | java8-mvn-lib-clone-def-build      | java8_maven_library          |
      | java11-mvn-clone-def-build         | java11_maven_application     |
      | java11-grd-clone-def-build         | java11_gradle_application    |
      | java11-mvn-lib-clone-def-build     | java11_maven_library         |
      | java11-grd-lib-clone-def-build     | java11_gradle_library        |
      | java17-mvn-clone-def-build         | java17_maven_application     |
      | java17-grd-clone-def-build         | java17_gradle_application    |
      | java17-mvn-lib-clone-def-build     | java17_maven_library         |
      | java17-grd-lib-clone-def-build     | java17_gradle_library        |
      | js-lib-clone-def-build             | react_library                |
      | angular-clone-def-build            | angular_application          |
      | angular-lib-clone-def-build        | angular_library              |
      | express-clone-def-build            | express_application          |
      | express-lib-clone-def-build        | express_library              |
      | vue-clone-def-build                | vue_application              |
      | vue-lib-clone-def-build            | vue_library                  |
      | next-clone-def-build               | next_application             |
      | antora-clone-def-build             | antora_application           |
      | python-3-8-clone-def-build         | python_3_8_application       |
      | python-fastapi-clone-def-build     | python_fastapi_application   |
      | python-flask-clone-def-build       | python_flask_application     |
      | rego-opa-lib-clone-def-build       | opa_library                  |
      | terraform-lib-clone-def-build      | hcl_terraform_library        |
      | helm-clone-def-build               | helm_application             |
      | charts-lib-clone-def-build         | charts_library               |
      | java17-multimodule-clone-def-build | java17_multimodule_tekton    |
      | terraform-inf-clone-def-build      | hcl_terraform_infrastructure |
      | java8-grd-auto-clone-def-build     | java8_gradle_autotest        |
      | java11-mvn-auto-clone-def-build    | java11_maven_autotest        |
      | java17-grd-auto-clone-def-build    | java17_gradle_autotest       |

  Scenario Outline: Check empty project codebase creation for <codeLanguage> added with default version
    Given User creates default codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | isProjectEmpty  | true              |
    And User deletes "<applicationName>" codebase resources
    @TektonGerrit @TektonCreate @TektonEmptyProject
    Examples:
      | applicationName                 | codeLanguage             |
      | dotnet-3-1-lib-create-def-empty | dotnet_3_1_library       |
      | dotnet-3-1-create-def-empty     | dotnet_3_1_application   |
      | java8-mvn-create-def-empty      | java8_maven_application  |
      | java8-grd-create-def-empty      | java8_gradle_application |
      | java8-gr-lib-create-def-empty   | java8_gradle_library     |
      | java8-mvn-lib-create-def-empty  | java8_maven_library      |
      | python-3-8-lib-create-def-empty | python_3_8_library       |
      | python-3-8-create-def-empty     | python_3_8_application   |
      | go-beego-create-def-empty       | beego_application        |
      | container-lib-create-def-empty  | docker_library           |
      | terraform-lib-create-def-empty  | hcl_terraform_library    |
      | helm-create-def-empty           | helm_application         |
      | js-create-def-empty             | react_application        |
      | js-lib-create-def-empty         | react_library            |

  Scenario Outline: Check pipelines for <codeLanguage> added with edp version using clone strategy
    Given User clones edp codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
    When User creates change in "<defaultBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    @TektonGerrit
    Examples:
      | applicationName                 | codeLanguage           | defaultBranchName |
      | java8-mvn-auto-clone-edp-build  | java8_maven_autotest   | master            |
      | java11-grd-auto-clone-edp-build | java11_gradle_autotest | master            |
#      | java17-mvn-auto-clone-edp-build | java17_maven_autotest  | master            | uncomment after EPMDEDP-12149 will be done

  Scenario Outline: Check pipelines for release branch of <codeLanguage> added with edp version using create strategy
    Given User creates edp codebase on gerrit
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | <startFrom>       |
    When User creates new release branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | <newBranchVersion> |
    And User creates change in "<newBranchName>" branch in "<applicationName>" gerrit project
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User makes merge request in gerrit
    Then User checks build pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    @TektonPerformance
    Examples:
      | applicationName                     | codeLanguage               | newBranchName | startFrom      | newBranchVersion |
      | dotnet-3-1-lib-release-create-perf1 | dotnet_3_1_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-3-8-release-create-perf1     | python_3_8_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | container-lib-release-create-perf1  | docker_library             | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-3-1-release-create-perf1     | dotnet_3_1_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-6-0-release-create-perf1     | dotnet_6_0_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-6-0-lib-release-create-perf1 | dotnet_6_0_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-beego-release-create-perf1       | beego_application          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-sdk-release-create-perf1         | operator_sdk_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | groovy-lib-release-create-perf1     | codenarc_library           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | pipeline-lib-release-create-perf1   | pipeline_library           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-mvn-release-create-perf1      | java8_maven_application    | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-grd-release-create-perf1      | java8_gradle_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-mvn-lib-release-create-perf1  | java8_maven_library        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-grd-lib-release-create-perf1  | java8_gradle_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-mvn-release-create-perf1     | java11_maven_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-mvn-lib-release-create-perf1 | java11_maven_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-grd-release-create-perf1     | java11_gradle_application  | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-grd-lib-release-create-perf1 | java11_gradle_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-mvn-release-create-perf1     | java17_maven_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-grd-release-create-perf1     | java17_gradle_application  | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-mvn-lib-release-create-perf1 | java17_maven_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-grd-lib-release-create-perf1 | java17_gradle_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | js-release-create-perf1             | react_application          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | js-lib-release-create-perf1         | react_library              | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | angular-release-create-perf1        | angular_application        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | angular-lib-release-create-perf1    | angular_library            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | express-release-create-perf1        | express_application        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | express-lib-release-create-perf1    | express_library            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | vue-release-create-perf1            | vue_application            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | vue-lib-release-create-perf1        | vue_library                | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-3-8-lib-release-create-perf1 | python_3_8_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-fastapi-release-create-perf1 | python_fastapi_application | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-flask-release-create-perf1   | python_flask_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | rego-opa-lib-release-create-perf1   | opa_library                | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | terraform-lib-release-create-perf1  | hcl_terraform_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | helm-release-create-perf1           | helm_application           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-3-1-lib-release-create-perf2 | dotnet_3_1_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-3-8-release-create-perf2     | python_3_8_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | container-lib-release-create-perf2  | docker_library             | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-3-1-release-create-perf2     | dotnet_3_1_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-6-0-release-create-perf2     | dotnet_6_0_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-6-0-lib-release-create-perf2 | dotnet_6_0_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-beego-release-create-perf2       | beego_application          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-sdk-release-create-perf2         | operator_sdk_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | groovy-lib-release-create-perf2     | codenarc_library           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | pipeline-lib-release-create-perf2   | pipeline_library           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-mvn-release-create-perf2      | java8_maven_application    | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-grd-release-create-perf2      | java8_gradle_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-mvn-lib-release-create-perf2  | java8_maven_library        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-grd-lib-release-create-perf2  | java8_gradle_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-mvn-release-create-perf2     | java11_maven_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-mvn-lib-release-create-perf2 | java11_maven_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-grd-release-create-perf2     | java11_gradle_application  | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-grd-lib-release-create-perf2 | java11_gradle_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-mvn-release-create-perf2     | java17_maven_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-grd-release-create-perf2     | java17_gradle_application  | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-mvn-lib-release-create-perf2 | java17_maven_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-grd-lib-release-create-perf2 | java17_gradle_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | js-release-create-perf2             | react_application          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | js-lib-release-create-perf2         | react_library              | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | angular-release-create-perf2        | angular_application        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | angular-lib-release-create-perf2    | angular_library            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | express-release-create-perf2        | express_application        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | express-lib-release-create-perf2    | express_library            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | vue-release-create-perf2            | vue_application            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | vue-lib-release-create-perf2        | vue_library                | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-3-8-lib-release-create-perf2 | python_3_8_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-fastapi-release-create-perf2 | python_fastapi_application | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-flask-release-create-perf2   | python_flask_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | rego-opa-lib-release-create-perf2   | opa_library                | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | terraform-lib-release-create-perf2  | hcl_terraform_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | helm-release-create-perf2           | helm_application           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-3-1-lib-release-create-perf3 | dotnet_3_1_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-3-8-release-create-perf3     | python_3_8_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | container-lib-release-create-perf3  | docker_library             | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-3-1-release-create-perf3     | dotnet_3_1_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-6-0-release-create-perf3     | dotnet_6_0_application     | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | dotnet-6-0-lib-release-create-perf3 | dotnet_6_0_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-beego-release-create-perf3       | beego_application          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | go-sdk-release-create-perf3         | operator_sdk_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | groovy-lib-release-create-perf3     | codenarc_library           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | pipeline-lib-release-create-perf3   | pipeline_library           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-mvn-release-create-perf3      | java8_maven_application    | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-grd-release-create-perf3      | java8_gradle_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-mvn-lib-release-create-perf3  | java8_maven_library        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java8-grd-lib-release-create-perf3  | java8_gradle_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-mvn-release-create-perf3     | java11_maven_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-mvn-lib-release-create-perf3 | java11_maven_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-grd-release-create-perf3     | java11_gradle_application  | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java11-grd-lib-release-create-perf3 | java11_gradle_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-mvn-release-create-perf3     | java17_maven_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-grd-release-create-perf3     | java17_gradle_application  | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-mvn-lib-release-create-perf3 | java17_maven_library       | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | java17-grd-lib-release-create-perf3 | java17_gradle_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | js-release-create-perf3             | react_application          | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | js-lib-release-create-perf3         | react_library              | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | angular-release-create-perf3        | angular_application        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | angular-lib-release-create-perf3    | angular_library            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | express-release-create-perf3        | express_application        | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | express-lib-release-create-perf3    | express_library            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | vue-release-create-perf3            | vue_application            | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | vue-lib-release-create-perf3        | vue_library                | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-3-8-lib-release-create-perf3 | python_3_8_library         | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-fastapi-release-create-perf3 | python_fastapi_application | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | python-flask-release-create-perf3   | python_flask_application   | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | rego-opa-lib-release-create-perf3   | opa_library                | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | terraform-lib-release-create-perf3  | hcl_terraform_library      | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
      | helm-release-create-perf3           | helm_application           | release-1.2   | 1.2.3-SNAPSHOT | 1.2.3-RC         |
