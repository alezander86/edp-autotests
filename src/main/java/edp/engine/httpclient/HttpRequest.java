package edp.engine.httpclient;

import edp.core.cache.TestCache;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.exceptions.TAFRuntimeException;
import edp.engine.httpclient.errorhandler.DefaultErrorHandler;
import io.vavr.control.Try;
import lombok.extern.log4j.Log4j;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.*;
import org.apache.http.cookie.Cookie;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.opentest4j.TestAbortedException;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static com.codeborne.selenide.Selenide.sleep;
import static edp.engine.httpclient.SecureClientInitializer.getDefaultSecureHttpClient;
import static edp.utils.strings.StringsHelper.encode;
import static java.lang.String.format;

@Log4j
public class HttpRequest {
    private boolean withAuth;
    private String login;
    private String password;
    private final HttpRequestBase rawRequest;
    private boolean logResponseBody = true;
    private String succeededLog;
    private String requestLog;
    private String responseLog;
    private final DefaultErrorHandler errorHandler = new DefaultErrorHandler();

    // ***************************************************************************************************************
    private HttpRequest(final String url, final HttpMethod method) {
        if (method.equals(HttpMethod.GET)) {
            rawRequest = new HttpGet(url);
        } else if (method.equals(HttpMethod.PUT)) {
            rawRequest = new HttpPut(url);
        } else if (method.equals(HttpMethod.POST)) {
            rawRequest = new HttpPost(url);
        } else if (method.equals(HttpMethod.DELETE)) {
            rawRequest = new HttpDelete(url);
        } else if (method.equals(HttpMethod.PATCH)) {
            rawRequest = new HttpPatch(url);
        } else if (method.equals(HttpMethod.DELETE_WITH_BODY)) {
            rawRequest = new HttpDeleteWithBody(url);
        } else if (method.equals(HttpMethod.OPTIONS)) {
            rawRequest = new HttpOptions(url);
        } else {
            throw new TAFRuntimeException(method + " is unsupported for now!");
        }
    }

    public static HttpRequest get(final String url) {
        return new HttpRequest(url, HttpMethod.GET);
    }

    public static HttpRequest put(final String url) {
        return new HttpRequest(url, HttpMethod.PUT);
    }

    public static HttpRequest post(final String url) {
        return new HttpRequest(url, HttpMethod.POST);
    }

    public static HttpRequest patch(final String url) {
        return new HttpRequest(url, HttpMethod.PATCH);
    }

    public static HttpRequest delete(final String url) {
        return new HttpRequest(url, HttpMethod.DELETE);
    }

    public static HttpRequest deleteWithBody(final String url) {
        return new HttpRequest(url, HttpMethod.DELETE_WITH_BODY);
    }

    private static boolean isBodyApplicableTo(final HttpRequestBase request) {
        return (request.getClass().equals(HttpPut.class) || request.getClass().equals(HttpPatch.class)
                || request.getClass().equals(HttpPost.class) || request.getClass().equals(HttpDeleteWithBody.class));
    }

    public HttpRequest addHeader(final String key, final String value) {
        rawRequest.addHeader(key, value);
        return this;
    }

    public HttpRequest addAccept(final String value) {
        return addHeader("Accept", value);
    }

    public HttpRequest addContentType(final String value) {
        return addHeader("Content-Type", value);
    }

    public HttpRequest addBasicAuth(final String login, final String password) {
        withAuth = true;
        this.login = login;
        this.password = password;
        String encodedAuthorization = "Basic " + encode(login + ":" + password);
        addHeader("Authorization", encodedAuthorization);
        return this;
    }

    public HttpRequest addBody(final String body) {
        if (isBodyApplicableTo(rawRequest)) {
            Try.run(() -> ((HttpEntityEnclosingRequestBase) rawRequest).setEntity(new ByteArrayEntity(body.getBytes(StandardCharsets.UTF_8))))
                    .getOrElseThrow(exception -> {
                        log.error("Exception during assign body to request", exception);
                        return new TAFRuntimeException("Exception during assign body to request", exception);
                    });
        } else {
            log.error("Cannot assign body to this http method!");
        }
        return this;
    }

    public HttpRequest addBodyAsFormData(final Map<String, String> formData) {
        StringBuilder formBuider = new StringBuilder();
        for (Map.Entry<String, String> formEntry : formData.entrySet()) {
            Try.run(() -> {
                formBuider.append(URLEncoder.encode(formEntry.getKey(), StandardCharsets.UTF_8.name()));
                formBuider.append("=");
                formBuider.append(URLEncoder.encode(formEntry.getValue(), StandardCharsets.UTF_8.name()));
                formBuider.append("&");
            }).getOrElseThrow(exception -> {
                log.error("constructing groovy failed", exception);
                throw new TAFRuntimeException("constructing groovy failed", exception);
            });
        }
        formBuider.deleteCharAt(formBuider.length() - 1);
        return addBody(formBuider.toString());
    }

    public HttpRequest doNotLogResponseBody() {
        logResponseBody = false;
        return this;
    }

    public HttpRequest addBearerTokenAuth(final String accessToken) {
        addHeader("Authorization", format("Bearer %s", accessToken));
        return this;
    }

    public HttpRequest addAccessToken() {
        if (TestCache.containsKey(TestCacheKey.ACCESS_TOKEN)) {
            return addBearerTokenAuth(TestCache.get(TestCacheKey.ACCESS_TOKEN, String.class));
        }
        return this;
    }

    private void printLogs() {
        log.info("================================ REQUEST LOG ================================");
        log.info(requestLog);
        log.info("================================ REQUEST LOG END ================================");
        log.info("================================ RESPONSE LOG ================================");
        log.info(responseLog);
        log.info("================================ RESPONSE LOG END ================================");
    }

    public HttpResponseWrapper sendAndGetResponse() {
        return sendAndGetResponse(getDefaultSecureHttpClient().getLocalContext());
    }

    public HttpResponseWrapper sendAndGetResponse(final int expectedResponseCode) {
        HttpResponseWrapper response = sendAndGetResponse(getDefaultSecureHttpClient().getLocalContext());
        errorHandler.checkResponseCodeAndThrowsException(rawRequest, response, expectedResponseCode, requestLog, responseLog);
        return response;
    }

    public HttpResponseWrapper sendAndGetResponse(final HttpContext ctx) {
        try {
            logRequest(rawRequest);
            HttpResponse httpResponse = getHttpClient().execute(rawRequest, ctx);
            HttpResponseWrapper response1 = new HttpResponseWrapper(httpResponse);
            logResponse(response1);
            printLogs();
            return response1;
        } catch (IOException e) {
            throw new TestAbortedException(e.getMessage());
        }
    }

    public HttpResponseWrapper sendRequestWithRetry(final int retryCount, final int statusCode) {
        HttpResponseWrapper response;
        for (int i = 0; i < retryCount; i++) {
            response = sendAndGetResponse(-1);
            sleep(2000);
            if (response.getStatusCode() == statusCode) {
                return response;
            }
        }
        return sendAndGetResponse(statusCode);
    }

    private void logRequest(final HttpRequestBase rawRequest) throws IOException {
        StringBuilder requestDescription = new StringBuilder("=== REQUEST ===\n");
        succeededLog = rawRequest.getRequestLine().toString();
        requestDescription.append(rawRequest.getRequestLine().toString()).append("\n");
        for (Header header : rawRequest.getAllHeaders()) {
            if (!header.getName().equals("Authorization")) {
                requestDescription.append(header).append("\n");
            }
        }
        requestDescription.append("COOKIES:").append("\n");
        for (Cookie cookie : getDefaultSecureHttpClient().getCookies()) {
            requestDescription.append(cookie).append("\n");
        }
        if (withAuth) {
            requestDescription.append("User: ").append(login).append("/");
        }
        if (isBodyApplicableTo(rawRequest)) {
            HttpEntity entity = ((HttpEntityEnclosingRequestBase) rawRequest).getEntity();
            if (Objects.nonNull(entity)) {
                requestDescription.append(EntityUtils.toString(entity));
            }
        }
        requestDescription.append("\n");
        requestLog = requestDescription.toString();
    }

    private void logResponse(final HttpResponseWrapper response) {
        StringBuilder responseDescription = new StringBuilder("=== RESPONSE ===\n");
        succeededLog = format("%s completed with code %s", succeededLog,
                response.getRawResponse().getStatusLine().toString());
        responseDescription.append(response.getRawResponse().getStatusLine().toString()).append("\n");
        for (Header header : response.getRawResponse().getAllHeaders()) {
            responseDescription.append(header).append("\n");
        }
        if (logResponseBody) {
            responseDescription.append(response.getBody()).append("\n");
        } else {
            responseDescription.append("-skip-body-\n");
        }
        List<Cookie> cookies = getDefaultSecureHttpClient().getCookies();
        if (!cookies.isEmpty()) {
            responseDescription.append("Cookies:\n");
            for (Cookie cookie : cookies) {
                responseDescription.append("Cookie: ").append(cookie).append("\n");
            }
        }
        responseLog = responseDescription.toString();
    }

    private HttpClient getHttpClient() {
        return IHttpClientFactory.getDefaultSecureClient();
    }

    public enum HttpMethod {
        GET, PUT, POST, DELETE, DELETE_WITH_BODY, OPTIONS, HEAD, CONNECT, TRACE, PATCH
    }

    public enum ContentType {
        APPLICATION_XML("application/xml"),
        APPLICATION_JSON("application/json;charset=utf-8"),
        APPLICATION_PDF("application/pdf;charset=UTF-8"),
        APPLICATION_OCTET_STREAM("application/octet-stream"), FORM_DATA("application/x-www-form-urlencoded"),
        FORM_DATA_WITH_CHARSET("application/x-www-form-urlencoded; charset=UTF-8"),
        ANY("*/*"),
        MOBILE_USER_AGENT("Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 "
                + "(KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 "
                + "(compatible; Googlebot/2.1; +http://www.google.com/bot.html)"),
        PLAIN_TEXT("text/plain;charset=UTF-8"),
        XML("text/xml;charset=UTF-8"),
        TEXT_JAVASCRIPT("text/javascript"),
        PKPASS("application/vnd.apple.pkpass"),
        IMAGE_PNG("image/png"),
        TEXT_HTML("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"),
        CTFS_ACCEPT_HEADER("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"),
        CTFS_CONTENT_HEADER("application/x-www-form-urlencoded");
        private final String value;

        ContentType(final String value) {
            this.value = value;
        }

        @Override
        public String toString() {
            return value;
        }
    }
}
