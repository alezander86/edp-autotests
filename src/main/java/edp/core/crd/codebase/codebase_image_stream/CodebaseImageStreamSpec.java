package edp.core.crd.codebase.codebase_image_stream;

import lombok.Data;

@Data
public class CodebaseImageStreamSpec {

    private String codebase;

    private String imageName;

    private Tags[] tags;


}
