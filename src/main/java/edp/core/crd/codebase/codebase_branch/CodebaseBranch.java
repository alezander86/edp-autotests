package edp.core.crd.codebase.codebase_branch;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;

@Version("v1")
@Group("v2.edp.epam.com")
public class CodebaseBranch extends CustomResource<CodebaseBranchSpec, CodebaseBranchStatus> implements Namespaced {

    public CodebaseBranch() {
    }

    public CodebaseBranch(CodebaseBranchSpec spec, CodebaseBranchStatus status, ObjectMeta meta) {
        setSpec(spec);
        setStatus(status);
        setMetadata(meta);
    }

    @JsonIgnore
    public Boolean isActive() {
        return getStatus().getValue().equals("active");
    }

    public static String formatCodebaseBranchName(String codebase, String branch) {
        return codebase + "-" + branch;
    }

    public static String formatCodebaseBranchNameForManualLaunch(String codebase, String branch) {
        return (codebase + "-" + branch).length() <= 33 ? (codebase + "-" + branch) :
                (codebase + "-" + branch).substring(0, 33);
    }
}
