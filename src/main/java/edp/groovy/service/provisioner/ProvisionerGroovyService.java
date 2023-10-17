package edp.groovy.service.provisioner;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import static edp.groovy.service.IBaseGroovyScriptReader.scriptReader;
import static edp.groovy.service.IBaseGroovyScriptReader.configReader;


@Service
@Lazy
public class ProvisionerGroovyService {

    public String getProvisionerScript() {
        return scriptReader("provisioner/provisionerCode.groovy");
    }

    public String getGithubProvisionerConfig() {
        return configReader("/githubProvisionerConfig.json");
    }

    public String getGitlabProvisionerConfig() {
        return configReader("/gitlabProvisionerConfig.json");
    }

    public String getJenkinsWorkersConfig() {
        return configReader("/jenkinsWorkersConfig.json");
    }

    public String getGithubProvisionerScript() {
        return scriptReader("provisioner/githubProvisionerCode.groovy");
    }

}
