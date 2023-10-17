package edp.core.crd.argocd.application;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;

@Version("v1alpha1")
@Group("argoproj.io")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Application extends CustomResource<ApplicationSpec, ApplicationStatus> implements Namespaced {

    public Application() {
    }

    public Application(ApplicationSpec spec, ObjectMeta meta) {
        setSpec(spec);
        setMetadata(meta);
    }

    @JsonIgnore
    public Boolean isHealthy() {
        return getStatus().getHealth().getStatus().equals("Healthy");
    }

    @JsonIgnore
    public Boolean isSynced() {
        return getStatus().getSync().getStatus().equals("Synced");
    }
}
