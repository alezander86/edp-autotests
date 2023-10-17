package cucumber.runtime.io;


import edp.core.exceptions.TAFRuntimeException;
import io.vavr.control.Try;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;

public class ResourceAdapter implements Resource {

    org.springframework.core.io.Resource springResource;

    public ResourceAdapter(org.springframework.core.io.Resource springResource) {
        this.springResource = springResource;
    }

    @Override
    public URI getPath() {
        return Try
            .of(() -> springResource.getURI())
            .getOrElseThrow(exception -> new TAFRuntimeException("Unable to get URI from spring resource - " + springResource.getDescription()));
    }

    @Override
    public InputStream getInputStream() throws IOException {
        return springResource.getInputStream();
    }

}
