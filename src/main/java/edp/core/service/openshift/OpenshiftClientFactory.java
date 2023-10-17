package edp.core.service.openshift;

import com.fasterxml.jackson.core.JsonProcessingException;
import edp.core.config.TestsConfig;
import edp.core.model.autotestintegration.Cluster;
import edp.core.service.kubernetes.SecretsProvider;
import io.fabric8.kubernetes.api.model.Secret;
import io.fabric8.kubernetes.client.Config;
import io.fabric8.kubernetes.client.ConfigBuilder;
import io.fabric8.openshift.client.DefaultOpenShiftClient;
import javax.annotation.PostConstruct;
import lombok.Getter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Getter
@Log4j
@Service
public class OpenshiftClientFactory {

    private DefaultOpenShiftClient openshiftTargetClient;

    @Autowired
    private SecretsProvider secretsProvider;
    @Autowired
    private TestsConfig testsConfig;

    @PostConstruct
    public void init() throws JsonProcessingException {
        if("okd".equals(testsConfig.getCluster())) {
            log.info("init openshift client by agents' sa");
            openshiftTargetClient = initOpenshiftClient();
        }
    }

    private DefaultOpenShiftClient initOpenshiftClient() throws JsonProcessingException {
        Secret secret = secretsProvider.getSecret(testsConfig.getSecretName());
        Cluster cluster = Cluster.getCluster(secret, testsConfig.getCluster());

        log.info(String.format("init kubernetes client for {%s} server", cluster.getServer()));
        Config kubeConfig = new ConfigBuilder()
                .withMasterUrl(cluster.getServer())
                .withTrustCerts(true)
                .withOauthToken(cluster.getBearerToken().replaceAll("(\\r|\\n)", ""))
                .withNamespace(testsConfig.getNamespace())
                .build();
        return new DefaultOpenShiftClient(kubeConfig);
    }
}
