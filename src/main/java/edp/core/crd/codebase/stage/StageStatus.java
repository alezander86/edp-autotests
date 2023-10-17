package edp.core.crd.codebase.stage;

import lombok.Data;

@Data
public class StageStatus {

    private String action;

    private Boolean available;

    private String detailed_message;

    private String value;

    private String last_time_updated;

    private String status;

    private String username;

    private String result;

    private String shouldBeHandled;

}
