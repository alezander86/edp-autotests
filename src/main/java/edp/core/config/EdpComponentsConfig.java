package edp.core.config;

import com.fasterxml.jackson.core.JsonProcessingException;
import edp.core.crd.EDPComponent;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.core.service.openshift.RoutesProvider;
import lombok.Data;
import lombok.ToString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import java.util.List;

import static edp.utils.CustomResourceUtils.getCustomResourceByName;
import static edp.utils.CustomResourceUtils.getIngressByName;
import static edp.utils.CustomResourceUtils.isCurrentEnvShared;

@Data
@ComponentScan(basePackages = {"edp.*"})
@Configuration
@ConfigurationPropertiesScan(basePackages = "edp.*")
@EnableAutoConfiguration
@ToString
public class EdpComponentsConfig {

    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private RoutesProvider routesProvider;

    @Value("${namespace}")
    private String namespace;

    private String headlampUrl;
    private String keycloakUrl;
    private String jenkinsUrl;
    private String tektonUrl;
    private String gerritUrl;
    private Boolean isSharedEnv;

    private String privatSshKey;
    private String gitlabSshKeyYaml;
    private String gitlabGitServer;

    @PostConstruct
    public void init() throws JsonProcessingException {
        this.headlampUrl = getHeadlampURLBaseOnCluster();
        List<EDPComponent> edpComponentList = factory.getCustomResourcesList(EDPComponent.class);
        this.keycloakUrl = getCustomResourceByName(edpComponentList, "main-keycloak")
                .getSpec()
                .getUrl();
        if (testsConfig.getCiTool().equalsIgnoreCase("tekton")) {
            this.tektonUrl = getCustomResourceByName(edpComponentList, "tekton")
                    .getSpec()
                    .getUrl();
        }
        if (testsConfig.getCiTool().equalsIgnoreCase("jenkins")) {
            this.jenkinsUrl = getCustomResourceByName(edpComponentList, "jenkins")
                    .getSpec()
                    .getUrl();
        }
        if (testsConfig.getGitProvider().equalsIgnoreCase("gerrit")) {
            this.gerritUrl = getCustomResourceByName(edpComponentList, "gerrit")
                    .getSpec()
                    .getUrl();
        }
        this.isSharedEnv = isCurrentEnvShared(edpComponentList, "sonar");
    }

    private String getHeadlampURLBaseOnCluster() {
        if("sandbox".equals(testsConfig.getCluster())) {
            return "https://".concat(getIngressByName(factory.getIngressList(), "edp-headlamp")
                    .getSpec()
                    .getRules().get(0)
                    .getHost());
        } else {
            return "https://".concat(routesProvider.getRouteHostByName("edp-headlamp"));
        }
    }
}
