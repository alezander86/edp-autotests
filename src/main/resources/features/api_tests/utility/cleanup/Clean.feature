Feature: Clean

  @Clean
  Scenario: Clean gerrit projects
    When User deletes gerrit projects

  @Clean
  Scenario: Delete Gitlab projects
    Given User deletes Gitlab projects

  @Clean
  Scenario: Delete Github test projects
    Given User deletes Github projects

  @Clean
  Scenario: Delete Jira subtasks
    Given User deletes Jira subtasks

  @Clean @CleanCr
  Scenario: Clean custom resources
    When User deletes custom resources
