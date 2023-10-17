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
public class KeycloakAuthConfig {

    @Autowired
    private SecretsProvider secretsProvider;
    @Autowired
    private TestsConfig testsConfig;
    private String userName;
    private String firstName;
    private String lastName;
    private String password;
    private String clientId;
    private String acCreatorId;

    @PostConstruct
    public void init() throws JsonProcessingException {
        Secret secret = secretsProvider.getSecret(testsConfig.getSecretName());
        Secrets secrets = Secrets.getSecrets(secret);
        userName = decode(secrets.getKeycloak().getUsername());
        firstName = decode(secrets.getKeycloak().getFirstName());
        lastName = decode(secrets.getKeycloak().getLastName());
        password = decode(secrets.getKeycloak().getPassword());
        clientId = secrets.getKeycloak().getClientId();
        acCreatorId = secrets.getKeycloak().getAcCreatorId();
    }

}
