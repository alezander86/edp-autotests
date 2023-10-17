package edp.core.crd;

import lombok.Data;

@Data
public class JiraServerSpec {

    private String apiUrl;

    private String credentialName;

    private String rootUrl;

}
