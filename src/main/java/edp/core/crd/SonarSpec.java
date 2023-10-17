package edp.core.crd;

import lombok.Data;

@Data
public class SonarSpec {

    private String basePath;

    private String dbImage;

    private String defaultPermissionTemplate;

    private SonarEdpSpec edpSpec;

    private String image;

    private String initImage;

    private String type;

    private String version;

    private Volumes[] volumes;



}
@Data
class SonarEdpSpec{
    String dnsWildcard;
}
@Data
class Volumes{
    String capacity;
    String name;
    String storage_class;
}