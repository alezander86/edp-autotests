Feature: Checking Custom Resources status

  @CRCheck
  Scenario Outline: Check Jenkins Service Account CR status
    And User checks "<credentialName>" jenkins service account status
    Examples:
      | credentialName       |
      | gerrit-ciuser-sshkey |
      | nexus-ci.user        |
      | sonar-ciuser-token   |

  @CRCheck
  Scenario Outline: Check Admin Console CR status
    And User checks "<crName>" admin console cr status
    Examples:
      | crName            |
      | edp-admin-console |

  @CRCheck
  Scenario Outline: Check Sonar CR status
    And User checks "<crName>" sonar cr status
    Examples:
      | crName |
      | sonar  |

  @CRCheckNexus
  Scenario Outline: Check Nexus CR status
    And User checks "<crName>" nexus cr status
    Examples:
      | crName |
      | nexus  |

  @CRCheck
  Scenario Outline: Check Gerrit CR status
    And User checks "<crName>" gerrit cr status
    Examples:
      | crName |
      | gerrit |

  @CRCheck
  Scenario Outline: Check Jenkins CR status
    And User checks "<crName>" jenkins cr status
    Examples:
      | crName  |
      | jenkins |

  @CRCheck
  Scenario Outline: Check KeycloakClient CR status
    And User checks "<crName>" keycloakClient cr status
    Examples:
      | crName            |
      | edp-admin-console |
      | gerrit            |
      | jenkins           |
      | nexus             |
      | sonar             |

  @CRCheck
  Scenario Outline: Check KeycloakRealmRoleBatch CR status
    And User checks "<crName>" keycloakRealmRoleBatch cr status
    Examples:
      | crName        |
      | default-roles |

  @CRCheck
  Scenario Outline: Check KeycloakRealmRole CR status
    And User checks "<crName>" keycloakRealmRole cr status
    Examples:
      | crName                      |
      | default-roles-administrator |
      | default-roles-developer     |

  @CRCheck
  Scenario Outline: Check KeycloakRealm CR status
    And User checks "<crName>" keycloakRealm cr status
    Examples:
      | crName |
      | main   |

  @CRCheck
  Scenario Outline: Check Keycloak CR status
    And User checks "<crName>" keycloak cr status
    Examples:
      | crName |
      | main   |



