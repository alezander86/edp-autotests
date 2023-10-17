package edp.stepdefs.cubernetes;

import edp.core.cache.TestCache;
import edp.core.config.KeycloakAuthConfig;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.service.CodebaseResource;
import edp.core.service.kubernetes.SecretsProvider;
import edp.engine.httpclient.HttpResponseWrapper;
import edp.engine.webservice.restclient.KeycloakRestClient;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.fabric8.kubernetes.api.model.Secret;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

import static edp.utils.strings.StringsHelper.decode;

public class WebServiceCodebaseDefinitionSteps {

    public static final String GRANT_TYPE_PASSWORD = "password";

    @Autowired
    private KeycloakAuthConfig keycloakAuthConfig;
    @Autowired
    private KeycloakRestClient keycloakRestClient;
    @Autowired
    private SecretsProvider secretsProvider;
    @Autowired
    private CodebaseResource codebaseResource;

    @And("User checks {string} branch build status")
    public void checkBranchBuildStatus(String codebaseBranchName) throws InterruptedException {
        codebaseResource.checkBranchBuildStatus(codebaseBranchName);
    }

    @And("User checks {string} branch last successful build status")
    public void checkBranchLastSuccessfulBuildStatus(String codebaseBranchName) throws InterruptedException {
        codebaseResource.checkBranchLastSuccessfulBuildStatus(codebaseBranchName);
    }

    @And("User sends request to get token")
    public void sendRequestToGetToken() {
        Map<String, String> params = new HashMap<>();
        params.put("username", keycloakAuthConfig.getAcCreatorId());
        params.put("password", TestCache.get(TestCacheKey.AC_CREATOR_PASSWORD, String.class));
        params.put("client_id", keycloakAuthConfig.getClientId());
        params.put("client_secret", TestCache.get(TestCacheKey.ADMIN_CONSOLE_CLIENT_PASSWORD, String.class));
        params.put("grant_type", GRANT_TYPE_PASSWORD);
        HttpResponseWrapper responseWrapper = keycloakRestClient.sendGetTokenRequest(params);
        JSONObject body = new JSONObject(responseWrapper.getBody());
        TestCache.putDataInCache(TestCacheKey.ACCESS_TOKEN, body.getString("access_token"));

    }

    @And("User sends request to get ac-creator secret")
    public void sendRequestToGetAcCreatorSecret() {
        Secret secret = secretsProvider.getSecret(keycloakAuthConfig.getAcCreatorId());
        String password = secret.getData().get("password");
        TestCache.putDataInCache(TestCacheKey.AC_CREATOR_PASSWORD, decode(password));
    }

    @And("User sends request to get admin-console-client secret")
    public void sendRequestToGetAdminConsoleClientSecret() {
        Secret secret = secretsProvider.getSecret(keycloakAuthConfig.getClientId());
        String password = secret.getData().get("password");
        TestCache.putDataInCache(TestCacheKey.ADMIN_CONSOLE_CLIENT_PASSWORD, decode(password));
    }

    @Given("User checks {string} admin console cr status")
    public void userChecksAdminConsoleCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksAdminConsoleCrStatus(crName);
    }

    @Given("User checks {string} sonar cr status")
    public void userChecksSonarCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksSonarCrStatus(crName);
    }

    @Given("User checks {string} nexus cr status")
    public void userChecksNexusCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksNexusCrStatus(crName);
    }

    @Given("User checks {string} gerrit cr status")
    public void userChecksGerritCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksGerritCrStatus(crName);
    }

    @Given("User checks {string} jenkins cr status")
    public void userChecksJenkinsCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksJenkinsCrStatus(crName);
    }

    @And("User checks {string} keycloakClient cr status")
    public void userChecksKeycloakClientCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksKeycloakClientCrStatus(crName);
    }

    @And("User checks {string} keycloakRealmRoleBatch cr status")
    public void userChecksKeycloakRealmRoleBatchCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksKeycloakRealmRoleBatchCrStatus(crName);
    }

    @And("User checks {string} keycloakRealmRole cr status")
    public void userChecksKeycloakRealmRoleCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksKeycloakRealmRoleCrStatus(crName);
    }

    @And("User checks {string} keycloakRealm cr status")
    public void userChecksKeycloakRealmCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksKeycloakRealmCrStatus(crName);
    }

    @And("User checks {string} keycloak cr status")
    public void userChecksKeycloakCrStatus(final String crName) throws InterruptedException {
        codebaseResource.userChecksKeycloakCrStatus(crName);
    }
}
