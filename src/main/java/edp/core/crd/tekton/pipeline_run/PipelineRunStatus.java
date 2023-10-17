package edp.core.crd.tekton.pipeline_run;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class PipelineRunStatus {

    private Condition[] conditions;
    private PipelineSpec pipelineSpec;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Condition {
        private String status;
        private String type;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class PipelineSpec {
        private Param[] params;

        @Data
        @JsonIgnoreProperties(ignoreUnknown = true)
        public static class Param {
            @JsonProperty("default")
            private String value;
            private String name;
        }
    }
}
