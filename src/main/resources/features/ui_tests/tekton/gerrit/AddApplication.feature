Feature: Applications provisioning using Create strategy on gerrit

  Scenario Outline: Create application using Create strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on gerrit
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    @UI @TektonGerritUI @TektonCreateUI
    Examples:
      | applicationName            | defaultBranchName | codeLanguage             |
      | java8-gradle-create-def-ui | master            | java8_gradle_application |
      | rego-opa-create-def-ui     | master            | opa_library              |

  Scenario Outline: Create empty project using Create strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on gerrit
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
    @UI @TektonGerritUI @TektonCreateUI
    Examples:
      | applicationName                | defaultBranchName | codeLanguage       |
      | python-3-8-create-def-empty-ui | master            | python_3_8_library |

  Scenario Outline: Create application using Create strategy with EDP versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using edp versioning type on gerrit
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
    @UI @TektonGerritUI @TektonCreateUI
    Examples:
      | applicationName               | defaultBranchName | codeLanguage      |
      | js-react-create-edp-ui        | master            | react_application |
      | helm-charts-lib-create-edp-ui | master            | charts_library    |

  Scenario Outline:Create empty project using Create strategy with EDP versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using edp versioning type on gerrit
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
    @UI @TektonGerritUI @TektonCreateUI
    Examples:
      | applicationName           | defaultBranchName | codeLanguage      |
      | beego-create-edp-empty-ui | master            | beego_application |

  Scenario Outline: Create application using Clone strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using default versioning type on gerrit
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    @UI @TektonGerritUI @TektonCloneUI
    Examples:
      | applicationName            | defaultBranchName | codeLanguage              |
      | java11-gradle-clone-def-ui | master            | java11_gradle_application |
      | rego-opa-clone-def-ui      | master            | opa_library               |

  Scenario Outline: Create application using Clone strategy with EDP versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using edp versioning type on gerrit
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
    @UI @TektonGerritUI @TektonCloneUI
    Examples:
      | applicationName              | defaultBranchName | codeLanguage      |
      | js-react-clone-edp-ui        | master            | react_application |
      | helm-charts-lib-clone-edp-ui | master            | charts_library    |