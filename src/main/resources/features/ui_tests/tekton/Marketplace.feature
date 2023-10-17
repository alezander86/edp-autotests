Feature: Applications provisioning using Marketplace template

  Scenario Outline: Create application using Marketplace template with Default versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Marketplace tab
    Then User creates codebase from "<templateName>" template with default versioning type on table view mode
      | applicationName | <applicationName> |
    When User opens EDP Components tab
    And User searches created application by <applicationName> name
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created main branch as default
    And User deletes application with name <applicationName>
    @UI @TektonGerritUI @TektonGithubUI @TektonGitlabUI @Marketplace
    Examples:
      | applicationName                    | templateName                         | codeLanguage               |
      | js-antora-app-marketplace-template | Documentation as Code with Antora    | antora_application         |
      | dotnet6-app-marketplace-template   | Modern Applications with C# .NET 6.0 | dotnet_6_0_application     |
      | fastapi-app-marketplace-template   | Fast API Microservice                | python_fastapi_application |


  Scenario Outline: Create application using Marketplace template with EDP versioning
    Given User opens EDP Headlamp as default user
    When User opens EDP Marketplace tab
    And User creates codebase from "<templateName>" template with edp versioning type on cube view mode
      | applicationName   | <applicationName> |
      | startFromVersion  | 6.5.8             |
      | startFromSnapshot | NEW-SNAPSHOT      |
    When User opens EDP Components tab
    And User searches created application by <applicationName> name
    Then User sees success status and correct values in fields for <applicationName> application
      | codeLanguage | <codeLanguage> |
      | ciTool       | Tekton         |
    When User select created application <applicationName> name
    Then User sees created main branch as default
    And User deletes application with name <applicationName>
    @UI @TektonGerritUI @TektonGithubUI @TektonGitlabUI @Marketplace
    Examples:
      | applicationName                     | templateName                        | codeLanguage             |
      | go-gin-app-marketplace-template     | Web Applications with Gin Framework | go_go_gin_application    |
      | java17-mvn-app-marketplace-template | Simple Spring Boot Application      | java17_maven_application |
      | terraform-lib-marketplace-template  | Terraform Module                    | hcl_terraform_library    |