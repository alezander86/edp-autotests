package edp.core.crd;

import lombok.Data;

@Data
public class SonarStatus {

    private Boolean available;

    private String lastTimeUpdated;

    private String status;

}
