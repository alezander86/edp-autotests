package edp.core.runner;


import cucumber.runtime.BackendModuleBackendSupplier;
import cucumber.runtime.ClassFinder;
import cucumber.runtime.Env;
import cucumber.runtime.Runtime;
import cucumber.runtime.io.CustomClassFinder;
import cucumber.runtime.io.CustomMultiLoader;
import cucumber.runtime.io.ResourceLoader;
import io.cucumber.core.options.CommandlineOptionsParser;
import io.cucumber.core.options.EnvironmentOptionsParser;
import io.cucumber.core.options.RuntimeOptions;

public class CustomRunner {
    public static void main(String[] argv) {
        byte exitStatus = run(argv, Thread.currentThread().getContextClassLoader());
        System.exit(exitStatus);
    }

    public static byte run(String[] argv, ClassLoader classLoader) {
        ResourceLoader resourceLoader = new CustomMultiLoader();

         ClassFinder classFinder = new CustomClassFinder(resourceLoader, classLoader);

        RuntimeOptions runtimeOptions = new CommandlineOptionsParser(resourceLoader)
            .parse(argv)
            .addDefaultFormatterIfNotPresent()
            .addDefaultSummaryPrinterIfNotPresent()
            .build();

        new EnvironmentOptionsParser(resourceLoader)
            .parse(Env.INSTANCE)
            .build(runtimeOptions);

        final Runtime runtime = Runtime.builder()
            .withRuntimeOptions(runtimeOptions)
            .withClassLoader(classLoader)
            .withClassFinder(classFinder)
            .withResourceLoader(resourceLoader)
            .withBackendSupplier(new BackendModuleBackendSupplier(resourceLoader, classFinder, runtimeOptions))
            .build();

        runtime.run();
        return runtime.exitStatus();
    }

}

