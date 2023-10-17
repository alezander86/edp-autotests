package edp.core.crd;

import lombok.Data;

@Data
public class KeycloakRealmRoleBatchStatus {

    private Integer failureCount;

    private String value;

}
