package edp.core.driver.customwebdrivers;

import org.openqa.selenium.WebDriver;

public interface CustomWebDriver {
    WebDriver createCustomDriver(String browserType);
}
