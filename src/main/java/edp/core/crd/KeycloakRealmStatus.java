package edp.core.crd;

import lombok.Data;

@Data
public class KeycloakRealmStatus {

    private Boolean available;

    private Integer failureCount;

    private String value;

}
