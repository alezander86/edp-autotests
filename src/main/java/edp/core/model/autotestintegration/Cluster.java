package edp.core.model.autotestintegration;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.fabric8.kubernetes.api.model.Secret;
import lombok.Getter;

import static edp.utils.consts.AutotestIntegration.CLUSTER_PROPERTY_NAME;
import static edp.utils.consts.AutotestIntegration.CONFIG_PROPERTY_NAME;
import static edp.utils.strings.StringsHelper.decode;

@Getter
@JsonIgnoreProperties(ignoreUnknown = true)
public class Cluster {
    public String server;
    public String bearerToken;

    public static Cluster getCluster(Secret secret, String clusterName) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        String config = secret.getData().get(CONFIG_PROPERTY_NAME);
        JsonNode configJson = mapper.readTree(decode(config));
        if (clusterName.isEmpty())
            return mapper.readValue(configJson.get(CLUSTER_PROPERTY_NAME).toString(), Cluster.class);
        else
            return mapper.readValue(configJson.get(CLUSTER_PROPERTY_NAME).get(clusterName).toString(), Cluster.class);

    }
}

