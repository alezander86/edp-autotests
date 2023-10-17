package edp.core.crd.tekton.task_run;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.fabric8.kubernetes.api.model.Namespaced;
import io.fabric8.kubernetes.client.CustomResource;
import io.fabric8.kubernetes.model.annotation.Group;
import io.fabric8.kubernetes.model.annotation.Version;


@Version("v1beta1")
@Group("tekton.dev")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TaskRun extends CustomResource<TaskRunSpec, TaskRunStatus> implements Namespaced {

    public boolean isFailed() {
        TaskRunStatus.Condition condition = status.getConditions()[0];
        return condition.getStatus().equals("False");
    }

}

