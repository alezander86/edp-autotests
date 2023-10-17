package edp.core.crd.codebase.gitserver;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class GitServerStatus {

    private String action;

    private Boolean available;

    private String detailed_message;

    private String last_time_updated;

    private String result;

    private String status;

    private String username;

    private String value;
}
