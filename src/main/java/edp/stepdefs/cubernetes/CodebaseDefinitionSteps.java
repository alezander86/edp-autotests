package edp.stepdefs.cubernetes;

import edp.core.cache.TestCache;
import edp.core.config.TestsConfig;
import edp.core.crd.codebase.codebase.Codebase;
import edp.core.crd.codebase.codebase.CodebaseSpec;
import edp.core.crd.codebase.codebase_branch.CodebaseBranch;
import edp.core.crd.codebase.codebase_branch.CodebaseBranchSpec;
import edp.core.crd.codebase.codebase_branch.CodebaseBranchStatus;
import edp.core.crd.codebase.codebase_image_stream.CodebaseImageStream;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.enums.testdata.CodeLanguage;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.steps.SecretsSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.fabric8.kubernetes.api.model.ObjectMeta;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

import static edp.core.crd.codebase.codebase_branch.CodebaseBranch.formatCodebaseBranchName;
import static edp.stepdefs.http.GitLabDefinitionSteps.GITLAB_NAMESPACE_PATH;
import static edp.stepdefs.http.GithubDefinitionSteps.GITHUB_NAMESPACE_PATH;
import static edp.stepdefs.http.JiraDefinitionSteps.PROJECT_NAME;
import static edp.utils.wait.WaitingUtils.waitFor;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CodebaseDefinitionSteps {

    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private SecretsSteps secrets;

    private static final String GITHUB_CLONE_SECRETS_NAME = "repository-codebase-%s-temp";

    @Given("User {word}s {word} codebase on gerrit")
    public void createCodebaseOnGerrit(String codebaseStrategy, String versioningType, DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", codebaseStrategy);
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "tekton");
        codebaseData.put("gitServer", "gerrit");
        codebaseData.put("gitUrlPath", "/".concat(codebaseData.get("applicationName")));
        createCodebase(getCodebaseFromMap(codebaseData));
        verifyGitUrlPath(codebaseData.get("applicationName"));
    }

    @Given("User {word}s {word} codebase on github")
    public void createCodebaseOnGithub(String codebaseStrategy, String versioningType, DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", codebaseStrategy);
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "tekton");
        codebaseData.put("gitServer", "github");
        codebaseData.put("gitUrlPath", getGithubUrlPathForCreate(codebaseData.get("applicationName")));
        createCodebase(getCodebaseFromMap(codebaseData));
    }

    @Given("User {word}s {word} codebase on gitlab")
    public void createCodebaseOnGitlab(String codebaseStrategy, String versioningType, DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", codebaseStrategy);
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "tekton");
        codebaseData.put("gitServer", "gitlab");
        codebaseData.put("gitUrlPath", getGitlabUrlPathForCreate(codebaseData.get("applicationName")));
        createCodebase(getCodebaseFromMap(codebaseData));
    }

    @Given("User {word}s {word} codebase on gerrit for jenkins")
    public void createCodebaseOnGerritForJenkins(String codebaseStrategy, String versioningType, DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", codebaseStrategy);
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "jenkins");
        codebaseData.put("ciPipelineProvisioner", "default");
        codebaseData.put("gitServer", "gerrit");
        codebaseData.put("gitUrlPath", "/".concat(codebaseData.get("applicationName")));
        createCodebase(getCodebaseFromMap(codebaseData));
        verifyGitUrlPath(codebaseData.get("applicationName"));
    }

    @Given("User {word}s {word} codebase on gerrit with jira integration")
    public void createCodebaseOnGerritWithJiraIntegration(String codebaseStrategy, String versioningType,
                                                          DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", codebaseStrategy);
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "tekton");
        codebaseData.put("gitServer", "gerrit");
        codebaseData.put("gitUrlPath", "/".concat(codebaseData.get("applicationName")));
        codebaseData.put("jiraServer", "epam-jira");
        createCodebase(getCodebaseFromMap(codebaseData));
        verifyGitUrlPath(codebaseData.get("applicationName"));
    }

    @Given("User {word}s {word} codebase on gerrit for jenkins with jira integration")
    public void createCodebaseOnGerritForJenkinsWithJiraIntegration(String codebaseStrategy, String versioningType,
                                                                    DataTable table) {
        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", codebaseStrategy);
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "jenkins");
        codebaseData.put("ciPipelineProvisioner", "default");
        codebaseData.put("gitServer", "gerrit");
        codebaseData.put("gitUrlPath", "/".concat(codebaseData.get("applicationName")));
        codebaseData.put("jiraServer", "epam-jira");
        createCodebase(getCodebaseFromMap(codebaseData));
        verifyGitUrlPath(codebaseData.get("applicationName"));
    }

    @Given("User imports {word} codebase from github")
    public void importCodebaseFromGithub(String versioningType, DataTable table) {
        waitFor(10);

        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", "import");
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "tekton");

        codebaseData.put("gitServer", "github");
        codebaseData.put("gitUrlPath", getGithubUrlPathForImport());
        createCodebase(getCodebaseFromMap(codebaseData));
    }

    @Given("User imports {word} codebase from github for jenkins")
    public void importCodebaseFromGithubForJenkins(String versioningType, DataTable table) {
        waitFor(10);

        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", "import");
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "jenkins");
        codebaseData.put("ciPipelineProvisioner", "github");

        codebaseData.put("gitServer", "github");
        codebaseData.put("gitUrlPath", getGithubUrlPathForImport());
        createCodebase(getCodebaseFromMap(codebaseData));
    }

    @Given("User imports {word} codebase from github for jenkins with jira integration")
    public void importCodebaseFromGithubForJenkinsWithJiraIntegration(String versioningType, DataTable table) {
        waitFor(10);

        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", "import");
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "jenkins");
        codebaseData.put("ciPipelineProvisioner", "github");

        codebaseData.put("gitServer", "github");
        codebaseData.put("gitUrlPath", getGithubUrlPathForImport());

        codebaseData.put("jiraServer", "epam-jira");
        createCodebase(getCodebaseFromMap(codebaseData));
    }

    @Given("User imports {word} codebase from gitlab")
    public void importCodebaseFromGitlab(String versioningType, DataTable table) {
        waitFor(10);

        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", "import");
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "tekton");

        codebaseData.put("gitServer", "gitlab");
        codebaseData.put("gitUrlPath", getGitlabUrlPathForImport());
        createCodebase(getCodebaseFromMap(codebaseData));
    }

    @Given("User imports {word} codebase from gitlab for jenkins")
    public void importCodebaseFromGitlabForJenkins(String versioningType, DataTable table) {
        waitFor(10);

        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", "import");
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "jenkins");
        codebaseData.put("ciPipelineProvisioner", "gitlab");

        codebaseData.put("gitServer", "git-epam");
        codebaseData.put("gitUrlPath", getGitlabUrlPathForImport());
        createCodebase(getCodebaseFromMap(codebaseData));
    }

    @Given("User imports {word} codebase from gitlab for jenkins with jira integration")
    public void importCodebaseFromGitlabForJenkinsWithJiraIntegration(String versioningType, DataTable table) {
        waitFor(10);

        Map<String, String> codebaseData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseData.put("codebaseStrategy", "import");
        codebaseData.put("versioningType", versioningType);
        codebaseData.put("ciTool", "jenkins");
        codebaseData.put("ciPipelineProvisioner", "gitlab");

        codebaseData.put("gitServer", "git-epam");
        codebaseData.put("gitUrlPath", getGitlabUrlPathForImport());

        codebaseData.put("jiraServer", "epam-jira");
        createCodebase(getCodebaseFromMap(codebaseData));
    }

    @When("User deletes {string} codebase")
    public void deleteCodebase(String codebaseName) {
        factory.deleteCustomResource(Codebase.class, codebaseName);
    }

    @When("User deletes {string} codebase resources")
    public void deleteCodebaseResources(String codebaseName) {
        deleteCodebaseImageStreamsForBranch(codebaseName);
        deleteCodebase(codebaseName);
    }

    @When("User creates new branch")
    public void createNewBranch(DataTable table) {
        Map<String, String> codebaseBranchData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseBranchData.put("isRelease", "false");
        createCodebaseBranch(getCodebaseBranchFromMap(codebaseBranchData));
    }

    @When("User creates new release branch")
    public void createNewReleaseBranch(DataTable table) {
        Map<String, String> codebaseBranchData = new HashMap<>(table.asMap(String.class, String.class));
        codebaseBranchData.put("isRelease", "true");
        createCodebaseBranch(getCodebaseBranchFromMap(codebaseBranchData));
    }

    private Codebase getCodebaseFromMap(Map<String, String> codebaseData) {
        CodebaseSpec spec = new CodebaseSpec();
        String strategy = codebaseData.get("codebaseStrategy");
        spec.setStrategy(strategy);

        CodeLanguage codeLanguage = CodeLanguage.valueOf(codebaseData.get("codeLanguage").toUpperCase());

        if (strategy.equals("clone")) {
            secrets.createGithubCloneSecretWithFollowingValues(String.format(GITHUB_CLONE_SECRETS_NAME,
                    codebaseData.get("applicationName")));
            spec.setRepositoryUrl("https://github.com/edp-robot/" + codeLanguage.getGithubProjectName() + ".git");
        }

        spec.setCiTool(codebaseData.get("ciTool"));
        spec.setCodeLanguage(codeLanguage);
        spec.setDefaultBranch(codebaseData.getOrDefault("defaultBranchName", "master"));

        String codebaseType = codeLanguage.getCodebaseType();
        spec.setType(codebaseType);
        spec.setDeploymentScript(codebaseType.equalsIgnoreCase("application") ? "helm-chart" : "");

        spec.setEmptyProject(Boolean.parseBoolean(codebaseData.getOrDefault("isProjectEmpty", "false")));
        spec.setVersioningType(codebaseData.get("versioningType"), codebaseData.get("startFrom"));
        spec.setGitServer(codebaseData.get("gitServer"));
        spec.setJobProvisioning(codebaseData.get("ciPipelineProvisioner"));
        spec.setGitUrlPath(codebaseData.get("gitUrlPath"));

        spec.setTestReportFramework(codebaseData.get("testReportFramework"));

        if (codebaseData.containsKey("jiraServer")) {
            spec.setJiraServer(codebaseData.get("jiraServer"));
            spec.setCommitMessagePattern(String.format("^\\[%s-\\d{4}\\]:.*", PROJECT_NAME));
            spec.setTicketNamePattern(String.format("%s-\\d{4}", PROJECT_NAME));
            spec.setJiraIssueMetadataPayload(
                    "{\"components\":\"EDP_COMPONENT\",\"fixVersions\":\"EDP_VERSION-EDP_COMPONENT\","
                            + "\"labels\":\"EDP_COMPONENT\"}");
        }

        ObjectMeta metadata = new ObjectMeta();
        metadata.setName(codebaseData.get("applicationName"));

        return new Codebase(spec, metadata);
    }

    private void createCodebase(Codebase codebase) {
        factory.createCustomResource(Codebase.class, codebase);
        factory.verifyCustomResource(Codebase.class, codebase.getMetadata().getName(), Codebase::isActive);
        factory.verifyCustomResource(CodebaseBranch.class, codebase.getDefaultCodebaseBranchName(),
                CodebaseBranch::isActive);
    }

    private void verifyGitUrlPath(String codebaseName) {
        String gitUrlPath = factory.getCustomResource(Codebase.class, codebaseName).get().getSpec().getGitUrlPath();
        assertEquals("/" + codebaseName, gitUrlPath);
    }

    private void deleteCodebaseImageStreamsForBranch(String codebaseName) {
        factory.deleteCustomResources(CodebaseImageStream.class, is -> is.isOfCodebase(codebaseName));
    }

    private String getGithubUrlPathForCreate(String applicationName) {
        return "/" + GITHUB_NAMESPACE_PATH + testsConfig.getProjectName(applicationName);
    }

    private String getGitlabUrlPathForCreate(String applicationName) {
        return "/" + GITLAB_NAMESPACE_PATH + "/" + testsConfig.getProjectName(applicationName);
    }

    private String getGithubUrlPathForImport() {
        return TestCache.get(TestCacheKey.GENERATED_GITHUB_PROJECT_URL).toString()
                .replace("https://github.com", "").replace(".git", "");
    }

    private String getGitlabUrlPathForImport() {
        return "/" + TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_PATH_WITH_NAMESPACE).toString();
    }

    private CodebaseBranch getCodebaseBranchFromMap(Map<String, String> codebaseBranchData) {
        String applicationName = codebaseBranchData.get("applicationName");
        String branchName = codebaseBranchData.get("branchName");

        CodebaseBranchSpec spec = new CodebaseBranchSpec();
        spec.setBranchName(branchName);
        spec.setCodebaseName(applicationName);
        spec.setFromCommit("");
        spec.setRelease(Boolean.parseBoolean(codebaseBranchData.get("isRelease")));
        spec.setVersion(codebaseBranchData.get("newBranchVersion"));

        CodebaseBranchStatus status = new CodebaseBranchStatus();
        status.setBuild("0");

        ObjectMeta metadata = new ObjectMeta();
        metadata.setName(formatCodebaseBranchName(applicationName, branchName));

        return new CodebaseBranch(spec, status, metadata);
    }

    private CodebaseBranch getDefaultCodebaseBranch(Codebase codebase) {
        String applicationName = codebase.getMetadata().getName();
        String branchName = codebase.getSpec().getDefaultBranch();

        CodebaseBranchSpec spec = new CodebaseBranchSpec();
        spec.setBranchName(branchName);
        spec.setCodebaseName(applicationName);
        spec.setFromCommit("");
        spec.setRelease(false);
        spec.setVersion(codebase.getSpec().getStartFrom());

        CodebaseBranchStatus status = new CodebaseBranchStatus();
        status.setBuild("0");

        ObjectMeta metadata = new ObjectMeta();
        metadata.setName(formatCodebaseBranchName(applicationName, branchName));

        return new CodebaseBranch(spec, status, metadata);
    }

    private void createCodebaseBranch(CodebaseBranch branch) {
        factory.createCustomResource(CodebaseBranch.class, branch);
        factory.verifyCustomResource(CodebaseBranch.class, branch.getMetadata().getName(), CodebaseBranch::isActive);
    }

}
