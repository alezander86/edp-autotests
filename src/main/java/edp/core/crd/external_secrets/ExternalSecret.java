package edp.core.crd.external_secrets;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;

@Version("v1beta1")
@Group("external-secrets.io")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ExternalSecret extends CustomResource<ExternalSecretSpec, ExternalSecretStatus> implements Namespaced {

}
