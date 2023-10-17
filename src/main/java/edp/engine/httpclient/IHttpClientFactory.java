package edp.engine.httpclient;

import org.apache.http.client.HttpClient;

public interface IHttpClientFactory {
    static HttpClient getDefaultSecureClient() {
        return SecureClientInitializer.getDefaultSecureHttpClient().getSecureClient();
    }
}
