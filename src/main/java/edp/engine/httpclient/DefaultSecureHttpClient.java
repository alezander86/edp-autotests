package edp.engine.httpclient;

import edp.core.exceptions.TAFRuntimeException;
import io.vavr.control.Try;
import lombok.extern.log4j.Log4j;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.HttpClientConnectionManager;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.ssl.TrustStrategy;

import javax.net.ssl.SSLContext;
import java.util.List;
import java.util.Objects;

@Log4j
public final class DefaultSecureHttpClient {
    private HttpContext localContext = new BasicHttpContext();
    private HttpClient secureHttpClient;
    private CookieStore httpCookieStore = new BasicCookieStore();
    private int timeout = Integer.parseInt(System.getProperty("default.http.timeout", "400000"));
    public HttpContext getLocalContext() {
        return localContext;
    }
    HttpClient getSecureClient() {
        if (Objects.isNull(secureHttpClient)) {
            createDefaultSSLClient();
            log.info("Secure client was initialized successfully");
            localContext.setAttribute(HttpClientContext.COOKIE_STORE, httpCookieStore);
        }
        return secureHttpClient;
    }
    private void createDefaultSSLClient() {
        TrustStrategy trustStrategy = (cert, auth) -> true;
        SSLContext sslContext = Try.of(() -> SSLContexts.custom().loadTrustMaterial(null, trustStrategy).build())
                .getOrElseThrow(
                        exception -> new TAFRuntimeException(exception.getMessage(), exception)
                );
        SSLConnectionSocketFactory connectionSocketFactory = new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE);
        Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder.<ConnectionSocketFactory> create()
                .register("https", connectionSocketFactory)
                .register("http", new PlainConnectionSocketFactory())
                .build();
        HttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager(socketFactoryRegistry);
        RequestConfig config = RequestConfig.custom()
                .setConnectTimeout(timeout)
                .setConnectionRequestTimeout(timeout)
                .setSocketTimeout(timeout)
                .setCookieSpec(CookieSpecs.STANDARD)
                .build();
        secureHttpClient = HttpClientBuilder.create()
                .setSSLSocketFactory(connectionSocketFactory)
                .setConnectionManager(connectionManager)
                .setDefaultRequestConfig(config)
                .setDefaultCookieStore(httpCookieStore)
                .build();
    }
    public void clearCookies() {
        httpCookieStore.clear();
    }
    public void removeCookie(final String cookieName) {
        List<Cookie> cookies = getCookies();
        Cookie cookie = cookies.stream().filter(c -> c.getName().equals(cookieName)).findFirst().orElse(null);
        if (null != cookie) {
            cookies.remove(cookie);
            clearCookies();
            cookies.forEach(this::addCookie);
        } else {
            log.info(String.format("Couldn't remove '%s' cookie. The HttpClient doesn't contain it.", cookieName));
        }
    }
    public void addCookie(final Cookie cookie) {
        httpCookieStore.addCookie(cookie);
    }
    public List<Cookie> getCookies() {
        return httpCookieStore.getCookies();
    }
}

