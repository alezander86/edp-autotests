package edp.core.crd;

import lombok.Data;

@Data
public class JenkinsServiceAccountStatus {

    private Boolean available;

    private Boolean created;

    private String lastTimeUpdated;

}
