package edp.core.driver;

import com.codeborne.selenide.WebDriverRunner;
import edp.core.annotations.DriverService;
import edp.core.driver.interfaces.IWebDriverProvider;
import edp.core.driver.interfaces.IWebDriverService;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

@Lazy
@Log4j
@DriverService
public class WebDriverService implements IWebDriverService {

    @Autowired
    private IWebDriverProvider driverProvider;

    @Override
    public void initWebDriver() {
        log.info("trying to set up web driver");
        WebDriverRunner.setWebDriver(driverProvider.createWebDriver());
        WebDriverRunner.getWebDriver().manage().window().maximize();
        WebDriverRunner.getWebDriver().manage().deleteAllCookies();
        WebDriverRunner.clearBrowserCache();
        log.info("web driver has been initialized");
    }
}