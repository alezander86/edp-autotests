package edp.stepdefs.http;

import edp.core.cache.TestCache;
import edp.core.config.GithubProviderConfig;
import edp.core.config.TestsConfig;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.enums.testdata.CodeLanguage;
import edp.engine.httpclient.HttpRequest;
import edp.engine.httpclient.HttpResponseWrapper;
import edp.engine.webservice.parser.IParser;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import java.util.Objects;
import lombok.extern.log4j.Log4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

import static edp.engine.httpclient.HttpRequest.ContentType.ANY;
import static edp.engine.httpclient.HttpRequest.ContentType.APPLICATION_JSON;
import static edp.utils.strings.StringsHelper.encode;

@Log4j
public class GithubDefinitionSteps {

    @Autowired
    private CommonHttpSteps http;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private GithubProviderConfig githubProviderConfig;

    private static final String GITHUB_URL = "https://api.github.com";
    public static final String GITHUB_NAMESPACE_PATH = "edp-robot/";
    private static final String GENERATE_PROJECT = "%s/repos/edp-robot/%s/generate";
    private static final String GET_HEAD_DATA = "%s/repos/edp-robot/%s/git/refs/heads";
    private static final String CREATE_NEW_BRANCH = "%s/repos/edp-robot/%s/git/refs";
    private static final String CREATE_CHANGE_IN_NEW_BRANCH = "%s/repos/edp-robot/%s/contents/test.txt";
    private static final String CREATE_PULL_REQUEST = "%s/repos/edp-robot/%s/pulls";
    private static final String MERGE_PULL_REQUEST = "%s/repos/edp-robot/%s/pulls/%s/merge";
    private static final String DELETE_PROJECT = "%s/repos/edp-robot/%s";
    private static final String PROJECTS_LIST =
            "%s/users/edp-robot/repos?sort=created&direction=desc&per_page=100";
    private static final String ADD_COMMENT = "%s/repos/edp-robot/%s/issues/%s/comments";

    @Given("User generates {string} github project with {string} project name")
    public void generateGithubRepository(String codeLanguage, String applicationName) {
        String originalProjectName = CodeLanguage.valueOf(codeLanguage.toUpperCase()).getGithubProjectName();
        String newProjectName = testsConfig.getProjectName(applicationName);

        Map<String, Object> params = new HashMap<>();
        params.put("owner", "edp-robot");
        params.put("name", newProjectName);
        params.put("include_all_branches", true);

        String url = String.format(GENERATE_PROJECT, GITHUB_URL, originalProjectName);

        HttpResponseWrapper response = sendGithubRequest(HttpRequest.post(url), params, 201);
        log.info("New Github project is generated");

        JSONObject responseBody = new JSONObject(response.getBody());
        TestCache.putDataInCache(TestCacheKey.GENERATED_GITHUB_PROJECT_URL, responseBody.getString("clone_url"));
    }

    @When("User creates pull request to {string} target branch in github {string} project")
    public void createGithubPullRequest(String targetBranch, String applicationName) {
        String projectName = testsConfig.getProjectName(applicationName);
        String sourceBranch = "source";

        getHeadSha(projectName);
        createNewBranch(projectName, sourceBranch);
        commitChangesInNewBranch(projectName, sourceBranch);
        createPullRequest(projectName, sourceBranch, targetBranch);
    }

    @When("User creates pull request to {string} target branch in github {string} project with wrong commit message")
    public void createGithubPullRequestWithWrongCommitMessage(String targetBranch, String applicationName) {
        String projectName = testsConfig.getProjectName(applicationName);
        String sourceBranch = "source";

        getHeadSha(projectName);
        createNewBranch(projectName, sourceBranch);
        commitChangesInNewBranchWithWrongCommitMessage(projectName, sourceBranch);
        createPullRequestWithWrongCommitMessage(projectName, sourceBranch, targetBranch);
    }

    @When("User restarts review pipeline using recheck comment for {word} in github")
    public void restartReviewPipeline(String applicationName) {
        String projectName = testsConfig.getProjectName(applicationName);
        String url = String.format(ADD_COMMENT, GITHUB_URL, projectName,
                TestCache.get(TestCacheKey.GITHUB_PULL_REQUEST_NUMBER).toString());

        Map<String, String> params = new HashMap<>();
        params.put("body", "/recheck");

        sendGithubRequest(HttpRequest.post(url), params, 201);
        log.info("Added recheck comment");
    }

    @When("User merges pull request in github {string} project")
    public void mergePullRequest(String applicationName) {
        String projectName = testsConfig.getProjectName(applicationName);
        String url = String.format(MERGE_PULL_REQUEST, GITHUB_URL, projectName,
                TestCache.get(TestCacheKey.GITHUB_PULL_REQUEST_NUMBER).toString());

        sendGithubRequest(HttpRequest.put(url), 200);
        log.info("Pull request in Github project merged");
    }

    @When("User deletes {string} github project")
    public void deleteGithubProject(String applicationName) {
        String projectName = testsConfig.getProjectName(applicationName);
        deleteProject(projectName);
    }

    @When("User deletes Github projects")
    public void deleteGithubProjects() {
        deleteAllProject();
    }


    public void getHeadSha(String projectName) {
        String url = String.format(GET_HEAD_DATA, GITHUB_URL, projectName);

        HttpResponseWrapper response = sendGithubRequest(HttpRequest.get(url), 200);
        log.info("Get SHA for head");

        JSONArray generateResponse = new JSONArray(response.getBody());
        for (int i = 0; i < generateResponse.length(); i++) {
            if (generateResponse.getJSONObject(i).toString().contains("refs/heads/master") ||
                    generateResponse.getJSONObject(i).toString().contains("refs/heads/main")) {
                JSONObject object = generateResponse.getJSONObject(i).getJSONObject("object");
                TestCache.putDataInCache(TestCacheKey.SHA_FOR_HEAD_GITHUB, object.getString("sha"));
                break;
            }
        }
    }

    private void createNewBranch(String projectName, String sourceBranch) {
        Map<String, String> params = new HashMap<>();
        params.put("ref", "refs/heads/" + sourceBranch);
        params.put("sha", TestCache.get(TestCacheKey.SHA_FOR_HEAD_GITHUB).toString());

        String url = String.format(CREATE_NEW_BRANCH, GITHUB_URL, projectName);

        sendGithubRequest(HttpRequest.post(url), params, 201);
        log.info("New branch in Github project is created");
    }

    public void commitChangesInNewBranch(String projectName, String branch) {
        Map<String, String> params = new HashMap<>();
        params.put("message",
                "[" + Objects.requireNonNullElse(TestCache.get(TestCacheKey.JIRA_TICKET_KEY), "test") + "]: test");
        params.put("content", encode("content"));
        params.put("branch", branch);

        String url = String.format(CREATE_CHANGE_IN_NEW_BRANCH, GITHUB_URL, projectName);

        sendGithubRequest(HttpRequest.put(url), params, 201);
        log.info("Change for new branch in Github project is created");
    }

    public void commitChangesInNewBranchWithWrongCommitMessage(String projectName, String branch) {
        Map<String, String> params = new HashMap<>();
        params.put("message", "[test]: test");
        params.put("content", encode("content"));
        params.put("branch", branch);

        String url = String.format(CREATE_CHANGE_IN_NEW_BRANCH, GITHUB_URL, projectName);

        sendGithubRequest(HttpRequest.put(url), params, 201);
        log.info("Change for new branch in Github project is created");
    }

    public void createPullRequest(String projectName, String sourceBranch, String branchName) {
        Map<String, String> params = new HashMap<>();
        params.put("title",
                "[" + Objects.requireNonNullElse(TestCache.get(TestCacheKey.JIRA_TICKET_KEY), "test") + "]: test");
        params.put("head", sourceBranch);
        params.put("base", branchName);
        params.put("body", "body");

        String url = String.format(CREATE_PULL_REQUEST, GITHUB_URL, projectName);

        HttpResponseWrapper response = sendGithubRequest(HttpRequest.post(url), params,
                201);
        log.info("Pull request is created");

        JSONObject pullRequestResponse = new JSONObject(response.getBody());
        TestCache.putDataInCache(TestCacheKey.GITHUB_PULL_REQUEST_NUMBER, pullRequestResponse.getNumber("number"));
    }

    public void createPullRequestWithWrongCommitMessage(String projectName, String sourceBranch, String branchName) {
        Map<String, String> params = new HashMap<>();
        params.put("title", "[test]: test");
        params.put("head", sourceBranch);
        params.put("base", branchName);
        params.put("body", "body");

        String url = String.format(CREATE_PULL_REQUEST, GITHUB_URL, projectName);

        HttpResponseWrapper response = sendGithubRequest(HttpRequest.post(url), params,
                201);
        log.info("Pull request is created");

        JSONObject pullRequestResponse = new JSONObject(response.getBody());
        TestCache.putDataInCache(TestCacheKey.GITHUB_PULL_REQUEST_NUMBER, pullRequestResponse.getNumber("number"));
    }

    private void deleteProject(String projectName) {
        String url = String.format(DELETE_PROJECT, GITHUB_URL, projectName);

        sendGithubRequest(HttpRequest.delete(url), 204);
        log.info(projectName + " is deleted");
    }

    public void deleteAllProject() {
        HttpResponseWrapper response = sendGithubRequest(HttpRequest.get(String.format(PROJECTS_LIST, GITHUB_URL)),
                200);

        JSONArray projects = new JSONArray(response.getBody());
        for (int i = 0; i < projects.length(); i++) {
            String projectName = projects.getJSONObject(i).getString("name");

            if (projectName.contains(testsConfig.getNamespace())) {
                deleteProject(projectName);
            }
        }
    }

    private HttpResponseWrapper sendGithubRequest(HttpRequest request, int expectedStatusCode) {
        return http.waitResponseStatusCode(request
                        .addAccept(ANY.toString())
                        .addContentType(APPLICATION_JSON.toString())
                        .addBearerTokenAuth(githubProviderConfig.getToken()),
                expectedStatusCode);
    }

    private HttpResponseWrapper sendGithubRequest(HttpRequest request, Object params, int expectedStatusCode) {
        return http.waitResponseStatusCode(request
                        .addAccept(ANY.toString())
                        .addContentType(APPLICATION_JSON.toString())
                        .addBearerTokenAuth(githubProviderConfig.getToken())
                        .addBody(IParser.toJson(params)),
                expectedStatusCode);
    }

}



