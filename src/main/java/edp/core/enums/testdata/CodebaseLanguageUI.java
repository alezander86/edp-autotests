package edp.core.enums.testdata;

import lombok.Getter;

public enum CodebaseLanguageUI {
    // Infrastructure codebase
    HCL_TERRAFORM_AWS_INF("HCL", "AWS", "Terraform", "Infrastructure"),

    // Application codebase
    JAVA_GRADLE_JAVA8_APP("Java", "Java 8", "Gradle", "Application"),
    JAVA_MAVEN_JAVA8_APP("Java", "Java 8", "Maven", "Application"),
    JAVA_GRADLE_JAVA11_APP("Java", "Java 11", "Gradle", "Application"),
    JAVA_MAVEN_JAVA11_APP("Java", "Java 11", "Maven", "Application"),
    JAVA_GRADLE_JAVA17_APP("Java", "Java 17", "Gradle", "Application"),
    JAVA_MAVEN_JAVA17_APP("Java", "Java 17", "Maven", "Application"),

    JS_NPM_REACT_APP("JavaScript", "React", "NPM", "Application"),
    JS_NPM_VUE_APP("JavaScript", "Vue", "NPM", "Application"),
    JS_NPM_ANGULAR_APP("JavaScript", "Angular", "NPM", "Application"),
    JS_NPM_NEXT_APP("JavaScript", "Next.js", "NPM", "Application"),
    JS_NPM_EXPRESS_APP("JavaScript", "Express", "NPM", "Application"),
    JS_NPM_ANTORA_APP("JavaScript", "Antora", "NPM", "Application"),

    PYTHON_PYTHON_PYTHON_3_8_APP("Python", "Python 3.8", "Python", "Application"),
    PYTHON_PYTHON_FASTAPI_APP("Python", "FastAPI", "Python", "Application"),
    PYTHON_PYTHON_FLASK_APP("Python", "Flask", "Python", "Application"),

    GO_GO_BEEGO_APP("Go", "Beego", "Go", "Application"),
    GO_GO_GIN_APP("Go", "Gin", "Go", "Application"),
    GO_GO_OPERATOR_SDK_APP("Go", "Operator SDK", "Go", "Application"),

    DOTNET_DOTNET_DOTNET_3_1_APP("C#", ".NET 3.1", ".NET", "Application"),
    DOTNET_DOTNET_DOTNET_6_0_APP("C#", ".NET 6.0", ".NET", "Application"),

    HELM_HELM_HELM_APP("Helm", "Helm", "Helm", "Application"),

    // Library codebase
    JAVA_GRADLE_JAVA8_LIB("Java", "Java 8", "Gradle", "Library"),
    JAVA_MAVEN_JAVA8_LIB("Java", "Java 8", "Maven", "Library"),
    JAVA_GRADLE_JAVA11_LIB("Java", "Java 11", "Gradle", "Library"),
    JAVA_MAVEN_JAVA11_LIB("Java", "Java 11", "Maven", "Library"),
    JAVA_GRADLE_JAVA17_LIB("Java", "Java 17", "Gradle", "Library"),
    JAVA_MAVEN_JAVA17_LIB("Java", "Java 17", "Maven", "Library"),

    JS_NPM_REACT_LIB("JavaScript", "React", "NPM", "Library"),
    JS_NPM_VUE_LIB("JavaScript", "Vue", "NPM", "Library"),
    JS_NPM_ANGULAR_LIB("JavaScript", "Angular", "NPM", "Library"),
    JS_NPM_EXPRESS_LIB("JavaScript", "Express", "NPM", "Library"),

    PYTHON_PYTHON_PYTHON_3_8_LIB("Python", "Python 3.8", "Python", "Library"),

    PIPELINE_CODENARC_CODENARC_LIB("Groovy-pipeline", "Codenarc", "Codenarc", "Library"),

    HCL_TERRAFORM_TERRAFORM_LIB("HCL", "Terraform", "Terraform", "Library"),

    REGO_OPA_OPA_LIB("Rego", "OPA", "OPA", "Library"),

    CONTAINER_KANIKO_DOCKER_LIB("Container", "Docker", "Kaniko", "Library"),

    HELM_HELM_CHARTS_LIB("Helm", "Charts", "Helm", "Library"),
    HELM_HELM_PIPELINE_LIB("Helm", "Pipeline", "Helm", "Library"),

    DOTNET_DOTNET_DOTNET_3_1_LIB("C#", ".NET 3.1", ".NET", "Library"),
    DOTNET_DOTNET_DOTNET_6_0_LIB("C#", ".NET 6.0", ".NET", "Library"),

    // Autotest codebase
    JAVA_GRADLE_JAVA8_AUTO("Java", "Java 8", "Gradle", "Autotest"),
    JAVA_MAVEN_JAVA8_AUTO("Java", "Java 8", "Maven", "Autotest"),
    JAVA_GRADLE_JAVA11_AUTO("Java", "Java 11", "Gradle", "Autotest"),
    JAVA_MAVEN_JAVA11_AUTO("Java", "Java 11", "Maven", "Autotest"),
    JAVA_GRADLE_JAVA17_AUTO("Java", "Java 17", "Gradle", "Autotest"),
    JAVA_MAVEN_JAVA17_AUTO("Java", "Java 17", "Maven", "Autotest");

    @Getter
    private final String language;
    @Getter
    private final String framework;
    @Getter
    private final String buildTool;
    @Getter
    private final String codebaseType;

    CodebaseLanguageUI(String language, String framework, String buildTool, String codebaseType) {
        this.language = language;
        this.framework = framework;
        this.buildTool = buildTool;
        this.codebaseType = codebaseType;
    }
}
