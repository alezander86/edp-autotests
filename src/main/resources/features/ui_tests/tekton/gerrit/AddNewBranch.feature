Feature: Adding new branch for applications added using Create strategy on gerrit

  Scenario Outline: Create new branch for application added using Create strategy with default versioning
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
    When User creates new branch with default versioning type in <applicationName> application
      | newBranchName | new |
    Then User deletes new branch
    And User deletes application with name <applicationName>
    @UI @TektonGerritUI @TektonCreateBranchUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage         |
      | helm-create-branch-def-ui         | master            | helm_application     |
      | java8-gradle-create-branch-def-ui | master            | java8_gradle_library |

  Scenario Outline: Create new branch for application added using Clone strategy with edp versioning
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
    When User creates new branch with edp versioning type in <applicationName> application
      | newBranchName     | new          |
      | startFromVersion  | 2.3.4        |
      | StartFromSnapshot | NEW-SNAPSHOT |
    Then User deletes new branch
    And User deletes application with name <applicationName>
    @UI @TektonGerritUI @TektonCreateBranchUI
    Examples:
      | applicationName                  | defaultBranchName | codeLanguage        |
      | js-vue-create-edp-branch-ui      | master            | vue_application     |
      | java8-maven-create-edp-branch-ui | master            | java8_maven_library |

  Scenario Outline: Create new release branch for application added using Create strategy with edp versioning
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
    When User creates new branch with edp versioning type in <applicationName> application
      | newBranchName     | <newBranchName> |
      | startFromVersion  | 5.9.7           |
      | StartFromSnapshot | RC              |
      | realiseBranch     | True            |
    Then User sees created <newBranchName> branch as release
    And User deletes <newBranchName> branch
    And User deletes application with name <applicationName>
    @UI @TektonGerritUI @TektonCreateBranchUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage                 | newBranchName |
      | fastapi-create-edp-rc-branch-ui   | master            | python_fastapi_application   | release/5.9   |
      | terraform-create-edp-rc-branch-ui | master            | hcl_terraform_infrastructure | release/5.9   |
