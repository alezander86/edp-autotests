package edp.core.crd.codebase.codebase_branch;

import lombok.Data;

import java.util.List;

@Data
public class CodebaseBranchSpec {

    private String branchName;
    private String codebaseName;
    private String fromCommit;
    private boolean release;
    private List<String> releaseJobParams;
    private String version;


}
