package edp.core.crd;

import lombok.Data;

@Data
public class GerritStatus {

    private Boolean available;

    private String externalUrl;

    private String lastTimeUpdated;

    private String[] processedUsers;

    private String status;

}
