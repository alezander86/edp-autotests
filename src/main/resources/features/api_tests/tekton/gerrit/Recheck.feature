Feature: Check review pipeline started using /recheck comment on gerrit

  Scenario Outline: Check rerun review pipeline using '/recheck' comment message
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
    When User restarts review pipeline using recheck comment in gerrit
    Then User checks second review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    @TektonGerrit @TektonGerritRecheck
    Examples:
      | applicationName                  | codeLanguage          | newBranchName | startFrom      | newBranchVersion   |
      | go-gin-create-edp-review-recheck | go_go_gin_application | new           | 1.2.3-snapshot | 1.2.3-new-snapshot |