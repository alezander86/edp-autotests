Feature: Applications provisioning using Create strategy on gitlab

  Scenario Outline: Create application using Create strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on gitlab
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    @UI @TektonGitlabUI @TektonGitlabCreateUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage             |
      | java17-maven-create-def-gitlab-ui | master            | java17_maven_application |
      | dotnet-6-create-def-gitlab-ui     | master            | dotnet_6_0_library       |

  Scenario Outline: Create empty project using Create strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using default versioning type on gitlab
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
    @UI @TektonGitlabUI @TektonGitlabCreateUI
    Examples:
      | applicationName                    | defaultBranchName | codeLanguage       |
      | python3-create-def-empty-gitlab-ui | master            | python_3_8_library |

  Scenario Outline: Create application using Create strategy with EDP versioning
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
    And User deletes application with name <applicationName>
    @UI @TektonGitlabUI @TektonGitlabCreateUI
    Examples:
      | applicationName                  | defaultBranchName | codeLanguage        |
      | js-express-create-edp-gitlab-ui  | master            | express_application |
      | dotnet3-lib-create-edp-gitlab-ui | master            | python_3_8_library  |

  Scenario Outline:Create empty project using Create strategy with EDP versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User creates codebase using edp versioning type on gitlab
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
    @UI @TektonGitlabUI @TektonGitlabCreateUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage             |
      | go-gin-create-edp-empty-gitlab-ui | master            | operator_sdk_application |

  Scenario Outline: Create application using Clone strategy with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User clones codebase using default versioning type on gitlab
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created <defaultBranchName> branch as default
    And User deletes application with name <applicationName>
    @UI @TektonGitlabUI @TektonGitlabCloneUI
    Examples:
      | applicationName                  | defaultBranchName | codeLanguage             |
      | java11-maven-clone-def-gitlab-ui | master            | java11_maven_application |
      | dotnet-6-clone-def-gitlab-ui     | master            | dotnet_6_0_library       |

  Scenario Outline: Create application using Clone strategy with EDP versioning
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
    And User deletes application with name <applicationName>
    @UI @TektonGitlabUI @TektonGitlabCloneUI
    Examples:
      | applicationName                   | defaultBranchName | codeLanguage          |
      | js-express-clone-edp-gitlab-ui    | master            | express_application   |
      | terraform-lib-clone-edp-gitlab-ui | master            | hcl_terraform_library |

  Scenario Outline: Create application using Import strategy with Default versioning
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
    And User deletes application with name <applicationName>
    And User deletes gitlab fork project
    @UI @TektonGitlabUI @TektonGitlabImportUI
    Examples:
      | applicationName                    | defaultBranchName | codeLanguage              |
      | java11-gradle-import-def-gitlab-ui | master            | java11_gradle_application |
      | codenarc-import-def-gitlab-ui      | master            | codenarc_library          |

  Scenario Outline: Create application using Imports strategy with EDP versioning
    Given User forks "<codeLanguage>" gitlab project with "<applicationName>" project name
    And User opens EDP Headlamp as default user
    When User opens EDP Components tab
    And User imports codebase using edp versioning type on gitlab
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
    And User deletes gitlab fork project
    @UI @TektonGitlabUI @TektonGitlabImportUI
    Examples:
      | applicationName                 | defaultBranchName | codeLanguage      |
      | beego-import-edp-gitlab-ui      | master            | beego_application |
      | docker-lib-import-edp-gitlab-ui | master            | docker_library    |
