package edp.core.crd.codebase.codebase;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CodebaseStatus {

    private String value;

}
