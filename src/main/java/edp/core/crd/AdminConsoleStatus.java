package edp.core.crd;

import lombok.Data;

@Data
public class AdminConsoleStatus {

    private Boolean available;

    private String lastTimeUpdated;

    private String status;
}
