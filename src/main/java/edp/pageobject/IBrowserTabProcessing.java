package edp.pageobject;

import com.codeborne.selenide.Selenide;

import com.codeborne.selenide.WebDriverRunner;
import java.util.ArrayList;

import static com.codeborne.selenide.WebDriverRunner.getWebDriver;

public interface IBrowserTabProcessing {
    static void switchToFirstTab() {
        Selenide.switchTo().window(0);
    }

    static void switchToNewTab() {
        getWebDriver().switchTo().window(new ArrayList<>(getWebDriver().getWindowHandles()).get(1));
    }

    static void closeCurrentTab() {
        getWebDriver().close();
    }

    static void switchToTab(final int tabIndex) {
        Selenide.switchTo().window(tabIndex);
    }

    static void reloadPage() {
        Selenide.open(WebDriverRunner.getWebDriver().getCurrentUrl());
    }

    static String getPageUrl() {
        return WebDriverRunner.getWebDriver().getCurrentUrl();
    }
}
