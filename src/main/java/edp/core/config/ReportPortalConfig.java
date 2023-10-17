package edp.core.config;

import com.fasterxml.jackson.core.JsonProcessingException;
import edp.core.model.autotestintegration.Secrets;
import edp.core.service.kubernetes.SecretsProvider;
import io.fabric8.kubernetes.api.model.Secret;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;

import static edp.utils.strings.StringsHelper.decode;

@Getter
@Configuration
@EnableAutoConfiguration
public class ReportPortalConfig {
    @Autowired
    private SecretsProvider secretsProvider;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;

    @PostConstruct
    public void init() throws JsonProcessingException {
        Secret secret = secretsProvider.getSecret(testsConfig.getSecretName());
        Secrets secrets = Secrets.getSecrets(secret);
        System.setProperty("rp.endpoint", secrets.getReportPortal().getEndpoint());
        System.setProperty("rp.project", decode(secrets.getReportPortal().getProject()));
        System.setProperty("rp.uuid", decode(secrets.getReportPortal().getUuid()));

        System.setProperty("rp.launch", String.format("%s %s %s",
                testsConfig.getTags(), testsConfig.getNamespace(), testsConfig.getCluster()));
        String urls = String.format("[headlamp](%s) ", edpComponentsConfig.getHeadlampUrl());

        if (edpComponentsConfig.getJenkinsUrl() != null) {
            urls = urls.concat(String.format(" [jenkins](%s)", edpComponentsConfig.getJenkinsUrl()));
        }

        if (edpComponentsConfig.getTektonUrl() != null) {
            urls = urls.concat(String.format(" [tekton](%s)", edpComponentsConfig.getTektonUrl()));
        }

        if (edpComponentsConfig.getGerritUrl() != null) {
            urls = urls.concat(String.format(" [gerrit](%s)", edpComponentsConfig.getGerritUrl()));
        }

        System.setProperty("rp.description", urls);
    }
}
