package edp.pageobject.popups;

import static com.codeborne.selenide.Selenide.$x;

import com.codeborne.selenide.Condition;
import edp.core.annotations.Page;
import lombok.extern.log4j.Log4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

@Lazy
@Page
@Log4j
@Scope("prototype")
public class LogsPopup {

    private static final String POPUP_TITLE = "//h1[text()='Logs: %s']";
    private static final String CLOSE_BUTTON = POPUP_TITLE + "/../..//button[@aria-label='Close']";
    private static final String SELECT_POD_BUTTON = "//div[@id='pod-name-chooser-logs']";
    private static final String SELECT_CONTAINER_BUTTON = "//div[@id='container-name-chooser-logs']";


    public void logsPopupIsOpened(String podName) {
        $x(String.format(POPUP_TITLE, podName)).shouldBe(Condition.visible);
    }

    public void logsPopupIsClosed(String podName) {
        $x(String.format(POPUP_TITLE, podName)).shouldNotBe(Condition.visible);
    }

    public void closeLogsPopup(String podName) {
        $x(String.format(CLOSE_BUTTON, podName)).shouldBe(Condition.visible).click();
    }

    public void isSelectPodFieldForLogsContainsValue(String value) {
        $x(SELECT_POD_BUTTON).shouldBe(Condition.visible).shouldHave(Condition.text(value));
    }

    public void isSelectContainerFieldForLogsContainsValue(String value) {
        $x(SELECT_CONTAINER_BUTTON).shouldBe(Condition.visible).shouldHave(Condition.text(value));
    }
}
