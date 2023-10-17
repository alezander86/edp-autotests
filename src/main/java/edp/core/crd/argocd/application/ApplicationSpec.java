package edp.core.crd.argocd.application;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ApplicationSpec {
    @JsonIgnoreProperties(ignoreUnknown = true)
    private Destination destination;
    private String project;
    private Source source;
    private SyncPolicy syncPolicy;

    public void setDestination(String namespace, String name) {
        this.destination = new Destination(namespace, name);
    }

    public void setSource(String path, String repoURL, String targetRevision, String releaseName, String imageTag,
                          String imageRepository) {
        Helm helm = new Helm();
        helm.setParameters(new Parameter[]{new Parameter("image.tag", imageTag),
                new Parameter("image.repository", imageRepository)});
        helm.setReleaseName(releaseName);
        this.source = new Source(helm, path, repoURL, targetRevision);
    }

    public void setSyncPolicy(Boolean prune, Boolean selfHeal) {
        Automated automated = new Automated(prune, selfHeal);
        this.syncPolicy = new SyncPolicy(automated);
    }
}
@Data
@NoArgsConstructor
@AllArgsConstructor
class Destination{
    private String namespace;
    private String name;
}

@Data
@NoArgsConstructor
@AllArgsConstructor
class Source {
    private Helm helm;
    private String path;
    private String repoURL;
    private String targetRevision;
}

@Data
@NoArgsConstructor
@AllArgsConstructor
class Helm {
    private Parameter[] parameters;
    private String releaseName;
}

@Data
@NoArgsConstructor
@AllArgsConstructor
class Parameter {
    private String name;
    private String value;
}

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
class SyncPolicy {
    private Automated automated;
}

@Data
@NoArgsConstructor
@AllArgsConstructor
class Automated {
    private boolean prune;
    private boolean selfHeal;
}