Feature: Adding new branch for applications added using Create strategy on gitlab

  Scenario Outline: Create new branch for application added using Import strategy with default versioning
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User imports codebase using default versioning type on gitlab
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
    And User deletes gitlab fork project
    @UI @TektonGitlabUI @TektonGitlabCreateBranchUI
    Examples:
      | applicationName                    | defaultBranchName | codeLanguage           |
      | dotnet-create-br-def-gitlab-ui     | master            | dotnet_6_0_application |
      | java11-mvn-create-br-def-gitlab-ui | master            | java11_maven_library   |

  Scenario Outline: Create new branch for application added using Clone strategy with edp versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using edp versioning type on gitlab
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
    @UI @TektonGitlabUI @TektonGitlabCreateBranchUI
    Examples:
      | applicationName                       | defaultBranchName | codeLanguage        |
      | js-next-create-edp-branch-gitlab-ui   | master            | next_application    |
      | java8-mvn-create-edp-branch-gitlab-ui | master            | java8_maven_library |

  Scenario Outline: Create new release branch for application added using Create strategy with edp versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using edp versioning type on gitlab
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
    @UI @TektonGitlabUI @TektonGitlabCreateBranchUI
    Examples:
      | applicationName                    | defaultBranchName | codeLanguage              | newBranchName |
      | java17-create-edp-rc-gitlab-ui     | master            | java17_gradle_application | release/5.9   |
      | js-vue-lib-create-edp-rc-gitlab-ui | master            | vue_library               | release/5.9   |
