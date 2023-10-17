Feature: Gitlab_integration

  @Gitlab_integration @IntegrationJenkins
  Scenario Outline: Create gitlab-sshkey in namespace for Github integration
    Given User creates "<secretName>" gitlab-sshsecret with following values
    Examples:
      | secretName    |
      | gitlab-sshkey |

  @Gitlab_integration @IntegrationJenkins
  Scenario Outline: Create GitServer for Gitlab integration
    Given User creates Gitlab git server with following values
      | gitServerName   | gitHost   | gitUser   | nameSshKeySecret   |
      | <gitServerName> | <gitHost> | <gitUser> | <nameSshKeySecret> |
    And User checks "<gitServerName>" git server status
    Examples:
      | gitServerName | gitHost      | gitUser | nameSshKeySecret |
      | git-epam      | git.epam.com | git     | gitlab-sshkey    |

  @Gitlab_integration @IntegrationJenkins
  Scenario Outline: Create CI provisioner for Github integration
    Given User creates "<provisionerName>" ci provisioner with "<mediaType>" media type
    Then User configure "<provisionerName>" gitlab ci provisioner
    Examples:
      | provisionerName | mediaType                     |
      | gitlab          | hudson.model.FreeStyleProject |

  @Gitlab_integration @IntegrationJenkins
  Scenario Outline: Create service account with gitlab-sshkey secret for Gitlab integration
    Given User creates service account
      | credentialName   | credentialType   |
      | <credentialName> | <credentialType> |
    And User checks "<credentialName>" jenkins service account status
    Examples:
      | credentialName | credentialType |
      | gitlab-sshkey  | ssh            |

  @Gitlab_integration @IntegrationJenkins
  Scenario Outline: Create API token secret in namespace for Gitlab integration
    Given User creates "<secretName>" gitlab API token secret
    Examples:
      | secretName          |
      | gitlab-access-token |

  @Gitlab_integration @IntegrationJenkins
  Scenario Outline: Create service account with gitlab-access-token secret for Gitlab integration
    Given User creates service account
      | credentialName   | credentialType   |
      | <credentialName> | <credentialType> |
    And User checks "<credentialName>" jenkins service account status
    Examples:
      | credentialName      | credentialType |
      | gitlab-access-token | token          |


  @Gitlab_integration @IntegrationJenkins @UI
  Scenario Outline: Configure Gitlab connection
    Given User opens Jenkins as default user
    And User clicks 'Manage Jenkins' button
    And User clicks 'Configure System' button
    And User enters "<gitlabConnectionName>" gitlab connection name
    And User enters "<gitlabHostUrl>" gitlab host url
    And User selects "<gitlabAccessApiToken>" gitlab access api token
    And User clicks 'Save' button
    Examples:
      | gitlabConnectionName | gitlabHostUrl        | gitlabAccessApiToken |
      | git.epam.com         | https://git.epam.com | gitlab-access-token  |
