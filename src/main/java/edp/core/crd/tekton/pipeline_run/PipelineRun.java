package edp.core.crd.tekton.pipeline_run;

import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;

import java.util.Arrays;

@Version("v1beta1")
@Group("tekton.dev")
public class PipelineRun extends CustomResource<PipelineRunSpec, PipelineRunStatus> implements Namespaced {

    public boolean isSucceeded() {
        PipelineRunStatus.Condition condition = status.getConditions()[0];
        return condition.getStatus().equals("True")
                && condition.getType().equals("Succeeded");
    }

    public boolean isFailed() {
        PipelineRunStatus.Condition condition = status.getConditions()[0];
        return condition.getStatus().equals("False");
    }

    public String getPipelineRunUrl() {
        PipelineRunStatus.PipelineSpec.Param[] params = status.getPipelineSpec().getParams();
        return Arrays.stream(params).filter(p -> p.getName().equals("pipelineUrl")).findFirst().get().getValue();
    }

    public static String formatPipelineRunName(String pipelineType, String codebaseBranchName) {
        return codebaseBranchName + "-" + pipelineType;
    }
}

