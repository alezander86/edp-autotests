package edp.utils.consts;

public final class Cucumber {

    public static final String[] COMMON_CUCUMBER_OPTIONS = new String[]{
            "-p", "timeline:build/cucumber-parallel-report",
            "-p", "html:build/cucumber-report/smoketest",
            "-p", "io.qameta.allure.cucumber4jvm.AllureCucumber4Jvm",
            "-g", "edp.stepdefs",
            "-g", "edp.types",
            "-g", "edp.cucumber",
            "classpath:features"
    };

}
