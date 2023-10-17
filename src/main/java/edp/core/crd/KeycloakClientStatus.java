package edp.core.crd;

import lombok.Data;

@Data
public class KeycloakClientStatus {

    private String clientId;

    private String clientSecretName;

    private Integer failureCount;

    private String value;

}
