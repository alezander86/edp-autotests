package edp.core.crd;

import lombok.Data;

@Data
public class GerritSpec {

    private String image;

    private GerritKeycloakSpec keycloakSpec;

    private Integer sshPort;

    private String type;

    private GerritUsers[] users;

    private String version;

    private GerritVolumes[] volumes;

}

@Data
class GerritKeycloakSpec {
    Boolean enabled;
}

@Data
class GerritUsers {
    String[] groups;
    String username;
}

@Data
class GerritVolumes{
    String capacity;
    String name;
    String storage_class;
}
