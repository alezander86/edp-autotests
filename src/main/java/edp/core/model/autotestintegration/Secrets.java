package edp.core.model.autotestintegration;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.fabric8.kubernetes.api.model.Secret;
import lombok.Getter;

import static edp.utils.consts.AutotestIntegration.CONFIG_PROPERTY_NAME;
import static edp.utils.consts.AutotestIntegration.SECRETS_PROPERTY_NAME;
import static edp.utils.strings.StringsHelper.decode;

@Getter
@JsonIgnoreProperties(ignoreUnknown = true)
public class Secrets {
    public Gitlab gitlab;
    public Github github;
    public Keycloak keycloak;
    public SecretData secretData;
    public ReportPortal reportPortal;

    @Getter
    public static class Gitlab {
        public String idRsa;
        public String idRsaPub;
        public String password;
        public String token;
        public String username;
    }

    @Getter
    public static class Github {
        public String password;
        public String token;
        public String username;
        public String idRsa;
    }

    @Getter
    public static class Keycloak {
        public String firstName;
        public String lastName;
        public String password;
        public String username;
        public String acCreatorId;
        public String clientId;
    }

    @Getter
    public static class SecretData {
        public String kanikoDockerConfig;
    }

    @Getter
    public static class ReportPortal {
        public String endpoint;
        public String project;
        public String uuid;
    }

    public static Secrets getSecrets(Secret secret) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        String config = secret.getData().get(CONFIG_PROPERTY_NAME);
        JsonNode configJson = mapper.readTree(decode(config));
        return mapper.readValue(configJson.get(SECRETS_PROPERTY_NAME).toString(), Secrets.class);
    }
}
