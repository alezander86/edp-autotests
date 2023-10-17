package edp.core.service.kubernetes;

import edp.core.config.TestsConfig;
import io.fabric8.kubernetes.api.model.Secret;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class SecretsProvider {
    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private TestsConfig testsConfig;

    public Secret getSecret(String name) {
        String namespace = testsConfig.getSecretNamespace();
        log.info(String.format("getting %s secret in %s namespace from cluster", name, namespace));

        return factory.getSourceClient()
                .secrets()
                .inNamespace(namespace)
                .withName(name)
                .get();
    }

}
