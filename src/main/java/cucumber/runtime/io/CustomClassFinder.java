package cucumber.runtime.io;

import cucumber.runtime.ClassFinder;
import lombok.extern.log4j.Log4j;

import java.net.URI;
import java.util.Collection;
import java.util.HashSet;
import java.util.stream.Collectors;

@Log4j
public class CustomClassFinder implements ClassFinder {

    private static final String CLASS_SUFFIX = ".class";
    private final ResourceLoader resourceLoader;
    private final ClassLoader classLoader;

    public CustomClassFinder(ResourceLoader resourceLoader, ClassLoader classLoader) {
        this.resourceLoader = resourceLoader;
        this.classLoader = classLoader;
    }

    @Override
    public <T> Collection<Class<? extends T>> getDescendants(Class<T> parentType, URI packageName) {
        Collection<Class<? extends T>> result = new HashSet<>();
        for (Resource classResource : resourceLoader.resources(packageName, CLASS_SUFFIX)) {
            String className = getClassName(classResource.getPath().toString());
            try {
                Class<?> clazz = loadClass(className);
                if (clazz != null && !parentType.equals(clazz) && parentType.isAssignableFrom(clazz)) {
                    result.add(clazz.asSubclass(parentType));
                }
            } catch (ClassNotFoundException | NoClassDefFoundError exception) {
                log.warn("Exception caught during loading of class with name - " + className + " and should be ignored", exception);
            }
        }
        if (parentType.getName().contains("Backend")) {
            result = result.stream()
                .filter(cl -> cl.getSimpleName().contains("CustomBackend"))
                .collect(Collectors.toCollection(HashSet::new));
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public <T> Class<? extends T> loadClass(String className) throws ClassNotFoundException {
        return (Class<? extends T>) classLoader.loadClass(className);
    }

    private String getClassName(String path) {
        String classPath;
        if (path.startsWith("jar:")) {
            classPath = path.substring(path.lastIndexOf('!') + 2);
            return classPath.substring(0, classPath.length() - CLASS_SUFFIX.length()).replace('/', '.');
        } else if (path.startsWith("classpath:")) {
            classPath = path.substring(path.lastIndexOf(':') + 1);
            return classPath.substring(0, classPath.length() - CLASS_SUFFIX.length()).replace('/', '.');
        } else {
            classPath = path.substring(path.lastIndexOf("main") + 5);
            return classPath.substring(0, classPath.length() - CLASS_SUFFIX.length()).replace('/', '.');
        }
    }

}
