package edp;

import edp.utils.consts.Cucumber;
import edp.core.runner.CustomRunner;
import lombok.extern.log4j.Log4j;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@Log4j
@SpringBootApplication
public class CucumberConsoleApplication implements CommandLineRunner {

    public static void main(String[] args) {
        System.setProperty("allure.results.directory", "target/allure-results/");
        SpringApplication.run(CucumberConsoleApplication.class, args);
    }

    @Override
    public void run(String... args) {
        CustomRunner.main(ArrayUtils.addAll(Cucumber.COMMON_CUCUMBER_OPTIONS, args));
    }

}
