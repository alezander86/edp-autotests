package edp.core.driver.customwebdrivers;

import static io.vavr.API.$;
import static io.vavr.API.Case;
import static io.vavr.API.Match;

import edp.core.config.TestsConfig;
import edp.core.exceptions.TAFRuntimeException;
import io.github.bonigarcia.wdm.WebDriverManager;
import io.vavr.control.Try;
import java.net.URI;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import org.openqa.selenium.Capabilities;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("chromeDriver")
public class ChromeWebDriver implements CustomWebDriver{
    @Autowired
    private TestsConfig testsConfig;

    private static final List<String> CHROME_OPTIONS = Arrays.asList("--allow-running-insecure-content",
            "--ignore-certificate-errors", "--disable-popup-blocking", "--disable-dev-shm-usage", "--no-sandbox",
            "--disable-gpu", "--test-type");

    @Override
    public WebDriver createCustomDriver(String browserType) {
        return Match(browserType).of(
                Case($("local"), this::getLocalChromeDriver),
                Case($("remote"), this::getRemoteChromeDriver)
        );
    }

    private WebDriver getLocalChromeDriver() {
        WebDriverManager.chromedriver().setup();
        return new ChromeDriver(new ChromeOptions().addArguments(CHROME_OPTIONS));
    }
    private WebDriver getRemoteChromeDriver() {
        return Try.of(() -> new RemoteWebDriver(URI.create(testsConfig.getMoonUrl()).toURL(),
                        createRemoteChromeDriverOptions()))
        .getOrElseThrow(exception -> new TAFRuntimeException("Unable to create remote web driver", exception));
    }
    private Capabilities createRemoteChromeDriverCapabilities() {
        DesiredCapabilities capabilities = DesiredCapabilities.chrome();
        ChromeOptions chromeOptions = new ChromeOptions();
        capabilities.setCapability(CapabilityType.TAKES_SCREENSHOT, true);
        capabilities.setCapability(CapabilityType.ACCEPT_SSL_CERTS, true);
        capabilities.setCapability(CapabilityType.ACCEPT_INSECURE_CERTS, true);
        capabilities.setCapability("enableVNC", true);
        chromeOptions.addArguments(CHROME_OPTIONS);
        capabilities.setCapability(ChromeOptions.CAPABILITY, chromeOptions);
        return capabilities;
    }

    private Capabilities createRemoteChromeDriverOptions() {
        ChromeOptions  chromeOptions = new ChromeOptions();
        chromeOptions.setCapability(CapabilityType.BROWSER_VERSION, testsConfig.getBrowserVersion());
        chromeOptions.setCapability("moon:options", new HashMap<String, Object>() {{
            put("sessionTimeout", "20m");
            put("enableVideo", true);
        }});
        chromeOptions.setCapability(CapabilityType.TAKES_SCREENSHOT, true);
        chromeOptions.setCapability(CapabilityType.ACCEPT_SSL_CERTS, true);
        chromeOptions.setCapability(CapabilityType.ACCEPT_INSECURE_CERTS, true);
        chromeOptions.setCapability("enableVNC", true);
        chromeOptions.addArguments(CHROME_OPTIONS);
        return chromeOptions;
    }
}
