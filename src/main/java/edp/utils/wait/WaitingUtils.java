package edp.utils.wait;

import com.codeborne.selenide.Selenide;
import com.codeborne.selenide.WebDriverRunner;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.awaitility.core.ConditionFactory;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

import static org.awaitility.Awaitility.await;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class WaitingUtils {

    public static final Integer DEFAULT_POLLING_INTERVAL = 5;
    public static final Integer CUSTOM_RESOURCE_CREATION_WAIT_TIME = 30;
    public static final Integer CUSTOM_RESOURCE_UPDATE_WAIT_TIME = 600;
    public static final Integer HTTP_REQUEST_WAIT_TIME = 60;
    public static final Integer TEKTON_PIPELINE_RUN_WAIT_DURATION = 1200;
    public static final Integer CODEBASE_IMAGE_STREAM_WAIT_DURATION = 1200;
    public static final Integer BRANCH_LAST_SUCCESS_BUILD_STATUS_WAIT_DURATION = 900;
    public static final Integer JENKINS_WAIT_DURATION = 1200;
    public static final Integer CUSTOM_RESOURCE_WAIT_DURATION = 1200;

    public static void waitFor(int seconds) {
        try {
            Thread.sleep(seconds * 1000L);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    public static void waitForPageReadyState() {
        new WebDriverWait(WebDriverRunner.getWebDriver(), 30).until(driver ->
                "complete".equals(Selenide.executeJavaScript("return document.readyState")));
    }

    public static boolean waitForUrlContainsLink(final String link) {
        return new WebDriverWait(WebDriverRunner.getWebDriver(), 30).until(driver ->
                driver.getCurrentUrl().contains(link));
    }

    public static ConditionFactory polling(int duration, int interval) {
        return await()
                .atMost(Duration.ofSeconds(duration))
                .pollInterval(Duration.ofSeconds(interval))
                .pollDelay(Duration.ofSeconds(1))
                .ignoreException(NullPointerException.class);
    }

    public static ConditionFactory polling(int seconds) {
        return polling(seconds, DEFAULT_POLLING_INTERVAL);
    }

    public static ConditionFactory pollingHttpRequest() {
        return polling(HTTP_REQUEST_WAIT_TIME)
                .ignoreExceptions();
    }

    public static ConditionFactory pollingCrCreation() {
        return polling(CUSTOM_RESOURCE_CREATION_WAIT_TIME);
    }

    public static ConditionFactory pollingCrUpdate() {
        return polling(CUSTOM_RESOURCE_UPDATE_WAIT_TIME);
    }

    public static ConditionFactory pollingTektonPipelineRun() {
        return polling(TEKTON_PIPELINE_RUN_WAIT_DURATION);
    }

    public static ConditionFactory pollingCustomResource() {
        return polling(CUSTOM_RESOURCE_WAIT_DURATION);
    }

    public static ConditionFactory pollingBranch() {
        return polling(BRANCH_LAST_SUCCESS_BUILD_STATUS_WAIT_DURATION);
    }

    public static ConditionFactory pollingCodebaseImageStream() {
        return polling(CODEBASE_IMAGE_STREAM_WAIT_DURATION)
                .ignoreExceptions();
    }

    public static ConditionFactory pollingJenkins() {
        return polling(JENKINS_WAIT_DURATION)
                .ignoreExceptions();
    }
}
