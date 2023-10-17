package edp.core.crd;

import lombok.Data;

@Data
public class KeycloakRealmSpec {

    private String browserFlow;

    private String id;

    private String keycloakOwner;

    private String realmEventConfig;

    private String realmName;

    private String ssoRealmName;

    private Users[] users;

}
@Data
class Users {
    String[] realmRoles;
    String username;
}
