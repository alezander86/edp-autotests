package edp.core.crd;

import lombok.Data;

@Data
public class NexusSpec {

    private String basePath;

    private NexusEdpSpec edpSpec;

    private String image;

    private NexusKeycloakSpec keycloakSpec;

    private NexusUsers users;

}
@Data
class NexusEdpSpec{
    String dnsWildcard;
}
@Data
class NexusKeycloakSpec{
    Boolean enabled;
    String proxyImage;
    String[] roles;
}
@Data
class NexusUsers{
    String[] roles;
    String username;
}
