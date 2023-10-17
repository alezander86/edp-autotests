package edp.core.crd.codebase.codebase;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;

import static edp.core.crd.codebase.codebase_branch.CodebaseBranch.formatCodebaseBranchName;

@Version("v1")
@Group("v2.edp.epam.com")
public class Codebase extends CustomResource<CodebaseSpec, CodebaseStatus> implements Namespaced {

    public Codebase() {
    }

    public Codebase(CodebaseSpec spec, ObjectMeta meta) {
        setSpec(spec);
        setMetadata(meta);
    }

    public String getDefaultCodebaseBranchName() {
        return formatCodebaseBranchName(getMetadata().getName(), getSpec().getDefaultBranch());
    }

    @JsonIgnore
    public Boolean isActive() {
        return getStatus().getValue().equals("active");
    }
}

