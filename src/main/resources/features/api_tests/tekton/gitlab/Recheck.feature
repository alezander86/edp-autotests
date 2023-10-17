Feature: Check review pipeline started using /recheck comment on gitlab

  Scenario Outline: Check rerun review pipeline using '/recheck' comment message
    Given User clones edp codebase on gitlab
      | applicationName | <applicationName> |
      | codeLanguage    | <codeLanguage>    |
      | startFrom       | 1.2.3-SNAPSHOT    |
    When User creates new branch
      | applicationName  | <applicationName>  |
      | branchName       | <newBranchName>    |
      | newBranchVersion | 1.2.3-NEW-SNAPSHOT |
    When User receive and save GitLab project ID for project <applicationName>
    When User creates pull request from "<defaultBranchName>" ref branch to "<newBranchName>" target branch in gitlab
    Then User checks review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    When User restarts review pipeline using recheck comment in gitlab
    Then User checks second review pipeline status for "<newBranchName>" branch in "<applicationName>" codebase
    And User deletes "<applicationName>" codebase resources

    @TektonGitlab @TektonGitlabRecheck
    Examples:
      | applicationName                    | codeLanguage       | defaultBranchName | newBranchName |
      | dotnet6-lib-cln-edp-gitlab-recheck | dotnet_6_0_library | master            | new           |
