Feature: Overview screen features

  @UI @TektonGerritUI @TektonGithubUI @TektonGitlabUI
  Scenario: Add and check new link
    Given User opens EDP Headlamp as default user
    When User opens EDP Configuration tab
    And User adds new link with random name and url
    And User opens EDP Overview tab
    Then User checks created link with random name and url

