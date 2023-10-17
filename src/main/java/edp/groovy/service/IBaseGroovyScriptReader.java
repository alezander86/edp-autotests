package edp.groovy.service;

import edp.core.exceptions.TAFRuntimeException;
import io.vavr.control.Try;
import org.apache.commons.io.IOUtils;

import java.nio.charset.StandardCharsets;

import static edp.utils.ClasspathResourceUtils.getResourceFromClasspathAsInputStream;

public interface IBaseGroovyScriptReader {

    static String scriptReader(final String file, String... classpath) {
        String path = classpath.length > 0 ? classpath[0] : "classpath:groovy/";
        return Try.of(() ->
                IOUtils.toString(
                        getResourceFromClasspathAsInputStream(path + file), StandardCharsets.UTF_8
                ).replace("$REPLACER$", "%s")).getOrElseThrow(exception -> {
            throw new TAFRuntimeException(String.format("Failed to read groovy script from file: %s", file), exception);
        });
    }

    static String configReader(final String file, String... classpath) {
        String path = classpath.length > 0 ? classpath[0] : "classpath:jsonConfig/";
        return Try.of(() ->
                IOUtils.toString(
                        getResourceFromClasspathAsInputStream(path + file), StandardCharsets.UTF_8
                ).replace("$REPLACER$", "%s")).getOrElseThrow(exception -> {
            throw new TAFRuntimeException(String.format("Failed to read groovy script from file: %s", file), exception);
        });
    }
}
