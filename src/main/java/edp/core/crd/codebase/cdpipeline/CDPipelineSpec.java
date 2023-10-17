package edp.core.crd.codebase.cdpipeline;

import lombok.Data;

@Data
public class CDPipelineSpec {

    private String[] applicationsToPromote;

    private String[] applications;

    private String deploymentType;

    private String[] inputDockerStreams;

    private String name;


}
