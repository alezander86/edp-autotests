package edp.core.crd;

import lombok.Data;

@Data
public class KeycloakRealmRoleSpec {

    private String attributes;

    private Boolean composite;

    private String composites;

    private String description;

    private  String name;

    private String realm;

}
