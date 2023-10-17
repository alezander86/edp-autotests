Feature: Github_integration

  @Github_integration @IntegrationJenkins
  Scenario Outline: Create github-sshkey in namespace for Github integration
    Given User creates "<secretName>" github-sshsecret with following values
    Examples:
      | secretName    |
      | github-sshkey |

  @Github_integration @IntegrationJenkins
  Scenario Outline: Create GitServer for Github integration
    Given User creates Github git server with following values
      | gitServerName   | gitHost   | gitUser   | nameSshKeySecret   |
      | <gitServerName> | <gitHost> | <gitUser> | <nameSshKeySecret> |
    And User checks "<gitServerName>" git server status
    Examples:
      | gitServerName | gitHost    | gitUser | nameSshKeySecret |
      | github        | github.com | git     | github-sshkey    |

  @Github_integration @IntegrationJenkins
  Scenario Outline: Create CI provisioner for Github integration
    Given User creates "<provisionerName>" ci provisioner with "<mediaType>" media type
    Then User configure "<provisionerName>" github ci provisioner
    Examples:
      | provisionerName | mediaType                     |
      | github          | hudson.model.FreeStyleProject |

  @Github_integration @IntegrationJenkins
  Scenario Outline: Create service account with github-sshkey secret for Github integration
    Given User creates service account
      | credentialName   | credentialType   |
      | <credentialName> | <credentialType> |
    And User checks "<credentialName>" jenkins service account status
    Examples:
      | credentialName | credentialType |
      | github-sshkey  | ssh            |

  @Github_integration @IntegrationJenkins
  Scenario Outline: Create API token secret in namespace for Github integration
    Given User creates "<secretName>" github API token secret
    Examples:
      | secretName          |
      | github-access-token |

  @Github_integration @IntegrationJenkins
  Scenario Outline: Create service account with github-access-token secret for Github integration
    Given User creates service account
      | credentialName   | credentialType   |
      | <credentialName> | <credentialType> |
    And User checks "<credentialName>" jenkins service account status
    Examples:
      | credentialName      | credentialType |
      | github-access-token | token          |

  @Github_integration @IntegrationJenkins @UI
  Scenario Outline: Configure Github connection
    Given User opens Jenkins as default user
    And User clicks 'Manage Jenkins' button
    And User clicks 'Configure System' button
    And User clicks 'Add Github server' button
    And User clicks 'github Server' button
    Then User enters "<githubConnectionName>" github connection name
#    And User enters "<githubHostUrl>" github host url
    And User selects "<githubAccessApiToken>" github access api token
    And User selects "<githubAccessApiToken>" token for pull request builder
    And User clicks 'Save' button
    Examples:
      | githubConnectionName | githubHostUrl          | githubAccessApiToken |
      | github               | https://api.github.com | github-access-token  |
