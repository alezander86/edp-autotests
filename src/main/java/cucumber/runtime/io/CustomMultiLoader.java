package cucumber.runtime.io;


import edp.core.exceptions.TAFRuntimeException;
import io.vavr.control.Try;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

public class CustomMultiLoader implements ResourceLoader {

    public static final String CLASSPATH_SCHEME = "classpath*:";
    public static final String CLASSPATH_SCHEME_TO_REPLACE = "classpath:";
    private final FileResourceLoader fs;

    public CustomMultiLoader() {
        fs = new FileResourceLoader();
    }

    @Override
    public Iterable<Resource> resources(URI path, String suffix) {
        if (isClasspathPath(path.toString())) {
            final PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
            final String locationPattern = path.toString().replace(CLASSPATH_SCHEME_TO_REPLACE, CLASSPATH_SCHEME) + "/**/*" + suffix;
            org.springframework.core.io.Resource[] resources = Try
                .of(() -> resolver.getResources(locationPattern))
                .getOrElseThrow(throwable ->
                                    new TAFRuntimeException("Unable to get resource by following path - " + path.toString() + " and with following suffix - " + suffix, throwable)
                );
            return convertToCucumberIterator(resources);
        } else {
            return fs.resources(path, suffix);
        }
    }

    private Iterable<Resource> convertToCucumberIterator(org.springframework.core.io.Resource[] resources) {
        List<Resource> results = new ArrayList<>();
        for (org.springframework.core.io.Resource resource : resources) {
            results.add(new ResourceAdapter(resource));
        }
        return results;
    }

    private boolean isClasspathPath(String path) {
        if (path.startsWith(CLASSPATH_SCHEME_TO_REPLACE)) {
            path = path.replace(CLASSPATH_SCHEME_TO_REPLACE, CLASSPATH_SCHEME);
        }
        return path.startsWith(CLASSPATH_SCHEME);
    }

}
