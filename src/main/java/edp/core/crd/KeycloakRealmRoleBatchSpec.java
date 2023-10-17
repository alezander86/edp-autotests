package edp.core.crd;

import lombok.Data;

@Data
public class KeycloakRealmRoleBatchSpec {

    private String realm;

    private Roles[] roles;

}
@Data
class Roles {
    String attributes;
    Boolean composite;
    String composites;
    String description;
    Boolean isDefault;
    String name;
}