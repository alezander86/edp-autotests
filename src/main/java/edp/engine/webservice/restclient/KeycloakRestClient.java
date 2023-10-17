package edp.engine.webservice.restclient;

import edp.core.annotations.RestClient;
import edp.core.config.EdpComponentsConfig;
import edp.core.exceptions.EnvironmentException;
import edp.engine.httpclient.HttpRequest;
import edp.engine.httpclient.HttpResponseWrapper;
import io.vavr.control.Try;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import java.util.Map;

import static edp.engine.httpclient.HttpRequest.ContentType.APPLICATION_JSON;
import static edp.engine.httpclient.HttpRequest.ContentType.FORM_DATA;

@Lazy
@Log4j
@RestClient
public class KeycloakRestClient {

    @Autowired
    private EdpComponentsConfig edpComponentsConfig;

    private static final String TOKEN_URL = "%s/realms/%s-main/protocol/openid-connect/token";

    public HttpResponseWrapper sendGetTokenRequest(Map<String, String> params) {
        String url = String.format(TOKEN_URL, edpComponentsConfig.getKeycloakUrl(), edpComponentsConfig.getNamespace());
        return Try.of(() ->
                HttpRequest.post(url).addAccept(APPLICATION_JSON.toString())
                        .addContentType(FORM_DATA.toString())
                        .addBodyAsFormData(params)
                        .sendAndGetResponse(200))
                .onFailure(exception -> {
                    log.error(String.format("Failed to execute token request by following url %s", url));
                    throw new EnvironmentException(String.format("Failed to execute token request by following url %s", url), exception);
                })
                .get();

    }
}


