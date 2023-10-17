package edp.utils.wait;

import com.codeborne.selenide.Selenide;
import edp.core.exceptions.TAFRuntimeException;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang3.time.StopWatch;

import java.text.NumberFormat;
import java.util.Objects;
import java.util.function.Predicate;
import java.util.function.Supplier;

import static org.apache.commons.lang3.StringUtils.leftPad;

@Log4j
public class FlexWait<T> {
    private static final long DEFAULT_POLLING_INTERVAL = 250;
    private static final long DEFAULT_TIMEOUT = 20000;
    private static final String DEFAULT_FAILURE_MSG = "FlexWait failed. Name: %s. ";
    private final String name;
    private T arg;
    private Predicate<T> condition;
    private long pollingInterval = DEFAULT_POLLING_INTERVAL;
    private long timeout = DEFAULT_TIMEOUT;
    private String failureMsg;
    private final boolean failIfOverdue = true;
    private boolean conditionMatchedInTime;
    private Supplier<String> msgSupplier;
    private Runnable finallyRun;

    public FlexWait(final String name) {
        this.name = name;
        this.failureMsg = String.format(DEFAULT_FAILURE_MSG, name);
    }

    public FlexWait<T> during(final long ms) {
        this.timeout = ms;
        return this;
    }

    public FlexWait<T> every(final long ms) {
        this.pollingInterval = ms;
        return this;
    }

    public FlexWait<T> tryTo(final Predicate<T> condition, final T arg) {
        this.condition = condition;
        this.arg = arg;
        return this;
    }

    public FlexWait<T> tryTo(final Predicate<T> condition) {
        this.condition = condition;
        return this;
    }

    public FlexWait<T> withFailMsg(final String failureMsg) {
        this.failureMsg += failureMsg;
        return this;
    }

    public FlexWait<T> finallyRun(final Runnable finallyRun) {
        this.finallyRun = finallyRun;
        return this;
    }

    private void debugElapsedTime(final long millis) {
        final long logMillis = Math.round(millis / 1000f) * 1000L;
        log.debug(String.format("%s ms waiting...", leftPad(NumberFormat.getInstance().format(logMillis), 6)));
    }

    private void executeFinallyRun() {
        if (Objects.nonNull(finallyRun)) {
            finallyRun.run();
        }
    }

    private void updateFailureMsgWithPostWaitMsg() {
        if (Objects.nonNull(msgSupplier)) {
            failureMsg += msgSupplier.get();
        }
    }

    public void executeWithoutResult() {
        execute();
        if (!conditionMatchedInTime && failIfOverdue) {
            updateFailureMsgWithPostWaitMsg();
            throw new TAFRuntimeException(failureMsg);
        }
    }

    public FlexWait<T> executeWithResult() {
        execute();
        return this;
    }

    private void execute() {
        log.info(String.format("%s started", name));
        conditionMatchedInTime = false;
        final StopWatch waitTimer = new StopWatch();
        waitTimer.start();
        while (waitTimer.getTime() < timeout) {
            Selenide.sleep(pollingInterval);
            if (condition.test(arg)) {
                conditionMatchedInTime = true;
                break;
            }
            debugElapsedTime(waitTimer.getTime());
        }
        log.info(String.format("%s took: %s", name, waitTimer.getTime()));
        executeFinallyRun();
    }

    public boolean isSuccess() {
        return this.conditionMatchedInTime;
    }

    /**
     * Updates failure msg with the result of the supplier. Supplier is executed right before a failure.
     */
    public FlexWait<T> finallyUpdateFailMsgWith(final Supplier<String> msgSupplier) {
        this.msgSupplier = msgSupplier;
        return this;
    }

}
