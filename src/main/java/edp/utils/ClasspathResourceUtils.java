package edp.utils;

import edp.core.exceptions.TAFRuntimeException;
import io.vavr.control.Try;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.io.InputStream;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class ClasspathResourceUtils {

    public static InputStream getResourceFromClasspathAsInputStream(final String resourcePath) {
        Resource resource = getResourceFromClasspath(resourcePath);
        return Try.of(resource::getInputStream).getOrElseThrow(throwable ->
                new TAFRuntimeException("Unable to find resource in classpath by following path " + resourcePath, throwable)
        );
    }

    private static Resource getResourceFromClasspath(final String resourcePath) {
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        return resolver.getResource(resourcePath);
    }
}
