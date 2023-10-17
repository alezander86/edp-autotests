package edp.steps;

import static edp.stepdefs.http.GitLabDefinitionSteps.GITLAB_NAMESPACE_PATH;
import static edp.stepdefs.http.GithubDefinitionSteps.GITHUB_NAMESPACE_PATH;
import static io.vavr.API.$;
import static io.vavr.API.Case;
import static io.vavr.API.Match;

import edp.core.config.TestsConfig;
import edp.core.crd.codebase.codebase.Codebase;
import edp.core.crd.codebase.codebase_branch.CodebaseBranch;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.pageobject.pages.HeadlampMarketplacePage;
import edp.pageobject.popups.CreateApplicationFromTemplatePopup;
import java.util.Map;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
public class HeadlampMarketplacePageSteps {

    @Autowired
    private HeadlampMarketplacePage headlampMarketplacePage;
    @Autowired
    private CreateApplicationFromTemplatePopup createApplicationFromTemplatePopup;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private KubernetesClientFactory factory;

    public void createCodebaseFromTemplate(Map<String, String> codebaseData) {
        if("table".equals(codebaseData.get("viewMode"))) {
            headlampMarketplacePage.clickOnTableViewModeButton();
            headlampMarketplacePage.searchTemplateByName(codebaseData.get("templateName"));
            headlampMarketplacePage.clickOnTemplateNameInTheFirstRow();
        } else {
            headlampMarketplacePage.clickOnCubeViewModeButton();
            headlampMarketplacePage.searchTemplateByName(codebaseData.get("templateName"));
            headlampMarketplacePage.clickOnTemplateByNameOnTheFirstCube(codebaseData.get("templateName"));
        }
        headlampMarketplacePage.clickOnCreateFromTemplateButton();
        createApplicationFromTemplatePopup.createApplicationFromTemplatePopupIsOpened(codebaseData.get("templateName"));
        createApplicationFromTemplatePopup.enterComponentName(codebaseData.get("applicationName"));
        createApplicationFromTemplatePopup.enterDescription("Marketplace template");
        createApplicationFromTemplatePopup.selectGitServerType(testsConfig.getGitProvider());
        createApplicationFromTemplatePopup.enterGitServerPath(
                getGitServerPathBAseOnGitProvider(testsConfig.getGitProvider(), codebaseData.get("applicationName")));
        createApplicationFromTemplatePopup.selectVersioningType(codebaseData.get("versioningType"));
        if ("edp".equals(codebaseData.get("versioningType"))) {
            createApplicationFromTemplatePopup.enterStartFromVersion(codebaseData.get("startFromVersion"));
            createApplicationFromTemplatePopup.enterStartFromSnapshot(codebaseData.get("startFromSnapshot"));
        }
        createApplicationFromTemplatePopup.clickOnApplyButton();
        createApplicationFromTemplatePopup.createApplicationFromTemplatePopupIsClosed(codebaseData.get("templateName"));

        factory.verifyCustomResource(Codebase.class, codebaseData.get("applicationName"), Codebase::isActive);
        factory.verifyCustomResource(CodebaseBranch.class,
                codebaseData.get("applicationName").concat("-").concat("main"), CodebaseBranch::isActive);
    }

    private String getGitServerPathBAseOnGitProvider(String gitProvider, String applicationName) {
        return Match(gitProvider).of(
                Case($("gerrit"), applicationName),
                Case($("github"), GITHUB_NAMESPACE_PATH.concat(testsConfig.getProjectName(applicationName))),
                Case($("gitlab"), GITLAB_NAMESPACE_PATH.concat("/")
                        .concat(testsConfig.getProjectName(applicationName)))
        );
    }

}
