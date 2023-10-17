package edp.core.crd;

import lombok.Data;

@Data
public class JenkinsServiceAccountSpec {

    String credentials;
    String type;
    String ownerName;

}
