package edp.engine.httpclient;

import edp.core.exceptions.TAFRuntimeException;
import lombok.extern.log4j.Log4j;
import org.apache.http.Header;
import org.apache.http.HttpResponse;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@Log4j
public class HttpResponseWrapper {
    private final int statusCode;
    private String body;
    private String bodyEncoded;
    private HttpResponse rawResponse;
    private byte[] fileEntity;
    public HttpResponseWrapper(final HttpResponse httpResponse) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        rawResponse = httpResponse;
        statusCode = httpResponse.getStatusLine().getStatusCode();
        if (statusCode == 204) {
            bodyEncoded = null;
        } else {
            try {
                httpResponse.getEntity().writeTo(byteArrayOutputStream);
                fileEntity = byteArrayOutputStream.toByteArray();
                bodyEncoded = new String(fileEntity, StandardCharsets.UTF_8);
                body = new String(bodyEncoded.getBytes(StandardCharsets.UTF_8));
            } catch (IOException e) {
                log.error(e.getMessage(), e);
                throw new TAFRuntimeException(e.getMessage());
            }
        }
    }
    public byte[] getFileEntity() {
        return fileEntity;
    }
    public String getBody() {
        return body;
    }
    public String getBodyEncoded() {
        return bodyEncoded;
    }
    public int getStatusCode() {
        return statusCode;
    }

    public Header[] getHeader(String fieldName) {
        return rawResponse.getHeaders(fieldName);
    }
    HttpResponse getRawResponse() {
        return rawResponse;
    }
}
