package edp.core.crd.codebase.codebase_branch;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CodebaseBranchStatus {

    private String action;
    private String build;
    private String detailedMessage;
    private Integer failureCount;
    private String lastSuccessfulBuild;
    private String lastTimeUpdated;
    private String result;
    private String status;
    private String username;
    private String value;
    private String[] versionHistory;

}
