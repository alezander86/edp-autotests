Feature: System configuration

  @IntegrationJenkins
  Scenario Outline: Change number of executors
    Given User sets number of workers in Jenkins for "<computerName>" computer name
    Examples:
      | computerName |
      | (built-in)   |

  Scenario Outline: Update kaniko-docker-config secret data
    Given User updates "<secretName>" secret data
    Examples:
      | secretName           |
      | kaniko-docker-config |

