package edp.core.enums.testdata;

import edp.utils.consts.GithubProjectNames;
import lombok.Getter;

public enum CodeLanguage {

    DOCKER_LIBRARY("container", "docker", "kaniko", "kaniko-docker", GithubProjectNames.CONTAINER_KANIKO_DOCKER_LIB, "131587", "library", CodebaseLanguageUI.CONTAINER_KANIKO_DOCKER_LIB),
    DOTNET_3_1_APPLICATION("csharp", "dotnet-3.1", "dotnet", "dotnet-dotnet-3.1", GithubProjectNames.DOTNET_DOTNET_DOTNET_3_1_APP, "95986", "application", CodebaseLanguageUI.DOTNET_DOTNET_DOTNET_3_1_APP),
    DOTNET_3_1_LIBRARY("csharp", "dotnet-3.1", "dotnet", "dotnet-dotnet-3.1", GithubProjectNames.DOTNET_DOTNET_DOTNET_3_1_LIB, "171433", "library", CodebaseLanguageUI.DOTNET_DOTNET_DOTNET_3_1_LIB),
    DOTNET_6_0_APPLICATION("csharp", "dotnet-6.0", "dotnet", "", GithubProjectNames.DOTNET_DOTNET_DOTNET_6_0_APP, "167524", "application", CodebaseLanguageUI.DOTNET_DOTNET_DOTNET_6_0_APP),
    DOTNET_6_0_LIBRARY("csharp", "dotnet-6.0", "dotnet", "", GithubProjectNames.DOTNET_DOTNET_DOTNET_6_0_LIB, "171434", "library", CodebaseLanguageUI.DOTNET_DOTNET_DOTNET_6_0_LIB),
    BEEGO_APPLICATION("go", "beego", "go", "go", GithubProjectNames.GO_GO_BEEGO_APP, "95971", "application", CodebaseLanguageUI.GO_GO_BEEGO_APP),
    OPERATOR_SDK_APPLICATION("go", "operator-sdk", "go", "go", GithubProjectNames.GO_GO_OPERATOR_SDK_APP, "95972", "application", CodebaseLanguageUI.GO_GO_OPERATOR_SDK_APP),
    GO_GO_GIN_APPLICATION("go", "gin", "go", "go", GithubProjectNames.GO_GO_GIN_APP, "173834", "application", CodebaseLanguageUI.GO_GO_GIN_APP),
    CODENARC_LIBRARY("groovy-pipeline", "codenarc", "codenarc", "codenarc", GithubProjectNames.GROOVY_PIPELINE_CODENARC_CODENARC_LIB, "104963", "library", CodebaseLanguageUI.PIPELINE_CODENARC_CODENARC_LIB),
    PIPELINE_LIBRARY("helm", "pipeline", "helm", "", GithubProjectNames.HELM_HELM_PIPELINE_LIB, "175952", "library", CodebaseLanguageUI.HELM_HELM_PIPELINE_LIB),
    JAVA8_MAVEN_APPLICATION("java", "java8", "maven", "maven-java8", GithubProjectNames.JAVA_MAVEN_JAVA8_APP, "95966", "application", CodebaseLanguageUI.JAVA_MAVEN_JAVA8_APP),
    JAVA8_MAVEN_LIBRARY("java", "java8", "maven", "maven-java8", GithubProjectNames.JAVA_MAVEN_JAVA8_LIB, "171435", "library", CodebaseLanguageUI.JAVA_MAVEN_JAVA8_LIB),
    JAVA8_MAVEN_AUTOTEST("java", "java8", "maven", "maven-java8", GithubProjectNames.JAVA_MAVEN_AUTO, "181008", "autotest", CodebaseLanguageUI.JAVA_MAVEN_JAVA8_AUTO),
    JAVA8_GRADLE_APPLICATION("java", "java8", "gradle", "gradle-java8", GithubProjectNames.JAVA_GRADLE_JAVA8_APP, "95967", "application", CodebaseLanguageUI.JAVA_GRADLE_JAVA8_APP),
    JAVA8_GRADLE_LIBRARY("java", "java8", "gradle", "gradle-java8", GithubProjectNames.JAVA_GRADLE_JAVA8_LIB, "171436", "library", CodebaseLanguageUI.JAVA_GRADLE_JAVA8_LIB),
    JAVA8_GRADLE_AUTOTEST("java", "java8", "gradle", "gradle-java8", GithubProjectNames.JAVA_GRADLE_AUTO, "99718", "autotest", CodebaseLanguageUI.JAVA_GRADLE_JAVA8_AUTO),
    JAVA11_MAVEN_APPLICATION("java", "java11", "maven", "maven-java11", GithubProjectNames.JAVA_MAVEN_JAVA11_APP, "95968", "application", CodebaseLanguageUI.JAVA_MAVEN_JAVA11_APP),
    JAVA11_MAVEN_LIBRARY("java", "java11", "maven", "maven-java11", GithubProjectNames.JAVA_MAVEN_JAVA11_LIB, "171437", "library", CodebaseLanguageUI.JAVA_MAVEN_JAVA11_LIB),
    JAVA11_MAVEN_AUTOTEST("java", "java11", "maven", "", GithubProjectNames.JAVA_MAVEN_AUTO, "181008", "autotest", CodebaseLanguageUI.JAVA_MAVEN_JAVA11_AUTO),
    JAVA11_GRADLE_APPLICATION("java", "java11", "gradle", "gradle-java11", GithubProjectNames.JAVA_GRADLE_JAVA11_APP, "95969", "application", CodebaseLanguageUI.JAVA_GRADLE_JAVA11_APP),
    JAVA11_GRADLE_LIBRARY("java", "java11", "gradle", "gradle-java11", GithubProjectNames.JAVA_GRADLE_JAVA11_LIB, "171438", "library", CodebaseLanguageUI.JAVA_GRADLE_JAVA11_LIB),
    JAVA11_GRADLE_AUTOTEST("java", "java11", "gradle", "", GithubProjectNames.JAVA_GRADLE_AUTO, "99718", "autotest", CodebaseLanguageUI.JAVA_GRADLE_JAVA11_AUTO),
    JAVA17_MAVEN_APPLICATION("java", "java17", "maven", "", GithubProjectNames.JAVA_MAVEN_JAVA17_APP, "165986", "application", CodebaseLanguageUI.JAVA_MAVEN_JAVA17_APP),
    JAVA17_MAVEN_LIBRARY("java", "java17", "maven", "", GithubProjectNames.JAVA_MAVEN_JAVA17_LIB, "171439", "library", CodebaseLanguageUI.JAVA_MAVEN_JAVA17_LIB),
    JAVA17_MAVEN_AUTOTEST("java", "java17", "maven", "", GithubProjectNames.JAVA_MAVEN_AUTO, "181008", "autotest", CodebaseLanguageUI.JAVA_MAVEN_JAVA17_AUTO),
    JAVA17_GRADLE_APPLICATION("java", "java17", "gradle", "", GithubProjectNames.JAVA_GRADLE_JAVA17_APP, "165987", "application", CodebaseLanguageUI.JAVA_GRADLE_JAVA17_APP),
    JAVA17_GRADLE_LIBRARY("java", "java17", "gradle", "", GithubProjectNames.JAVA_GRADLE_JAVA17_LIB, "171440", "library", CodebaseLanguageUI.JAVA_GRADLE_JAVA17_LIB),
    JAVA17_GRADLE_AUTOTEST("java", "java17", "gradle", "", GithubProjectNames.JAVA_GRADLE_AUTO, "99718", "autotest", CodebaseLanguageUI.JAVA_GRADLE_JAVA17_AUTO),
    JAVA8_MULTIMODULE_APPLICATION("java", "java8-multimodule", "maven", "maven-java8", GithubProjectNames.JAVA_MAVEN_JAVA8_MULTIMODULE, "95956", "application", CodebaseLanguageUI.JAVA_MAVEN_JAVA8_APP),
    JAVA11_MULTIMODULE_APPLICATION("java", "java11-multimodule", "maven", "maven-java11", GithubProjectNames.JAVA_MAVEN_JAVA11_MULTIMODULE, "95964", "application", CodebaseLanguageUI.JAVA_MAVEN_JAVA11_APP),
    JAVA8_MULTIMODULE_TEKTON("java", "java8", "maven", "", GithubProjectNames.JAVA_MAVEN_JAVA8_MULTIMODULE, "95956", "application", CodebaseLanguageUI.JAVA_MAVEN_JAVA8_APP),
    JAVA11_MULTIMODULE_TEKTON("java", "java11", "maven", "", GithubProjectNames.JAVA_MAVEN_JAVA11_MULTIMODULE, "95964", "application", CodebaseLanguageUI.JAVA_MAVEN_JAVA11_APP),
    JAVA17_MULTIMODULE_TEKTON("java", "java17", "maven", "", GithubProjectNames.JAVA_MAVEN_JAVA17_MULTIMODULE, "173251", "application", CodebaseLanguageUI.JAVA_MAVEN_JAVA17_APP),
    REACT_APPLICATION("javascript", "react", "npm", "npm", GithubProjectNames.JAVASCRIPT_NPM_REACT_APP, "95970", "application", CodebaseLanguageUI.JS_NPM_REACT_APP),
    REACT_LIBRARY("javascript", "react", "npm", "npm", GithubProjectNames.JAVASCRIPT_NPM_REACT_LIB, "171441", "library", CodebaseLanguageUI.JS_NPM_REACT_LIB),
    ANGULAR_APPLICATION("javascript", "angular", "npm", "", GithubProjectNames.JAVASCRIPT_NPM_ANGULAR_APP, "168382", "application", CodebaseLanguageUI.JS_NPM_ANGULAR_APP),
    ANGULAR_LIBRARY("javascript", "angular", "npm", "", GithubProjectNames.JAVASCRIPT_NPM_ANGULAR_LIB, "168385", "library", CodebaseLanguageUI.JS_NPM_ANGULAR_LIB),
    EXPRESS_APPLICATION("javascript", "express", "npm", "", GithubProjectNames.JAVASCRIPT_NPM_EXPRESS_APP, "168383", "application", CodebaseLanguageUI.JS_NPM_EXPRESS_APP),
    EXPRESS_LIBRARY("javascript", "express", "npm", "", GithubProjectNames.JAVASCRIPT_NPM_EXPRESS_LIB, "168386", "library", CodebaseLanguageUI.JS_NPM_EXPRESS_LIB),
    VUE_APPLICATION("javascript", "vue", "npm", "", GithubProjectNames.JAVASCRIPT_NPM_VUE_APP, "168384", "application", CodebaseLanguageUI.JS_NPM_VUE_APP),
    VUE_LIBRARY("javascript", "vue", "npm", "", GithubProjectNames.JAVASCRIPT_NPM_VUE_LIB, "168387", "library", CodebaseLanguageUI.JS_NPM_VUE_LIB),
    PYTHON_3_8_APPLICATION("python", "python-3.8", "python", "python-3.8", GithubProjectNames.PYTHON_PYTHON_PYTHON_3_8_APP, "95977", "application", CodebaseLanguageUI.PYTHON_PYTHON_PYTHON_3_8_APP),
    PYTHON_3_8_LIBRARY("python", "python-3.8", "python", "python-3.8", GithubProjectNames.PYTHON_PYTHON_PYTHON_3_8_LIB, "171442", "library", CodebaseLanguageUI.PYTHON_PYTHON_PYTHON_3_8_LIB),
    PYTHON_FASTAPI_APPLICATION("python", "fastapi", "python", "", GithubProjectNames.PYTHON_PYTHON_FASTAPI_APP, "163815", "application", CodebaseLanguageUI.PYTHON_PYTHON_FASTAPI_APP),
    PYTHON_FLASK_APPLICATION("python", "flask", "python", "", GithubProjectNames.PYTHON_PYTHON_FLASK_APP, "163814", "application", CodebaseLanguageUI.PYTHON_PYTHON_FLASK_APP),
    OPA_LIBRARY("rego", "opa", "opa", "opa", GithubProjectNames.REGO_OPA_OPA_LIB, "102967", "library", CodebaseLanguageUI.REGO_OPA_OPA_LIB),
    HCL_TERRAFORM_LIBRARY("hcl", "terraform", "terraform", "terraform", GithubProjectNames.HCL_TERRAFORM_TERRAFORM_LIB, "179343", "library", CodebaseLanguageUI.HCL_TERRAFORM_TERRAFORM_LIB),
    OTHER_APPLICATION("other", "other", "go", "", GithubProjectNames.GO_GO_BEEGO_APP, "96868", "application", CodebaseLanguageUI.GO_GO_BEEGO_APP),
    HELM_APPLICATION("helm", "helm", "helm", "", GithubProjectNames.HELM_HELM_HELM_APP, "175951", "application", CodebaseLanguageUI.HELM_HELM_HELM_APP),
    CHARTS_LIBRARY("helm", "charts", "helm", "", GithubProjectNames.HELM_HELM_CHARTS_LIB, "177375", "library", CodebaseLanguageUI.HELM_HELM_CHARTS_LIB),
    NEXT_APPLICATION("javascript", "next", "npm", "", GithubProjectNames.JAVASCRIPT_NPM_NEXT_APP, "175152", "application", CodebaseLanguageUI.JS_NPM_NEXT_APP),
    ANTORA_APPLICATION("javascript", "antora", "npm", "", GithubProjectNames.JAVASCRIPT_NPM_ANTORA_APP, "178152", "application", CodebaseLanguageUI.JS_NPM_ANTORA_APP),
    HCL_TERRAFORM_INFRASTRUCTURE("hcl", "aws", "terraform", "", GithubProjectNames.HCL_TERRAFORM_AWS_INF, "179342", "infrastructure", CodebaseLanguageUI.HCL_TERRAFORM_AWS_INF);

    @Getter
    private final String language;
    @Getter
    private final String version;
    @Getter
    private final String buildTool;
    @Getter
    private final String jenkinsSlave;
    @Getter
    private final String githubProjectName;
    @Getter
    private final String gitlabId;
    @Getter
    private final String codebaseType;
    @Getter
    private final CodebaseLanguageUI codebaseLanguageUI;

    CodeLanguage(String language, String version, String buildTool, String jenkinsSlave, String githubProjectName,
                 String gitlabId, String codebaseType, CodebaseLanguageUI codebaseLanguageUI) {
        this.language = language;
        this.version = version;
        this.buildTool = buildTool;
        this.jenkinsSlave = jenkinsSlave;
        this.githubProjectName = githubProjectName;
        this.gitlabId = gitlabId;
        this.codebaseType = codebaseType;
        this.codebaseLanguageUI = codebaseLanguageUI;
    }
}
