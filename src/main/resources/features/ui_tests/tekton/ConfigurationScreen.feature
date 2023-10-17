Feature: Configuration screen features

  @UI @TektonGerritUI @TektonGithubUI @TektonGitlabUI
  Scenario: Check configuration screen fields
    Given User opens EDP Headlamp as default user
    When User opens EDP Configuration tab
    Then User checks Git Servers configuration parameters
    And User checks Clusters configuration parameters
    And User checks Registry configuration parameters
    And User checks SonarQube configuration parameters with ci-sonarqube secret
    And User checks Nexus configuration parameters with ci-nexus secret
    And User checks DefectDojo configuration parameters with ci-defectdojo secret
    And User checks DependencyTrack configuration parameters with ci-dependency-track secret
    And User checks Jira configuration parameters with ci-jira secret
    And User checks GitOps configuration parameters
    And User checks Links configuration parameters
