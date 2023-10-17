package edp.core.crd.tekton.task_run;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class TaskRunStatus {

    private Condition[] conditions;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Condition {
        private String status;
    }
}
