package edp.core.crd;

import lombok.Data;

@Data
public class NexusStatus {

    private Boolean available;

    private String lastTimeUpdated;

    private String status;

}
