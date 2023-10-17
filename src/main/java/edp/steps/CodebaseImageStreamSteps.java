package edp.steps;

import edp.core.annotations.Page;
import edp.core.cache.TestCache;
import edp.core.config.EdpComponentsConfig;
import edp.core.crd.codebase.codebase_image_stream.CodebaseImageStream;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.fabric8.kubernetes.client.KubernetesClient;
import java.util.Arrays;
import lombok.extern.log4j.Log4j;
import org.assertj.core.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import static edp.utils.wait.WaitingUtils.pollingCodebaseImageStream;

@Log4j
@Service
@Lazy
@Page
@Scope("prototype")
public class CodebaseImageStreamSteps {

    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private KubernetesClientFactory factory;

    public void checkCodebaseImageStreamFirstTag(String codebaseImageStream, String imageStreamTag) {
        checkCodebaseImageStreamTag(codebaseImageStream, imageStreamTag, 0);
    }

    public void checkCodebaseImageStreamSecondTag(String codebaseImageStream, String imageStreamTag) {
        checkCodebaseImageStreamTag(codebaseImageStream, imageStreamTag, 1);
    }

    public void checkCodebaseImageStreamPromotedImage(String applicationName, String stageName, String pipelineName) {
        String codebaseImageStreamName = pipelineName.concat("-").concat(stageName).concat("-")
                .concat(applicationName).concat("-").concat("verified");
        checkCodebaseImageStreamPromotedImageTag(codebaseImageStreamName,
                TestCache.get(TestCacheKey.IMAGE_VERSION).toString());
    }

    public Boolean deleteImageStream(String inputDockerStream) {
        KubernetesClient kubernetesClient = factory.getTargetClient();

        log.info(String.format("deleting %s image stream from cluster", inputDockerStream));
        if (Strings.isNullOrEmpty(inputDockerStream)) {
            throw new IllegalArgumentException("the passed 'name' variable cannot be null or empty.");
        }

        return kubernetesClient.customResources(CodebaseImageStream.class)
                .inNamespace(edpComponentsConfig.getNamespace())
                .withName(inputDockerStream).delete();
    }

    private void checkCodebaseImageStreamTag(String codebaseImageStream, String imageStreamTag, int tagIndex) {
        factory.verifyCustomResource(CodebaseImageStream.class,
                codebaseImageStream, s -> s.getSpec().getTags()[tagIndex].getName().equals(imageStreamTag),
                pollingCodebaseImageStream());
    }

    private void checkCodebaseImageStreamPromotedImageTag(String codebaseImageStream, String imageStreamTag) {
        factory.verifyCustomResource(CodebaseImageStream.class, codebaseImageStream,
                s -> Arrays.stream(s.getSpec().getTags()).anyMatch(e -> e.getName().equals(imageStreamTag)),
                pollingCodebaseImageStream());
    }

}
