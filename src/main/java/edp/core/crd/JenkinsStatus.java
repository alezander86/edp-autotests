package edp.core.crd;

import lombok.Data;

@Data
public class JenkinsStatus {

   private String adminSecretName;

   private Boolean available;

   private JobProvisions[] jobProvisions;

   private String lastTimeUpdated;

   private Slaves[] slaves;

   private String status;

}

@Data
class JobProvisions{
    String name;
    String scope;
}
@Data
class Slaves{
    String name;
}
