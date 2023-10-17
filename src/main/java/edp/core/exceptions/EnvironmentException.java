package edp.core.exceptions;

public class EnvironmentException extends RuntimeException {
    public EnvironmentException() {
        super();
    }
    public EnvironmentException(String message) {
        super(message);
    }
    public EnvironmentException(Throwable exception) {
        super(exception);
    }
    public EnvironmentException(String message, Throwable exception) {
        super(message, exception);
    }
}
