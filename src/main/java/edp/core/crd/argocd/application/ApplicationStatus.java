package edp.core.crd.argocd.application;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ApplicationStatus {
    private Health health;
    private Sync sync;
}
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
class Health {
    private String status;
}

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
class Sync {
    private String status;
}