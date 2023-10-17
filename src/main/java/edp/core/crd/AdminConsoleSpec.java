package edp.core.crd;

import lombok.Data;

@Data
public class AdminConsoleSpec {

    private DbSpec dbSpec;

    private EdpSpec edpSpec;

    private String image;

    private AkeycloakSpec keycloakSpec;

    private String version;

}
@Data
class DbSpec {
    Boolean enabled;
    String hostname;
    String name;
    Integer port;
}
@Data
class EdpSpec {
    String dnsWildcard;
    String  integrationStrategies;
    String name;
    String testReportTools;
    String version;
}
@Data
class AkeycloakSpec {
    Boolean enabled;
}
