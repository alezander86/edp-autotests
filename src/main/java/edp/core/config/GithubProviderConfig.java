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
public class GithubProviderConfig {

    @Autowired
    private SecretsProvider secretsProvider;
    @Autowired
    private TestsConfig testsConfig;
    @Getter
    private String username;
    @Getter
    private String password;
    @Getter
    private String token;
    @Getter
    private String idRsa;

    @PostConstruct
    public void init() throws JsonProcessingException {
        Secret secret = secretsProvider.getSecret(testsConfig.getSecretName());
        Secrets secrets = Secrets.getSecrets(secret);
        username = decode(secrets.getGithub().getUsername());
        password = decode(secrets.getGithub().getPassword());
        token = decode(secrets.getGithub().getToken());
        idRsa = decode(secrets.getGithub().getIdRsa());
    }

}
