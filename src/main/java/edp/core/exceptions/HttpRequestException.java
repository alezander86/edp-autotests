package edp.core.exceptions;

public class HttpRequestException extends RuntimeException {
    public HttpRequestException() {
        super();
    }
    public HttpRequestException(String message) {
        super(message);
    }
    public HttpRequestException(String message, Throwable exception) {
        super(message, exception);
    }
}

