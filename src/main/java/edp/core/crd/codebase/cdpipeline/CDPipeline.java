package edp.core.crd.codebase.cdpipeline;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;

@Version("v1")
@Group("v2.edp.epam.com")
public class CDPipeline extends CustomResource<CDPipelineSpec, CDPipelineStatus> implements Namespaced {

    public CDPipeline() {
    }

    public CDPipeline(CDPipelineSpec spec, ObjectMeta meta) {
        setSpec(spec);
        setMetadata(meta);
    }

    @JsonIgnore
    public Boolean isActive() {
        return getStatus().getValue().equals("active");
    }
}
