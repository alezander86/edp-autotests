Feature: Check review pipeline started using /recheck comment on github

  Scenario Outline: Check rerun review pipeline using '/recheck' comment message
    Given User creates default codebase on github
      | applicationName   | <applicationName>   |
      | codeLanguage      | <codeLanguage>      |
      | defaultBranchName | <defaultBranchName> |
    When User creates pull request to "<defaultBranchName>" target branch in github "<applicationName>" project
    Then User checks review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    When User restarts review pipeline using recheck comment for <applicationName> in github
    Then User checks second review pipeline status for "<defaultBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources
    And User deletes "<applicationName>" github project
    @TektonGithub @TektonGithubRecheck @TektonGithubShortRegression
    Examples:
      | applicationName                    | codeLanguage          | defaultBranchName |
      | helm-app-import-def-github-recheck | helm_application      | master            |