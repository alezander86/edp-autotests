package edp.engine.httpclient.errorhandler;

import edp.core.exceptions.EnvironmentException;
import edp.core.exceptions.HttpRequestException;
import edp.engine.httpclient.HttpResponseWrapper;
import lombok.extern.log4j.Log4j;
import org.apache.http.client.methods.HttpRequestBase;
import org.springframework.stereotype.Component;

import java.text.MessageFormat;

import static java.lang.String.format;

@Log4j
@Component
public class DefaultErrorHandler {
    public void checkResponseCodeAndThrowsException(final HttpRequestBase requestBase, final HttpResponseWrapper responseWrapper,
                                                    final int expectedResponseCode, final String requestLog, final String responseLog) {
        if (responseWrapper.getStatusCode() > 499 && responseWrapper.getStatusCode() < 512) {
            log.error(format("Request %s failed because status code is in range 500-511", requestBase.getURI()));
            throw new EnvironmentException(format("Request %s failed because status code is in range 500-511", requestBase.getURI()));
        }
        if (expectedResponseCode != -1) {
            int actualCode = responseWrapper.getStatusCode();
            if (actualCode != expectedResponseCode) {
                throw new HttpRequestException(MessageFormat.format("Expected code {0} but actual is {1}\n" +
                        "EXCEPTION DETAILS:\n{2}\n{3}", expectedResponseCode, responseWrapper.getStatusCode(), requestLog, responseLog));
            }
        }
    }
}
