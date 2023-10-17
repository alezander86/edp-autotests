package edp.stepdefs.http;

import edp.engine.httpclient.HttpRequest;
import edp.engine.httpclient.HttpResponseWrapper;
import org.springframework.stereotype.Service;

import java.util.function.Consumer;

import static edp.utils.wait.WaitingUtils.pollingHttpRequest;

@Service
public class CommonHttpSteps {

    public HttpResponseWrapper waitResponseStatusCode(HttpRequest request, int expectedStatusCode) {
        return pollingHttpRequest().until(request::sendAndGetResponse, r -> r.getStatusCode() == expectedStatusCode);
    }

    public void waitResponseCondition(HttpRequest request, Consumer<HttpResponseWrapper> consumer) {
        pollingHttpRequest().untilAsserted(() -> {
            HttpResponseWrapper response = request.sendAndGetResponse();
            consumer.accept(response);
        });
    }

}



