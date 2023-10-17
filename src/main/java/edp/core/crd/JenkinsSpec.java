package edp.core.crd;

import lombok.Data;

@Data
public class JenkinsSpec {

    private JenkinsEdpSpec edpSpec;

    private String image;

    private String initImage;

    private JenkinsKeycloakSpec keycloakSpec;

    private SharedLibraries[] sharedLibraries;

    private String version;

    private JenkinsVolumes[] volumes;


}

@Data
class JenkinsEdpSpec {
    String dnsWildcard;
}

@Data
class JenkinsKeycloakSpec {
    Boolean enabled;
    String realm;
}

@Data
class SharedLibraries {
    String name;
    String tag;
    String url;
}
@Data
class JenkinsVolumes{
    String capacity;
    String name;
    String storageClass;
}