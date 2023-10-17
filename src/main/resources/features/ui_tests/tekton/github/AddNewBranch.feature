Feature: Adding new branch for applications added using Create strategy on github

  Scenario Outline: Create new branch for application added using Clone strategy with default versioning
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
    When User creates new branch with default versioning type in <applicationName> application
      | newBranchName | new |
    Then User deletes new branch
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCreateBranchUI
    Examples:
      | applicationName                  | defaultBranchName | codeLanguage           |
      | dotnet-create-br-def-github-ui   | master            | dotnet_3_1_application |
      | pipeline-create-br-def-github-ui | master            | pipeline_library       |

  Scenario Outline: Create new branch for application added using Create strategy with edp versioning
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
    When User creates new branch with edp versioning type in <applicationName> application
      | newBranchName     | new          |
      | startFromVersion  | 2.3.4        |
      | StartFromSnapshot | NEW-SNAPSHOT |
    Then User deletes new branch
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCreateBranchUI
    Examples:
      | applicationName                 | defaultBranchName | codeLanguage       |
      | js-next-create-edp-br-github-ui | master            | next_application   |
      | dotnet6-create-edp-br-github-ui | master            | dotnet_6_0_library |

  Scenario Outline: Create new release branch for application added using Import strategy with edp versioning
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
    When User creates new branch with edp versioning type in <applicationName> application
      | newBranchName     | <newBranchName> |
      | startFromVersion  | 5.9.7           |
      | StartFromSnapshot | RC              |
      | realiseBranch     | True            |
    Then User sees created <newBranchName> branch as release
    And User deletes <newBranchName> branch
    And User deletes application with name <applicationName>
    And User deletes "<applicationName>" github project
    @UI @TektonGithubUI @TektonGithubCreateBranchUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage             | newBranchName |
      | java17-create-edp-rc-github-ui    | master            | java17_maven_application | release/5.9   |
      | react-lib-create-edp-rc-github-ui | master            | react_library            | release/5.9   |
