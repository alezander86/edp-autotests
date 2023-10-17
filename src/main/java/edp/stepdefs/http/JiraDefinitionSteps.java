package edp.stepdefs.http;

import edp.core.cache.TestCache;
import edp.core.config.TestsConfig;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.engine.httpclient.HttpRequest;
import edp.engine.httpclient.HttpResponseWrapper;
import edp.engine.webservice.parser.IParser;
import edp.steps.SecretsSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;
import java.util.function.Consumer;

import static edp.engine.httpclient.HttpRequest.ContentType.ANY;
import static edp.engine.httpclient.HttpRequest.ContentType.APPLICATION_JSON;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class JiraDefinitionSteps {

    @Autowired
    private CommonHttpSteps http;
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    private SecretsSteps secretsSteps;

    public static final String PROJECT_NAME = "EPMDEDPSUP";
    public static final String PARENT_TICKET_ID = "-2210";
    private static final String JIRA_SECRET_NAME = "ci-jira";
    private static final String JIRA_URL = "https://jiraeu.epam.com/rest/api/2";
    private static final String CREATE_SUBTASK = "%s/issue";
    private static final String DELETE_SUBTASK = "%s/issue/%s";
    private static final String GET_PARENT_SUBTASKS = "%s/issue/%s/subtask";
    private static final String GET_TICKET_DATA = "%s/search?jql=key=%s";


    @Given("User creates {string} subtask in Jira ticket")
    public void createSubTaskInJiraTicket(String applicationName) {
        Map<String, String> jiraProject = new HashMap<>();
        jiraProject.put("key", PROJECT_NAME);

        Map<String, String> jiraParent = new HashMap<>();
        jiraParent.put("key", PROJECT_NAME + PARENT_TICKET_ID);

        Map<String, String> jiraIssueType = new HashMap<>();
        jiraIssueType.put("id", "5");

        Map<String, String> jiraAssignee = new HashMap<>();
        jiraAssignee.put("name", "");

        Map<String, Object> fields = new HashMap<>();
        fields.put("project", jiraProject);
        fields.put("assignee", jiraAssignee);
        fields.put("parent", jiraParent);
        fields.put("summary", testsConfig.getProjectName(applicationName));
        fields.put("description", "Check jira-integration for " + applicationName + " codebase");
        fields.put("issuetype", jiraIssueType);

        Map<String, Object> params = new HashMap<>();
        params.put("fields", fields);

        String url = String.format(CREATE_SUBTASK, JIRA_URL);

        HttpResponseWrapper response = sendJiraRequest(HttpRequest.post(url), params, 201);

        JSONObject jsonResponse = new JSONObject(response.getBody());
        TestCache.putDataInCache(TestCacheKey.JIRA_TICKET_KEY, jsonResponse.getString("key"));
    }

    @When("User deletes Jira subtask")
    public void deleteSubtask() {
        deleteSubtask(TestCache.get(TestCacheKey.JIRA_TICKET_KEY).toString());
    }

    @When("User deletes Jira subtasks")
    public void deleteAllSubtasks() {
        String url = String.format(GET_PARENT_SUBTASKS, JIRA_URL, PROJECT_NAME + PARENT_TICKET_ID);

        HttpResponseWrapper response = sendJiraRequest(HttpRequest.get(url), 200);

        JSONArray jsonResponse = new JSONArray(response.getBody());
        for (int i = 0; i < jsonResponse.length(); i++) {
            String summary = jsonResponse.getJSONObject(i).getJSONObject("fields").get("summary").toString();
            if (summary.contains(testsConfig.getNamespace())) {
                deleteSubtask(jsonResponse.getJSONObject(i).getString("key"));
            }
        }
    }

    @Then("User checks Jira ticket fields")
    public void checkTicketFields(DataTable table) {
        Map<String, String> ticketData = new HashMap<>(table.asMap(String.class, String.class));
        String applicationName = ticketData.get("applicationName");
        String version = ticketData.containsKey("version") ? ticketData.get("version") :
                formattedVersionBaseOnVersionTag(TestCache.get(TestCacheKey.IMAGE_VERSION).toString(), ticketData);

        String url = String.format(GET_TICKET_DATA, JIRA_URL, TestCache.get(TestCacheKey.JIRA_TICKET_KEY));
        http.waitResponseCondition(addParametersToJiraRequest(HttpRequest.get(url)),
                assertJiraTicketFields(applicationName, version));
    }

    @Then("User checks Jira ticket fields are empty")
    public void checkTicketFieldsAreEmpty() {
        String url = String.format(GET_TICKET_DATA, JIRA_URL, TestCache.get(TestCacheKey.JIRA_TICKET_KEY));
        http.waitResponseCondition(addParametersToJiraRequest(HttpRequest.get(url)), assertJiraTicketFieldsAreEmpty());
    }

    private void deleteSubtask(String ticketKey) {
        String url = String.format(DELETE_SUBTASK, JIRA_URL, ticketKey);
        sendJiraRequest(HttpRequest.delete(url), 204);
    }

    private HttpResponseWrapper sendJiraRequest(HttpRequest request, int expectedStatusCode) {
        return http.waitResponseStatusCode(addParametersToJiraRequest(request), expectedStatusCode);
    }

    private HttpResponseWrapper sendJiraRequest(HttpRequest request, Object params, int expectedStatusCode) {
        return http.waitResponseStatusCode(addParametersToJiraRequest(request)
                        .addBody(IParser.toJson(params)),
                expectedStatusCode);
    }

    private HttpRequest addParametersToJiraRequest(HttpRequest request) {
        return request.addAccept(ANY.toString())
                .addContentType(APPLICATION_JSON.toString())
                .addBasicAuth(getJiraSecretFieldValue("username"), getJiraSecretFieldValue("password"));
    }

    private String getJiraSecretFieldValue(String fieldName) {
        return secretsSteps.getSecretFieldValue(JIRA_SECRET_NAME, fieldName);
    }

    private Consumer<HttpResponseWrapper> assertJiraTicketFields(String applicationName, String version) {
        return response -> {
            assertEquals(200, response.getStatusCode());

            JSONObject jsonResponse = new JSONObject(response.getBody());
            JSONObject fields = jsonResponse.getJSONArray("issues").getJSONObject(0).getJSONObject("fields");

            String component = fields.getJSONArray("components").getJSONObject(0).get("name").toString();
            assertEquals(applicationName, component);

            String label = fields.getJSONArray("labels").getString(0);
            assertEquals(applicationName, label);

            String fixVersion = fields.getJSONArray("fixVersions").getJSONObject(0).get("name").toString();
            assertEquals(version + "-" + applicationName, fixVersion);
        };
    }

    private Consumer<HttpResponseWrapper> assertJiraTicketFieldsAreEmpty() {
        return response -> {
            assertEquals(200, response.getStatusCode());

            JSONObject jsonResponse = new JSONObject(response.getBody());
            JSONObject fields = jsonResponse.getJSONArray("issues").getJSONObject(0).getJSONObject("fields");

            assertTrue(fields.getJSONArray("components").isEmpty());
            assertTrue(fields.getJSONArray("labels").isEmpty());
            assertTrue(fields.getJSONArray("fixVersions").isEmpty());
        };
    }

    private String formattedVersionBaseOnVersionTag(String image, Map<String, String> ticketData) {
        return ticketData.containsKey("variable") && "EDP_VERSION".equals(ticketData.get("variable")) ?
                image.replace(ticketData.get("defaultBranchName").concat("-"), "") : image;
    }

}
