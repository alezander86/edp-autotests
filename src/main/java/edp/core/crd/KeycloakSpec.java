package edp.core.crd;

import lombok.Data;

@Data
public class KeycloakSpec {

    private String secret;

    private String url;

    private Kusers[] users;

}

@Data
class Kusers {
    String[] realmRoles;
    String username;
}
