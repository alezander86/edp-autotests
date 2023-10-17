package edp.stepdefs;

import com.codeborne.selenide.Configuration;
import com.codeborne.selenide.WebDriverRunner;
import com.codeborne.selenide.logevents.SelenideLogger;
import com.epam.reportportal.listeners.LogLevel;
import com.epam.reportportal.service.ReportPortal;
import edp.core.config.EdpComponentsConfig;
import edp.core.driver.interfaces.IWebDriverService;
import io.cucumber.core.api.Scenario;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.qameta.allure.selenide.AllureSelenide;
import java.io.File;
import java.util.Date;
import lombok.extern.log4j.Log4j;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import static edp.core.cache.TestCache.initializeTestCache;
import static edp.engine.httpclient.SecureClientInitializer.setDefaultSecureHttpClient;

@Log4j
@DirtiesContext
@SpringBootTest
@ContextConfiguration(classes = EdpComponentsConfig.class)
public class CucumberHook extends AbstractJUnit4SpringContextTests {
    @Autowired
    private IWebDriverService webDriverService;

    @Before(order = 1)
    public void preSetUp(Scenario scenario) {
        initializeTestCache();
        Configuration.timeout = 30_000;
        Configuration.fastSetValue = true;
        Configuration.screenshots = false;
        Configuration.savePageSource = false;
        Configuration.pageLoadStrategy = "eager";
        SelenideLogger.addListener("AllureSelenide",
                new AllureSelenide()
                        .screenshots(true)
                        .savePageSource(false));
        setDefaultSecureHttpClient();
        if(scenario.getSourceTagNames().contains("@UI")){
            webDriverService.initWebDriver();
        }
    }

    @After(value = "@UI")
    public void takeScraenshotOnFailure(Scenario scenario) {
        if(scenario.isFailed()) {
            File screenshot = ((TakesScreenshot) WebDriverRunner.getWebDriver()).getScreenshotAs(OutputType.FILE);
            ReportPortal.emitLog("message", LogLevel.INFO.name(), new Date(), screenshot);
        }
        if(WebDriverRunner.hasWebDriverStarted()) {
            WebDriverRunner.getWebDriver().quit();
        }
    }
}
