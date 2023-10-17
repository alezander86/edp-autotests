package edp.core.crd;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.annotations.SerializedName;
import lombok.Data;

@Data
public class KeycloakClientSpec {

    private Boolean advancedProtocolMappers;

    private Boolean audRequired;

    private String clientId;

    private Boolean directAccess;

    @JsonProperty("public")
    private Boolean isPublic;

    private String secret;

    private ServiceAccount serviceAccount;

    private String targetRealm;

    private String webUrl;

    private RealmRoles[] realmRoles;

    private String[] clientRoles;

    private ProtocolMappers[] protocolMappers;

}

@Data
class ServiceAccount {
    String attributes;
    String clientRoles;
    Boolean enabled;
    String[] realmRoles;
}
@Data
class RealmRoles {
    String composite;
    String name;
}
@Data
class ProtocolMappers {
    Object config;
    String name;
    String protocol;
    String protocolMapper;
}

