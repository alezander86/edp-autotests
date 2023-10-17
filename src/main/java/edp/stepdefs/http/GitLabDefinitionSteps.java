package edp.stepdefs.http;

import edp.core.cache.TestCache;
import edp.core.config.GitlabProviderConfig;
import edp.core.config.TestsConfig;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.enums.testdata.CodeLanguage;
import edp.engine.httpclient.HttpRequest;
import edp.engine.httpclient.HttpResponseWrapper;
import edp.engine.webservice.parser.IParser;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import lombok.extern.log4j.Log4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

import static edp.engine.httpclient.HttpRequest.ContentType.ANY;
import static edp.engine.httpclient.HttpRequest.ContentType.APPLICATION_JSON;

@Log4j
public class GitLabDefinitionSteps {

    @Autowired
    private CommonHttpSteps http;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private GitlabProviderConfig gitlabProviderConfig;
    public static final String GITLAB_NAMESPACE_PATH = "epmd-edp/temp/repos-for-autotests/fork";
    private static final String GITLAB_URL = "https://git.epam.com";
    private static final String FORK_PROJECT = "%s/api/v4/projects/%s/fork";
    private static final String PROJECT_ID_BY_NAME = "%s/api/v4/projects?search=%s";
    private static final String DELETE_FORK_PROJECT = "%s/api/v4/projects/%s";
    private static final String CREATE_NEW_BRANCH = "%s/api/v4/projects/%s/repository/branches";
    private static final String MAKE_COMMIT = "%s/api/v4/projects/%s/repository/commits";
    private static final String CREATE_PULL_REQUEST = "%s/api/v4/projects/%s/merge_requests";

    private static final String MERGE_PULL_REQUEST = "%s/api/v4/projects/%s/merge_requests/%s/merge";
    private static final String ADD_COMMENT = "%s/api/v4/projects/%s/merge_requests/%s/notes";
    private static final String PARENT_ID = "71496";
    private static final String GET_ALL_PROJECTS = "%s/api/v4/groups/" + PARENT_ID + "/projects?per_page=100&page=%s";


    @Given("User forks {string} gitlab project with {string} project name")
    public void forkGitlabProject(String codeLanguage, String applicationName) {
        String projectName = testsConfig.getProjectName(applicationName);
        String id = CodeLanguage.valueOf(codeLanguage.toUpperCase()).getGitlabId();
        forkProject(id, projectName);
    }

    @When("User deletes gitlab fork project")
    public void deleteGitlabForkProject() {
        deleteForkProject();
    }

    @When("User creates pull request from {string} ref branch to {string} target branch in gitlab")
    public void createGitlabPullRequest(String refBranch, String targetBranch) {
        String sourceBranch = "source";
        createNewBranch(refBranch, sourceBranch);
        commitChangesInNewBranch(sourceBranch);
        createPullRequest(sourceBranch, targetBranch);
    }

    @When("User creates pull request from {string} ref branch to {string} target branch in gitlab with wrong commit message")
    public void createGitlabPullRequestWithWrongCommitMessage(String refBranch, String targetBranch) {
        String sourceBranch = "source";
        createNewBranch(refBranch, sourceBranch);
        commitChangesInNewBranchWithWrongCommitMessage(sourceBranch);
        createPullRequestWithWrongCommitMessage(sourceBranch, targetBranch);
    }

    @When("User restarts review pipeline using recheck comment in gitlab")
    public void restartReviewPipeline() {
        String url = String.format(ADD_COMMENT, GITLAB_URL, TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_ID),
                TestCache.get(TestCacheKey.GITLAB_MERGE_REQUEST_IID));

        Map<String, String> params = new HashMap<>();
        params.put("body", "/recheck");

        sendGitlabRequest(HttpRequest.post(url), IParser.toJson(params), 201);
    }

    @When("User merges pull request in Gitlab")
    public void mergePullRequest() {
        String url = String.format(MERGE_PULL_REQUEST, GITLAB_URL,
                TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_ID),
                TestCache.get(TestCacheKey.GITLAB_MERGE_REQUEST_IID));

        sendGitlabRequest(HttpRequest.put(url), 200);
    }

    @When("User deletes Gitlab projects")
    public void deleteGitlabProjects() {
        HttpResponseWrapper firstPage =
                sendGitlabRequest(HttpRequest.get(String.format(GET_ALL_PROJECTS, GITLAB_URL, 1)), 200);
        int totalPages = Integer.parseInt(Arrays.stream(firstPage.getHeader("X-Total-Pages"))
                .findFirst().get().getValue());
        List<JSONObject> projects = new ArrayList<>();
        new JSONArray(firstPage.getBody()).forEach(p -> projects.add((JSONObject) p));
        for (int j = 2; j <= totalPages; j++) {
            HttpResponseWrapper secondAndMorePages =
                    sendGitlabRequest(HttpRequest.get(String.format(GET_ALL_PROJECTS, GITLAB_URL, j)), 200);
            new JSONArray(secondAndMorePages.getBody()).forEach(p -> projects.add((JSONObject) p));
        }
        for (JSONObject project : projects) {
            if (project.getString("name").contains(testsConfig.getNamespace())) {
                deleteProject(project.getInt("id"));
            }
        }
    }

    @When("User receive and save GitLab project ID for project {word}")
    public void getGitLabProjectId(String projectName) {
        String url = String.format(PROJECT_ID_BY_NAME, GITLAB_URL, testsConfig.getNamespace().concat("-")
                .concat(projectName));
        HttpResponseWrapper response = sendGitlabRequest(HttpRequest.get(url), 200);

        JSONObject responseBody = new JSONObject(response.getBody().substring(1, response.getBody().length() - 1));
        TestCache.putDataInCache(TestCacheKey.FORK_GITLAB_PROJECT_ID, responseBody.get("id"));
        TestCache.putDataInCache(TestCacheKey.FORK_GITLAB_PROJECT_PATH_WITH_NAMESPACE,
                responseBody.getString("path_with_namespace"));

    }

    private void forkProject(String id, String projectName) {
        String url = String.format(FORK_PROJECT, GITLAB_URL, id);

        Map<String, String> params = new HashMap<>();
        params.put("id", id);
        params.put("name", projectName);
        params.put("path", projectName);
        params.put("namespace_path", GITLAB_NAMESPACE_PATH);

        HttpResponseWrapper response = sendGitlabRequest(HttpRequest.post(url), IParser.toJson(params), 201);
        log.info("Fork project is created");

        JSONObject responseBody = new JSONObject(response.getBody());
        TestCache.putDataInCache(TestCacheKey.FORK_GITLAB_PROJECT_ID, responseBody.get("id"));
        TestCache.putDataInCache(TestCacheKey.FORK_GITLAB_PROJECT_PATH_WITH_NAMESPACE,
                responseBody.getString("path_with_namespace"));
    }

    private void deleteForkProject() {
        String url = String.format(DELETE_FORK_PROJECT, GITLAB_URL,
                TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_ID));

        sendGitlabRequest(HttpRequest.delete(url), 202);
        log.info("Fork project is deleted");
    }

    private void createNewBranch(String refBranch, String newBranch) {
        String url = String.format(CREATE_NEW_BRANCH, GITLAB_URL,
                TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_ID));

        Map<String, String> params = new HashMap<>();
        params.put("branch", newBranch);
        params.put("ref", refBranch);

        sendGitlabRequest(HttpRequest.post(url), IParser.toJson(params), 201);
        log.info("New branch is created");
    }

    private void commitChangesInNewBranch(String branch) {
        String url = String.format(MAKE_COMMIT, GITLAB_URL,
                TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_ID));

        JSONObject params = new JSONObject();
        JSONArray actions = new JSONArray();

        JSONObject actionCreate = new JSONObject();
        actionCreate.put("action", "create");
        actionCreate.put("file_path", "foo");
        actionCreate.put("content", "some content");
        actions.put(actionCreate);

        params.put("branch", branch);
        params.put("commit_message",
                "[" + Objects.requireNonNullElse(TestCache.get(TestCacheKey.JIRA_TICKET_KEY), "test") + "]: test");
        params.put("actions", actions);

        sendGitlabRequest(HttpRequest.post(url), params.toString(), 201);
        log.info("Commit is created");
    }

    private void commitChangesInNewBranchWithWrongCommitMessage(String branch) {
        String url = String.format(MAKE_COMMIT, GITLAB_URL,
                TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_ID));

        JSONObject params = new JSONObject();
        JSONArray actions = new JSONArray();

        JSONObject actionCreate = new JSONObject();
        actionCreate.put("action", "create");
        actionCreate.put("file_path", "foo");
        actionCreate.put("content", "some content");
        actions.put(actionCreate);

        params.put("branch", branch);
        params.put("commit_message", "[test]: test");
        params.put("actions", actions);

        sendGitlabRequest(HttpRequest.post(url), params.toString(), 201);
        log.info("Commit is created");
    }

    private void createPullRequest(String sourceBranch, String targetBranch) {
        String url = String.format(CREATE_PULL_REQUEST, GITLAB_URL,
                TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_ID));

        Map<String, String> params = new HashMap<>();
        params.put("source_branch", sourceBranch);
        params.put("target_branch", targetBranch);
        params.put("title",
                "[" + Objects.requireNonNullElse(TestCache.get(TestCacheKey.JIRA_TICKET_KEY), "test") + "]: test");

        HttpResponseWrapper response = sendGitlabRequest(HttpRequest.post(url), IParser.toJson(params), 201);
        log.info("Merge request is created");

        JSONObject commitResponse = new JSONObject(response.getBody());
        TestCache.putDataInCache(TestCacheKey.GITLAB_MERGE_REQUEST_IID, commitResponse.get("iid"));
    }

    private void createPullRequestWithWrongCommitMessage(String sourceBranch, String targetBranch) {
        String url = String.format(CREATE_PULL_REQUEST, GITLAB_URL,
                TestCache.get(TestCacheKey.FORK_GITLAB_PROJECT_ID));

        Map<String, String> params = new HashMap<>();
        params.put("source_branch", sourceBranch);
        params.put("target_branch", targetBranch);
        params.put("title", "[test]: test");

        HttpResponseWrapper response = sendGitlabRequest(HttpRequest.post(url), IParser.toJson(params), 201);
        log.info("Merge request is created");

        JSONObject commitResponse = new JSONObject(response.getBody());
        TestCache.putDataInCache(TestCacheKey.GITLAB_MERGE_REQUEST_IID, commitResponse.get("iid"));
    }

    private void deleteProject(int projectId) {
        String url = String.format(DELETE_FORK_PROJECT, GITLAB_URL, projectId);

        sendGitlabRequest(HttpRequest.delete(url), 202);
    }

    private HttpResponseWrapper sendGitlabRequest(HttpRequest request, int expectedStatusCode) {
        return http.waitResponseStatusCode(request
                        .addAccept(ANY.toString())
                        .addContentType(APPLICATION_JSON.toString())
                        .addBearerTokenAuth(gitlabProviderConfig.getToken()),
                expectedStatusCode);
    }

    private HttpResponseWrapper sendGitlabRequest(HttpRequest request, String body, int expectedStatusCode) {
        return http.waitResponseStatusCode(request
                        .addAccept(ANY.toString())
                        .addContentType(APPLICATION_JSON.toString())
                        .addBearerTokenAuth(gitlabProviderConfig.getToken())
                        .addBody(body),
                expectedStatusCode);
    }

}



