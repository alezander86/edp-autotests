Feature: Applications provisioning using Create strategy on github

  Scenario Outline: Create application using Create strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCreateUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage             |
      | java11-maven-create-def-github-ui | master            | java11_maven_application |
      | express-lib-create-def-github-ui  | master            | express_library          |

  Scenario Outline: Create empty project using Create strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | emptyProject      | True                |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCreateUI
    Examples:
      | applicationName                  | defaultBranchName | codeLanguage             |
      | flask-create-def-empty-github-ui | master            | python_flask_application |

  Scenario Outline: Create application using Create strategy with EDP versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using edp versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | startFromVersion  | 1.0.1               |
      | startFromSnapshot | SNAPSHOT            |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCreateUI
    Examples:
      | applicationName                    | defaultBranchName | codeLanguage          |
      | js-angular-create-edp-github-ui    | master            | angular_application   |
      | java11-gr-lib-create-edp-github-ui | master            | java11_gradle_library |

  Scenario Outline:Create empty project using Create strategy with EDP versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using edp versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | emptyProject      | True                |
      | startFromVersion  | 1.0.1               |
      | startFromSnapshot | SNAPSHOT            |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCreateUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage   |
      | docker-create-edp-empty-github-ui | master            | docker_library |

  Scenario Outline: Create application using Clone strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using default versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCloneUI
    Examples:
      | applicationName                  | defaultBranchName | codeLanguage             |
      | java17-maven-clone-def-github-ui | master            | java17_maven_application |
      | express-lib-clone-def-github-ui  | master            | express_library          |

  Scenario Outline: Create application using Clone strategy with EDP versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using edp versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | startFromVersion  | 1.0.1               |
      | startFromSnapshot | SNAPSHOT            |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCloneUI
    Examples:
      | applicationName                  | defaultBranchName | codeLanguage         |
      | js-angular-clone-edp-github-ui   | master            | angular_application  |
      | java8-gr-lib-clone-edp-github-ui | master            | java8_gradle_library |

  Scenario Outline: Create application using Import strategy with Default versioning
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    And User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User imports codebase using default versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubImportUI
    Examples:
      | applicationName                    | defaultBranchName | codeLanguage             |
      | go-sdk-import-def-github-ui        | master            | operator_sdk_application |
      | terraform-lib-import-def-github-ui | master            | hcl_terraform_library    |

  Scenario Outline: Create application using Import strategy with EDP versioning
    Given User generates "<codeLanguage>" github project with "<applicationName>" project name
    And User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User imports codebase using edp versioning type on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
      | startFromVersion  | 1.0.1               |
      | startFromSnapshot | SNAPSHOT            |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubImportUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage             |
      | java17-mvn-import-edp-github-ui   | master            | java17_maven_application |
      | rego-opa-lib-import-edp-github-ui | master            | opa_library              |