package edp.core.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Configuration;

@Getter
@Configuration
@EnableAutoConfiguration
public class TestsConfig {

    @Value("${namespace}")
    private String namespace;
    @Value("${secret.name}")
    private String secretName;
    @Value("${secret.namespace}")
    private String secretNamespace;
    @Value("${cluster}")
    private String cluster;
    @Value("${ci.tool}")
    private String ciTool;
    @Value("${git.provider}")
    private String gitProvider;
    @Value("${tagz}")
    private String tags;
    @Value("${browser.type}")
    private String browserType;
    @Value("${browser.name}")
    private String browserName;
    @Value("${browser.version}")
    private String browserVersion;
    @Value("${moon.url}")
    private String moonUrl;

    public String getSecretName() {
        return secretName.isEmpty() ? "autotests" : secretName;
    }

    public String getSecretNamespace() {
        return secretNamespace.isEmpty() ? "security" : secretNamespace;
    }

    public String getGitProvider() {
        return gitProvider.isEmpty() ? "gerrit" : gitProvider;
    }

    public String getBrowserType() {
        return browserType.isEmpty() ? "local" : browserType;
    }

    public String getBrowserName() {
        return browserName.isEmpty() ? "chrome" : browserName;
    }

    public String getBrowserVersion() {
        return browserVersion.isEmpty() ? "114.0.5735.133-5" : browserVersion;
    }

    public String getCluster() {
        return cluster.isEmpty() ? "sandbox" : cluster;
    }

    public String getProjectName(String applicationName) {
        return namespace.concat("-").concat(applicationName);
    }
}
