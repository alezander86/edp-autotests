package edp.stepdefs.cubernetes;

import com.codeborne.selenide.Selenide;
import edp.core.crd.argocd.application.Application;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.steps.ApplicationSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;

public class ApplicationDefinitionSteps {

    @Autowired
    private ApplicationSteps applicationSteps;

    @Autowired
    private KubernetesClientFactory factory;

    @And("User deploys application using created image {word} versioning type")
    public void createApplication(String versioningType, DataTable table) {
        Map<String, String> application = new HashMap<>(table.asMap(String.class, String.class));
        application.put("versioningType", versioningType);
        applicationSteps.createApplication(application);
    }

    @When("User deletes {word} application")
    public void deleteStage(String applicationName) {
        factory.deleteCustomResource(Application.class, applicationName);
    }
}
