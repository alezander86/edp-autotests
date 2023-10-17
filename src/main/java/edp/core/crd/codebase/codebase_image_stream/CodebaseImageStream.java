package edp.core.crd.codebase.codebase_image_stream;

import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;

@Version("v1")
@Group("v2.edp.epam.com")
public class CodebaseImageStream extends CustomResource<CodebaseImageStreamSpec, CodebaseImageStreamList> implements Namespaced {

    public boolean isOfCodebase(String codeBaseName) {
        return this.spec.getCodebase().equals(codeBaseName);
    }
}
