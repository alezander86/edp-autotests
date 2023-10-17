package edp.stepdefs.http;

import edp.core.cache.TestCache;
import edp.core.config.EdpComponentsConfig;
import edp.core.config.TestsConfig;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.engine.httpclient.HttpRequest;
import edp.engine.httpclient.HttpResponseWrapper;
import edp.engine.webservice.parser.IParser;
import edp.steps.SecretsSteps;
import io.cucumber.java.en.When;
import java.util.Objects;
import lombok.extern.log4j.Log4j;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import static edp.engine.httpclient.HttpRequest.ContentType.ANY;
import static edp.engine.httpclient.HttpRequest.ContentType.APPLICATION_JSON;

@Log4j
public class GerritDefinitionSteps {

    @Autowired
    private CommonHttpSteps http;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private SecretsSteps secretsSteps;

    private static final String GERRIT_SECRET_NAME = "gerrit-admin-password";
    private static final String CREATE_CHANGE = "%s/a/changes/";

    private static final String SET_REVIEW = "%s/a/changes/%s/revisions/1/review";
    private static final String SUBMIT_CHANGE = "%s/a/changes/%s/revisions/1/submit";
    private static final String GET_ALL_PROJECTS = "%s/a/projects/?n=%d&S=0";
    private static final String DELETE_PROJECT = "%s/a/projects/%s/delete-project~delete";


    @When("User creates change in {string} branch in {string} gerrit project")
    public void createChange(String branchName, String applicationName) {
        Map<String, String> params = new HashMap<>();
        params.put("project", applicationName);
        params.put("branch", branchName);
        params.put("subject",
                "[" + Objects.requireNonNullElse(TestCache.get(TestCacheKey.JIRA_TICKET_KEY, String.class), "test")
                        + "]: test");

        String url = String.format(CREATE_CHANGE, getGerritUrl());

        HttpResponseWrapper response = sendGerritRequest(HttpRequest.post(url), params, 201);
        log.info("Change is created for");

        JSONObject changeResponse = new JSONObject(response.getBody().replace(")]}'", ""));
        TestCache.putDataInCache(TestCacheKey.CHANGE_ID, changeResponse.getString("change_id"));
    }

    @When("User creates change in {string} branch in {string} gerrit project with wrong commit message")
    public void createChangeWithWrongCommitMessage(String branchName, String applicationName) {
        Map<String, String> params = new HashMap<>();
        params.put("project", applicationName);
        params.put("branch", branchName);
        params.put("subject", "[test]: test");

        String url = String.format(CREATE_CHANGE, getGerritUrl());

        HttpResponseWrapper response = sendGerritRequest(HttpRequest.post(url), params, 201);
        log.info("Change is created for");

        JSONObject changeResponse = new JSONObject(response.getBody().replace(")]}'", ""));
        TestCache.putDataInCache(TestCacheKey.CHANGE_ID, changeResponse.getString("change_id"));
    }

    @When("User restarts review pipeline using recheck comment in gerrit")
    public void restartReviewPipeline() {
        String changeId = TestCache.get(TestCacheKey.CHANGE_ID, String.class);
        addRecheckCommitMessage(changeId);
    }

    @When("User makes merge request in gerrit")
    public void makeMergeRequest() {
        String changeId = TestCache.get(TestCacheKey.CHANGE_ID, String.class);
        setReviewValues(changeId);
        submitChange(changeId);
    }

    @When("User deletes gerrit projects")
    public void deleteProjects() {
        if (testsConfig.getGitProvider().equalsIgnoreCase("gerrit")) {
            int projectsToGet = 300;
            String url = String.format(GET_ALL_PROJECTS, getGerritUrl(), projectsToGet);

            HttpResponseWrapper response = sendGerritRequest(HttpRequest.get(url), 200);

            JSONObject json = new JSONObject(response.getBody().replace(")]}'", ""));

            Set<String> projectsNames = json.keySet();
            projectsNames.stream().filter(pn -> !pn.startsWith("All")).forEach(this::deleteProject);
        }
    }

    private void addRecheckCommitMessage(String changeId) {
        String url = String.format(SET_REVIEW, getGerritUrl(), changeId);

        Map<String, Object> params = new HashMap<>();
        params.put("message", "/recheck");

        sendGerritRequest(HttpRequest.post(url), params, 200);
        log.info("Added recheck comment");
    }

    private void setReviewValues(String changeId) {
        String url = String.format(SET_REVIEW, getGerritUrl(), changeId);

        Map<String, Integer> labelsMap = new HashMap<>();
        labelsMap.put("Code-Review", 2);

        Map<String, Object> params = new HashMap<>();
        params.put("drafts", "PUBLISH_ALL_REVISIONS");
        params.put("labels", labelsMap);

        sendGerritRequest(HttpRequest.post(url), params, 200);
        log.info("Review values are set");
    }

    private void submitChange(String changeId) {
        String url = String.format(SUBMIT_CHANGE, getGerritUrl(), changeId);

        sendGerritRequest(HttpRequest.post(url), 200);
        log.info("Changes submitted");
    }

    private void deleteProject(String codebaseName) {
        String url = String.format(DELETE_PROJECT, getGerritUrl(), codebaseName);

        Map<String, Object> params = new HashMap<>();
        params.put("force", true);
        params.put("preserve", false);

        sendGerritRequest(HttpRequest.post(url), params, 204);
        log.info("Project " + codebaseName + " deleted");
    }

    private HttpResponseWrapper sendGerritRequest(HttpRequest request, int expectedStatusCode) {
        return http.waitResponseStatusCode(request
                        .addAccept(ANY.toString())
                        .addBasicAuth(getGerritSecretFieldValue("user"),
                                getGerritSecretFieldValue("password")),
                expectedStatusCode);
    }

    private HttpResponseWrapper sendGerritRequest(HttpRequest request, Object params, int expectedStatusCode) {
        return http.waitResponseStatusCode(request
                        .addAccept(ANY.toString())
                        .addContentType(APPLICATION_JSON.toString())
                        .addBasicAuth(getGerritSecretFieldValue("user"),
                                getGerritSecretFieldValue("password"))
                        .addBody(IParser.toJson(params)),
                expectedStatusCode);
    }

    private String getGerritUrl() {
        return edpComponentsConfig.getGerritUrl();
    }

    private String getGerritSecretFieldValue(String fieldName) {
        return secretsSteps.getSecretFieldValue(GERRIT_SECRET_NAME, fieldName);
    }

}
