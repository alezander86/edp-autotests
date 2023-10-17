package edp.core.crd;

import lombok.Data;

@Data
public class JiraServerStatus {

    private boolean available;

    private String detailed_message;

    private String last_time_updated;

    private String status;

}
