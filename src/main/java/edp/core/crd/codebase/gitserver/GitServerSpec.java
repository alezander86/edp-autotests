package edp.core.crd.codebase.gitserver;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class GitServerSpec {

    private boolean createCodeReviewPipeline;
    private String gitHost;
    private String gitProvider;
    private String gitUser;
    private Integer httpsPort;
    private String nameSshKeySecret;
    private Integer sshPort;

}
