package edp.stepdefs;

import edp.steps.HeadlampMarketplacePageSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.When;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;

public class HeadlampMarketplacePageDefinitionSteps {

    @Autowired
    private HeadlampMarketplacePageSteps headlampMarketplacePageSteps;

    @When("User creates codebase from {string} template with {word} versioning type on {word} view mode")
    public void createCodebaseFromTemplate(String templateName, String versioningType, String mode, DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("templateName", templateName);
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("viewMode", mode);
        headlampMarketplacePageSteps.createCodebaseFromTemplate(codebaseData);
    }

}
