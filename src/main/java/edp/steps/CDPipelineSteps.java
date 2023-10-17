package edp.steps;

import edp.core.config.EdpComponentsConfig;
import edp.core.crd.codebase.cdpipeline.CDPipeline;
import edp.core.crd.codebase.cdpipeline.CDPipelineSpec;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import java.util.Map;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class CDPipelineSteps {

    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;

    public void createCDPipeline(Map<String, String> cdPipelineParameters) {
        createCDPipeline(getCDPipelineFromMap(cdPipelineParameters));
    }

    private CDPipeline getCDPipelineFromMap(Map<String, String> cdPipelineData) {
        CDPipelineSpec spec = new CDPipelineSpec();
        spec.setName(cdPipelineData.get("name"));
        spec.setDeploymentType(cdPipelineData.get("deploymentType"));
        spec.setApplications(new String[]{cdPipelineData.get("applicationName")});
        spec.setInputDockerStreams(new String[]{cdPipelineData.get("applicationName").concat("-")
                .concat(cdPipelineData.get("branchName"))});
        spec.setApplicationsToPromote(new String[]{cdPipelineData.get("applicationName")});

        ObjectMeta metadata = new ObjectMeta();
        metadata.setName(cdPipelineData.get("name"));

        return new CDPipeline(spec, metadata);
    }

    private void createCDPipeline(CDPipeline cdPipeline) {
        factory.createCustomResource(CDPipeline.class, cdPipeline);
        factory.verifyCustomResource(CDPipeline.class, cdPipeline.getMetadata().getName(), CDPipeline::isActive);
    }
}
