package edp.core.crd.jenkins_folder;

import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;

@Version("v1")
@Group("v2.edp.epam.com")
public class JenkinsFolder extends CustomResource<JenkinsFolderSpec, JenkinsFolderStatus> implements Namespaced {
}
