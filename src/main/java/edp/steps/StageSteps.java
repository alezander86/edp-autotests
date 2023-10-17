package edp.steps;

import static edp.utils.wait.WaitingUtils.pollingTektonPipelineRun;

import edp.core.config.EdpComponentsConfig;
import edp.core.crd.codebase.stage.Stage;
import edp.core.crd.codebase.stage.StageSpec;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import lombok.extern.log4j.Log4j;
import org.junit.jupiter.api.Assertions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class StageSteps {

    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;

    public void createStage(Map<String, String> stageParameters) {
        createStage(getStageFromMap(stageParameters));
    }

    public void checkAnnotationInCdStage(String annotation, String cdPipelineStageName) throws InterruptedException {
        pollingTektonPipelineRun().ignoreExceptionsInstanceOf(NullPointerException.class)
                .untilAsserted(() -> {
                    Assertions.assertNotNull(factory.getTargetClient().customResources(Stage.class)
                            .inNamespace(edpComponentsConfig.getNamespace())
                            .withName(cdPipelineStageName).get().getMetadata().getAnnotations());
                });

        factory.getTargetClient().customResources(Stage.class).inNamespace(edpComponentsConfig.getNamespace())
                .withName(cdPipelineStageName)
                .waitUntilCondition(stage -> stage.getMetadata().getAnnotations().containsValue(annotation), 5,
                        TimeUnit.MINUTES);
        log.info("CD pipeline stage " + cdPipelineStageName + " has annotation " + annotation);
    }

    private Stage getStageFromMap(Map<String, String> stageData) {
        StageSpec spec = new StageSpec();
        spec.setName(stageData.get("stageName"));
        spec.setCdPipeline(stageData.get("cdPipelineName"));
        spec.setOrder(0);
        spec.setTriggerType(stageData.get("triggerType"));
        spec.setJobProvisioning(stageData.get("jobProvisioning"));
        spec.setSourceType(stageData.get("source"));
        spec.setQualityGateManual(stageData.get("autotestName"), stageData.get("branchName"),
                stageData.get("qualityGateType"), stageData.get("stepName"));
        spec.setDescription("Development Environment");

        ObjectMeta metadata = new ObjectMeta();
        metadata.setName(stageData.get("cdPipelineName").concat("-").concat(stageData.get("stageName")));
        metadata.setNamespace(edpComponentsConfig.getNamespace());

        return new Stage(spec, metadata);
    }

    private void createStage(Stage stage) {
        factory.createCustomResource(Stage.class, stage);
        factory.verifyCustomResource(Stage.class, stage.getMetadata().getName(), Stage::isActive);
    }

}
