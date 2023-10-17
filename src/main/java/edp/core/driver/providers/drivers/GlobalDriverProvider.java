package edp.core.driver.providers.drivers;

import static io.vavr.API.$;
import static io.vavr.API.Case;
import static io.vavr.API.Match;

import edp.core.annotations.DriverProvider;
import edp.core.config.TestsConfig;
import edp.core.driver.customwebdrivers.CustomWebDriver;
import edp.core.driver.interfaces.IWebDriverProvider;
import edp.core.exceptions.TAFRuntimeException;
import lombok.extern.log4j.Log4j;
import org.openqa.selenium.WebDriver;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.beans.factory.annotation.Qualifier;

@Log4j
@DriverProvider
public class GlobalDriverProvider implements IWebDriverProvider {
    @Autowired
    private TestsConfig testsConfig;
    @Autowired
    @Qualifier("chromeDriver")
    private CustomWebDriver chromeWebDriver;

    @Override
    public WebDriver createWebDriver() {
        log.info("creating web driver");
        return Match(testsConfig.getBrowserName()).of(
                Case($("chrome"), () -> chromeWebDriver.createCustomDriver(testsConfig.getBrowserType())),
                Case($(), () -> {
                    throw new TAFRuntimeException("Browser isn't selected or isn't supported.");
                })
        );
    }
}
