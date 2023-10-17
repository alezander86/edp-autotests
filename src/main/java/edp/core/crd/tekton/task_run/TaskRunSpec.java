package edp.core.crd.tekton.task_run;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.ArrayList;
import java.util.List;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class TaskRunSpec {
    private Param[] params;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Param {
        private String name;
        private Object value;
    }

}

