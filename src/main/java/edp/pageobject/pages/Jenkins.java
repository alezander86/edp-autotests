package edp.pageobject.pages;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.Selenide;
import com.codeborne.selenide.SelenideElement;
import com.codeborne.selenide.WebDriverRunner;
import com.google.common.base.Optional;
import com.offbytwo.jenkins.JenkinsServer;
import com.offbytwo.jenkins.model.*;
import edp.core.annotations.Page;
import edp.core.cache.TestCache;
import edp.core.config.EdpComponentsConfig;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.core.exceptions.EnvironmentException;
import edp.core.exceptions.TAFRuntimeException;
import edp.core.service.kubernetes.KubernetesClientFactory;
import edp.core.service.kubernetes.SecretsProvider;
import edp.engine.httpclient.HttpRequest;
import edp.engine.httpclient.HttpResponseWrapper;
import edp.steps.SecretsSteps;
import edp.utils.wait.FlexWait;
import edp.utils.wait.WaitingUtils;
import io.cucumber.datatable.DataTable;
import io.vavr.control.Try;
import java.util.Objects;
import lombok.extern.log4j.Log4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.jupiter.api.Assertions;
import org.openqa.selenium.interactions.Actions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Predicate;

import static com.codeborne.selenide.Selenide.$$x;
import static com.codeborne.selenide.Selenide.$x;
import static edp.engine.httpclient.HttpRequest.ContentType.*;
import static edp.utils.wait.WaitingUtils.pollingJenkins;
import static edp.utils.wait.WaitingUtils.waitForPageReadyState;


@Lazy
@Page
@Scope("prototype")
@Log4j
public class Jenkins {
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;
    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private SecretsSteps secretsSteps;

    private static final String CODEBASE_JENKINS_FOLDER = "//a[@href='job/%s/']";
    private static final String CD_PIPELINE_JENKINS_FOLDER = "//a[@href='job/%s-cd-pipeline/']";
    private static final String CD_PIPELINE_OVERVIEW = "//a[contains(text(), '%s')]";
    private static final String CREATE_RELEASE_JOB = "//tr[@id='job_%s']";
    private static final String BUILD_JOB = "//tr[@id='job_%s']";
    private static final String BUILD_JOB_LINK = "//td[not(@class)]//a[contains(@href, '%s')]";
    private static final String CODE_REVIEW_JOB_LINK = "//td[not(@class)]//a[contains(@href, '%s')]";
    private static final String CD_PIPELINE_STAGE = "//tr[@id='job_%s']";
    private static final String MANAGE_JENKINS_BUTTON = "//a[contains(@href, 'manage')]";
    private static final String CONFIGURE_SYSTEM_BUTTON = "//div[@class='jenkins-section__item']//a[@href='configure']";
    private static final String GITLAB_CONNECTION_NAME_FIELD = "//input[@checkurl='/manage/descriptorByName/com.dabsquared.gitlabjenkins.connection.GitLabConnection/checkName']";
    private static final String GITLAB_HOST_URL_FIELD = "//input[@checkurl='/manage/descriptorByName/com.dabsquared.gitlabjenkins.connection.GitLabConnection/checkUrl']";
    private static final String GITHUB_HOST_URL_FIELD = "//input[@checkurl='/descriptorByName/com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig/checkUrl']";
    private static final String GITLAB_ACCESS_API_TOKEN_DROPDOWN = "//select[contains(@name, '_.apiTokenId')]";
    private static final String SAVE_BUTTON = "//button[text()='Save']";
    private static final String ADD_GITHUB_SERVER_BUTTON = "//button[text()='Add GitHub Server']";
    private static final String GITHUB_SERVER_BUTTON = "//li[@class='yuimenuitem first-of-type yui-button-selectedmenuitem']";
    private static final String GITHUB_CONNECTION_NAME_FIELD = "//div[@class='repeated-chunk']//input[@name='_.name']";
    private static final String GITHUB_ACCESS_API_TOKEN_DROPDOWN = "//select[contains(@fillurl,'config.GitHubServerConfig')]";
    private static final String GITHUB_PULL_REQUEST_SECTION = "//div[normalize-space(text())='GitHub Pull Request Builder']";
    private static final String GITHUB_ACCESS_TOKEN_GHPRB = "//select[contains(@fillurl,'/descriptorByName/org.jenkinsci.plugins.ghprb.GhprbGitHubAuth/fillCredentialsIdItems')]";
    private static final String CODE_INPUT = "//div[@class='CodeMirror-scroll cm-s-default']";
    private static final String STAGE_NAME_JOB_BUTTON = "//a[@href='job/%s/']";
    private static final String BUILD_WITH_PARAMETERS_BUTTON = "//span[text()='Build with Parameters']";
    private static final String BUILD_BUTTON = "//button[text()='Build']";
    private static final String JOB_INFO_PAGE = "//a[@class='build-status-link']";
    private static final String PIPELINE_PROGRESS_BAR = "//td[@class='build-caption-progress-bar']";
    private static final String VERSION_FOR_DEPLOY_DROPDOWN = "//div[@name='parameter']//select[@name='value']";
    private static final String PROCEED_BUTTON_IN_VERSION_INFORMATION_POPUP = "//button[text()='Proceed']";
    private static final String INPUT_REQUESTED_BUTTON = "//a[text()='Input requested']";
    private static final String PROSEED_TO_PROMOTE_BUTTON = "//a[text()='Proceed']";
    private static final String DASHBOARD_BUTTON = "//a[text()='Dashboard']";
    private static final String CODE_REVIEW_JOB = "//tr[@id='job_%s']";
    private static final String CREATE_CI_PROVISIONER = "%s/job/job-provisions/job/ci/createItem";
    private static final String CONFIGURE_CI_PROVISIONER = "%s/job/job-provisions/job/ci/job/%s/configSubmit";
    private static final String CONFIGURE_JENKINS_WORKERS = "%s/computer/%s/configSubmit";
    private static final String TRIGGER_JENKINS_JOB_URL = "%s/job/%s/job/%s/buildWithParameters";
    private static final String GET_USER_INPUT = "%s/job/%s/job/%s/1/wfapi/nextPendingInputAction";
    private static final String SET_USER_INPUT = "%s/job/%s/job/%s/1/input/UserInput/submit";
    private static final String PROCEED_QUALITY_GATE_URL = "%s/job/%s/job/%s/1/input/%s/proceedEmpty";
    private static final String JENKINS_SECRET_NAME = "jenkins-admin-token";

    public void clickCodebaseJenkinsFolder(String codebaseJenkinsFolder) {
        waitForPageReadyState();
        Selenide.sleep(5_000);
        //        $$x(String.format(CODEBASE_JENKINS_FOLDER,codebaseJenkinsFolder)).shouldHaveSize(1).first().click();
        $x(String.format(CODEBASE_JENKINS_FOLDER, codebaseJenkinsFolder))
                .waitUntil(Condition.visible, 5000).click();
    }

    public void clickCdPipelineJenkinsFolder(String cdPipelineName) {
        waitForPageReadyState();
        Selenide.sleep(5_000);
        //        $$x(String.format(CODEBASE_JENKINS_FOLDER,codebaseJenkinsFolder)).shouldHaveSize(1).first().click();
        $x(String.format(CD_PIPELINE_JENKINS_FOLDER, cdPipelineName)).waitUntil(Condition.visible, 5000)
                .click();
    }

    public void openCdPipelineOverview(String codebaseJenkinsFolder) {
        $x(String.format(CD_PIPELINE_OVERVIEW, codebaseJenkinsFolder)).shouldBe(Condition.visible).click();
    }

    public void createReleaseStatusShouldBeSuccess(String createReleaseJob) {
        Predicate<SelenideElement> checkStatus = status -> {
            $x(String.format(CREATE_RELEASE_JOB, createReleaseJob)).shouldBe(Condition.visible);
            Selenide.refresh();
            if (Objects.equals($x(String.format(CREATE_RELEASE_JOB, createReleaseJob)).getAttribute("class"),
                    " job-status-red")) {
                throw new TAFRuntimeException("Status of Create release job for %s is red");
            }
            return Try.of(() -> $x(String.format(CREATE_RELEASE_JOB, createReleaseJob))
                            .shouldHave(Condition.attribute("class", " job-status-blue")))
                    .isSuccess();
        };
        new FlexWait<SelenideElement>(String.format("wait for success status for %s create release job",
                createReleaseJob)).during(200000).tryTo(checkStatus).every(5000).executeWithoutResult();
    }

    public void buildJobStatusShouldBeSuccess(String buildJob) {
        Predicate<SelenideElement> checkStatus = status -> {
            $x(String.format(BUILD_JOB, buildJob)).shouldBe(Condition.visible);
            Selenide.refresh();
            if ($x(String.format(BUILD_JOB, buildJob)).getAttribute("class").equals(" job-status-red")) {
                throw new TAFRuntimeException("Status of Build job for %s is red");
            }
            return Try.of(() -> $x(String.format(BUILD_JOB, buildJob))
                            .shouldHave(Condition.attribute("class", " job-status-blue")))
                    .isSuccess();
        };
        new FlexWait<SelenideElement>(String.format("wait for success status for %s build job", buildJob))
                .during(12000000).tryTo(checkStatus).every(5000).executeWithoutResult();
    }

    public void cdPipelineStageStatusShouldBeSuccess(String cdPipelineStage) {
        Predicate<SelenideElement> checkStatus = status -> {
            $x(String.format(CD_PIPELINE_STAGE, cdPipelineStage)).shouldBe(Condition.visible);
            Selenide.refresh();
            return Try.of(() -> $x(String.format(BUILD_JOB, cdPipelineStage))
                            .shouldHave(Condition.attribute("class", " job-status-blue")))
                    .isSuccess();
        };
        new FlexWait<SelenideElement>(String.format("wait for success status for %s cd pipeline stage",
                cdPipelineStage)).during(500000).tryTo(checkStatus).every(5000).executeWithoutResult();
    }

    public void checkBuildStatusInJenkinsFolder(String jobName, String jenkinsFolder) {
        pollingJenkins()
                .untilAsserted(() -> {
                    JenkinsServer jenkins = new JenkinsServer(new URI(edpComponentsConfig.getJenkinsUrl())
                            , getJenkinsSecretFieldValue("username"), getJenkinsSecretFieldValue("password"));

                    JobWithDetails job = jenkins.getJob(jenkinsFolder);
                    Optional<FolderJob> folder = jenkins.getFolderJob(job);
                    Assertions.assertNotNull(job);

                    Job folderJob = jenkins.getJob(folder.get(), jobName);
                    Assertions.assertNotNull(folderJob, String.format("Waiting for job to be available: %s", jobName));

                    Build build = jenkins.getJob(folder.get(), jobName).getBuildByNumber(1);
                    Assertions.assertNotNull(build.details().getResult(),
                            String.format("Waiting for job completion: %s", jobName));

                    Assertions.assertEquals("SUCCESS", jenkins.getJob(folder.get(), jobName)
                                    .getLastBuild().details().getResult().name(),
                            String.format("Waiting for job completion as SUCCESS: %s", jobName));
                });
    }

    public void checkSecondBuildStatusInJenkinsFolder(String jobName, String jenkinsFolder) {
        pollingJenkins()
                .untilAsserted(() -> {
                    JenkinsServer jenkins = new JenkinsServer(new URI(edpComponentsConfig.getJenkinsUrl())
                            , getJenkinsSecretFieldValue("username"), getJenkinsSecretFieldValue("password"));

                    JobWithDetails job = jenkins.getJob(jenkinsFolder);
                    Optional<FolderJob> folder = jenkins.getFolderJob(job);
                    Assertions.assertNotNull(job);

                    Job folderJob = jenkins.getJob(folder.get(), jobName);
                    Assertions.assertNotNull(folderJob, String.format("Waiting for job to be available: %s", jobName));

                    Build build = jenkins.getJob(folder.get(), jobName).getBuildByNumber(2);
                    Assertions.assertNotNull(build.details().getResult(),
                            String.format("Waiting for job completion: %s", jobName));

                    Assertions.assertEquals("SUCCESS", jenkins.getJob(folder.get(), jobName)
                                    .getLastBuild().details().getResult().name(),
                            String.format("Waiting for job completion as SUCCESS: %s", jobName));
                });
    }

    public void checkJobStatusInJenkinsFolderForDefaultBranch(String createReleaseJob, String jenkinsFolder) {
        pollingJenkins()
                .untilAsserted(() -> {
                    JenkinsServer jenkins = new JenkinsServer(new URI(edpComponentsConfig.getJenkinsUrl())
                            , getJenkinsSecretFieldValue("username"), getJenkinsSecretFieldValue("password"));

                    JobWithDetails job = jenkins.getJob(jenkinsFolder);
                    Optional<FolderJob> folder = jenkins.getFolderJob(job);
                    Assertions.assertNotNull(job);

                    Build build = jenkins.getJob(folder.get(), createReleaseJob).getBuildByNumber(1);
                    Assertions.assertNotNull(build.details().getResult(),
                            String.format("Waiting for job completion: %s", createReleaseJob));

                    Assertions.assertEquals("SUCCESS", jenkins.getJob(folder.get(), createReleaseJob)
                                    .getLastBuild().details().getResult().name(),
                            String.format("Waiting for job completion as SUCCESS: %s", createReleaseJob));
                });
    }

    public void checkJobStatusInJenkinsFolderForNewBranch(String createReleaseJob, String jenkinsFolder) {
        pollingJenkins()
                .untilAsserted(() -> {
                    JenkinsServer jenkins = new JenkinsServer(new URI(edpComponentsConfig.getJenkinsUrl())
                            , getJenkinsSecretFieldValue("username"), getJenkinsSecretFieldValue("password"));

                    JobWithDetails job = jenkins.getJob(jenkinsFolder);
                    Optional<FolderJob> folder = jenkins.getFolderJob(job);
                    Assertions.assertNotNull(job);

                    Build build = jenkins.getJob(folder.get(), createReleaseJob).getBuildByNumber(2);
                    Assertions.assertNotNull(build.details().getResult(),
                            String.format("Waiting for job completion: %s", createReleaseJob));

                    Assertions.assertEquals("SUCCESS", jenkins.getJob(folder.get(), createReleaseJob)
                                    .getLastBuild().details().getResult().name(),
                            String.format("Waiting for job completion as SUCCESS: %s", createReleaseJob));
                });
    }

    public void stopBuildInJenkinsFolder(String jobNameDefault, String jenkinsFolder)
            throws IOException, URISyntaxException {
        JenkinsServer jenkins = new JenkinsServer(new URI(edpComponentsConfig.getJenkinsUrl())
                , getJenkinsSecretFieldValue("username"), getJenkinsSecretFieldValue("password"));

        JobWithDetails job = jenkins.getJob(jenkinsFolder);
        Optional<FolderJob> folder = jenkins.getFolderJob(job);
        Assertions.assertNotNull(job);

        pollingJenkins()
                .ignoreExceptionsInstanceOf(NullPointerException.class)
                .untilAsserted(() -> {
                    Build build = jenkins.getJob(folder.get(), jobNameDefault).getBuildByNumber(1);
                    Assertions.assertTrue(build.details().isBuilding(), String.format("Waiting for job completion: %s",
                            jobNameDefault));
                    build.Stop();
                });
    }

    public void triggerJobInJenkinsFolder(String name, String cdPipelinejenkinsFolder)
            throws URISyntaxException, IOException {
        JenkinsServer jenkins = new JenkinsServer(new URI(edpComponentsConfig.getJenkinsUrl())
                , getJenkinsSecretFieldValue("username"), getJenkinsSecretFieldValue("password"));

        JobWithDetails job = jenkins.getJob(cdPipelinejenkinsFolder);
        Optional<FolderJob> folder = jenkins.getFolderJob(job);
        Assertions.assertNotNull(job);

        pollingJenkins()
                .ignoreExceptionsInstanceOf(NullPointerException.class)
                .untilAsserted(() -> {
                    Job cdJob = jenkins.getJob(folder.get(), name);
                    Assertions.assertNotNull(cdJob, String.format("Waiting for job to be available: %s", name));
                });
        String url = String.format(TRIGGER_JENKINS_JOB_URL, edpComponentsConfig.getJenkinsUrl(),
                cdPipelinejenkinsFolder, name);

        HttpResponseWrapper response = Try.of(() ->
                        HttpRequest.post(url).addAccept(ANY.toString())
                                .addContentType(APPLICATION_JSON.toString())
                                .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                        getJenkinsSecretFieldValue("password"))
                                .sendAndGetResponse(201))
                .onFailure(exception -> {
                    log.error(String.format("Failed to execute trigger jenkins job request by following url %s", url));
                    throw new EnvironmentException(
                            String.format("Failed to execute trigger jenkins job request by following url %s", url),
                            exception);
                }).get();
        log.info("Jenkins job started");
    }

    public void stageStatusShouldBeSuccess(String cdPipelineStage) {
        Predicate<SelenideElement> checkStatus = status -> {
            $x(String.format(CD_PIPELINE_STAGE, cdPipelineStage)).shouldBe(Condition.visible);
            Selenide.refresh();
            return Try.of(() -> $x(String.format(BUILD_JOB, cdPipelineStage))
                            .shouldHave(Condition.attribute("class", " job-status-blue")))
                    .isSuccess();
        };
        new FlexWait<SelenideElement>(
                String.format("wait for success status for %s cd pipeline stage", cdPipelineStage))
                .during(500000).tryTo(checkStatus).every(5000).executeWithoutResult();
    }

    public void clickManageJenkinsButton() {
        Selenide.sleep(2_000);
        $x(MANAGE_JENKINS_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickConfigureSystemButton() {
        $x(CONFIGURE_SYSTEM_BUTTON).shouldBe(Condition.visible).click();
    }

    public void enterGitlabConnectionName(String gitlabConnectionName) {
        $x(GITLAB_CONNECTION_NAME_FIELD).shouldBe(Condition.visible).sendKeys(gitlabConnectionName);
    }

    public void enterGitlabHostUrl(String gitlabHostUrl) {
        $x(GITLAB_HOST_URL_FIELD).shouldBe(Condition.visible).sendKeys(gitlabHostUrl);
    }

    public void enterGithubHostUrl(String githubHostUrl) {
        Selenide.sleep(1000);
        $x(GITHUB_HOST_URL_FIELD).shouldBe(Condition.visible).sendKeys(githubHostUrl);
    }

    public void selectGitlabAccessApiToken(String gitlabAccessApiToken) {
        $x(GITLAB_ACCESS_API_TOKEN_DROPDOWN).scrollIntoView(false).shouldBe(Condition.visible)
                .selectOptionByValue(gitlabAccessApiToken);
        //        $x(GITLAB_ACCESS_API_TOKEN_DROPDOWN).shouldHave(Condition.exactValue(gitlabAccessApiToken));
    }

    public void clickSaveButton() {
        $x(SAVE_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickAddGithubServerButton() {
        $x(ADD_GITHUB_SERVER_BUTTON).scrollIntoView("{block: \"center\"}");
        Selenide.sleep(1_000);
        $x(ADD_GITHUB_SERVER_BUTTON).hover().click();
        //        $x(ADD_GITHUB_SERVER_BUTTON).shouldHave(Condition.exactText("Add GitHub Server"));
    }

    public void clickGithubServerButton() {
        Selenide.sleep(1_000);
        $x(GITHUB_SERVER_BUTTON).click();
    }

    public void enterGithubConnectionName(String githubConnectionName) {
        waitForPageReadyState();
        Selenide.sleep(1_000);
        $x(GITHUB_CONNECTION_NAME_FIELD).scrollIntoView(false).setValue(githubConnectionName);
    }

    public void selectGithubAccessApiToken(String githubAccessToken) {
        $x(GITHUB_ACCESS_API_TOKEN_DROPDOWN).shouldBe(Condition.visible).selectOptionByValue(githubAccessToken);
    }

    public void selectsTokenForPullRequestBuilder(String githubAccessApiToken) {
        $x(GITHUB_PULL_REQUEST_SECTION).scrollIntoView("{block: \"center\"}");
        $x(GITHUB_ACCESS_TOKEN_GHPRB).shouldBe(Condition.visible).selectOptionByValue(githubAccessApiToken);
    }

    public void clickStageNameJob(String stageName) {
        $x(String.format(STAGE_NAME_JOB_BUTTON, stageName)).hover().shouldBe(Condition.visible).click();
    }

    public void clickBuildWithParametersButton() {
        $x(BUILD_WITH_PARAMETERS_BUTTON).waitUntil(Condition.visible, 2000).click();
    }

    public void clickBuildButton() {
        Selenide.sleep(1_000);
        $x(BUILD_BUTTON).waitUntil(Condition.visible, 2000).click();
    }

    public void selectApplicationVersionForDeploy(String applicationVersion) {
        $x(VERSION_FOR_DEPLOY_DROPDOWN).waitUntil(Condition.visible, 2000)
                .selectOptionContainingText(applicationVersion);
    }

    public void clickProceedButtonInVersionInfoPopup() {
        $x(PROCEED_BUTTON_IN_VERSION_INFORMATION_POPUP).shouldBe(Condition.visible).click();
    }

    public void clickInputRequestedButton() {
        Selenide.sleep(2000);
        $x(INPUT_REQUESTED_BUTTON).waitUntil(Condition.visible, 300_000)
                .scrollIntoView(false).click();
    }

    public void clickDashboardButton() {
        $x(DASHBOARD_BUTTON).shouldBe(Condition.visible).click();
    }

    public void clickProceedButtonToPromoteImage() {
        Selenide.sleep(2000);
        $x(PROSEED_TO_PROMOTE_BUTTON).waitUntil(Condition.visible, 500_000)
                .scrollIntoView(false).click();
    }

    public void openJobInfoPage() {
        waitForPageReadyState();
        Selenide.refresh();
        $$x(JOB_INFO_PAGE).first().waitUntil(Condition.visible, 5000).click();
    }

    public void clickProgressBar() {
        $x(PIPELINE_PROGRESS_BAR).waitUntil(Condition.visible, 5000)
                .scrollIntoView(true).click();
    }

    public void enterGitHubProvisionerCode(String gitHubProvisionerCode) {
        SelenideElement element = $$x(CODE_INPUT).filter(Condition.visible).last().doubleClick();
        Actions action = new Actions(WebDriverRunner.getWebDriver());
        action.sendKeys(element, gitHubProvisionerCode).perform();

    }

    public void checkBuildJobIsCreated(String buildJob) {
        $x(String.format(BUILD_JOB_LINK, buildJob)).waitUntil(Condition.appear, 5000);
    }

    public void checkCodeReviewJobIsCreated(String codeReviewJob) {
        $x(String.format(CODE_REVIEW_JOB_LINK, codeReviewJob)).waitUntil(Condition.appear, 5000);
    }

    public void codeReviewJobStatusShouldBeSuccess(String codeReviewJob) {
        Selenide.sleep(3000);
        Selenide.refresh();
        Predicate<SelenideElement> checkStatus = status -> {
            $x(String.format(CODE_REVIEW_JOB, codeReviewJob)).shouldBe(Condition.visible);
            Selenide.refresh();
            if (Objects.equals($x(String.format(CODE_REVIEW_JOB, codeReviewJob)).getAttribute("class"),
                    " job-status-red")) {
                throw new TAFRuntimeException("Status is red");
            }
            return Try.of(() -> $x(String.format(CODE_REVIEW_JOB, codeReviewJob))
                            .shouldHave(Condition.attribute("class", " job-status-blue")))
                    .isSuccess();
        };
        new FlexWait<SelenideElement>(String.format("wait for success status for %s build job", codeReviewJob))
                .during(1200000).tryTo(checkStatus).every(5000).executeWithoutResult();
    }

    public void createCiProvisioner(Map<String, String> params) {
        String url = String.format(CREATE_CI_PROVISIONER, edpComponentsConfig.getJenkinsUrl());
        pollingJenkins()
                .untilAsserted(() ->
                        HttpRequest.post(url).addAccept(ANY.toString())
                                .addContentType(CTFS_CONTENT_HEADER.toString())
                                .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                        getJenkinsSecretFieldValue("password"))
                                .addBodyAsFormData(params)
                                .sendAndGetResponse(302));
    }

    public void configureGithubCiProvisioner(Map<String, String> params) {
        String url = String.format(CONFIGURE_CI_PROVISIONER, edpComponentsConfig.getJenkinsUrl(), params.get("name"));
        pollingJenkins()
                .untilAsserted(() ->
                        HttpRequest.post(url).addAccept(ANY.toString())
                                .addContentType(CTFS_CONTENT_HEADER.toString())
                                .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                        getJenkinsSecretFieldValue("password"))
                                .addBodyAsFormData(params)
                                .sendAndGetResponse(302));
    }

    public void configureGitlabCiProvisioner(Map<String, String> params) {
        String url = String.format(CONFIGURE_CI_PROVISIONER, edpComponentsConfig.getJenkinsUrl(), params.get("name"));
        pollingJenkins()
                .untilAsserted(() ->
                        HttpRequest.post(url).addAccept(ANY.toString())
                                .addContentType(CTFS_CONTENT_HEADER.toString())
                                .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                        getJenkinsSecretFieldValue("password"))
                                .addBodyAsFormData(params)
                                .sendAndGetResponse(302));
    }

    public void setNumberOfWorkersInJenkinsForComputerName(Map<String, String> params) {
        String url = String.format(CONFIGURE_JENKINS_WORKERS, edpComponentsConfig.getJenkinsUrl(), params.get("name"));
        pollingJenkins()
                .untilAsserted(() ->
                        HttpRequest.post(url).addAccept(ANY.toString())
                                .addContentType(CTFS_CONTENT_HEADER.toString())
                                .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                        getJenkinsSecretFieldValue("password"))
                                .addBodyAsFormData(params)
                                .sendAndGetResponse(302));
    }

    public void collectParametersForDeploy(DataTable table) throws URISyntaxException, IOException {
        WaitingUtils.waitFor(60);
        JenkinsServer jenkins = new JenkinsServer(new URI(edpComponentsConfig.getJenkinsUrl())
                , getJenkinsSecretFieldValue("username"), getJenkinsSecretFieldValue("password"));

        List<Map<String, String>> listRows = table.asMaps();
        for (Map<String, String> row : listRows) {
            JobWithDetails job = jenkins.getJob(row.get("cdPipelinejenkinsFolder"));
            Optional<FolderJob> folder = jenkins.getFolderJob(job);
            Assertions.assertNotNull(job);

            pollingJenkins()
                    .ignoreExceptionsInstanceOf(NullPointerException.class)
                    .untilAsserted(() -> {
                        Build build = jenkins.getJob(folder.get(), row.get("name")).getBuildByNumber(1);
                        Assertions.assertTrue(build.details().isBuilding(),
                                String.format("Waiting for job completion: %s", row.get("name")));
                    });

            String url = String.format(GET_USER_INPUT, edpComponentsConfig.getJenkinsUrl(),
                    row.get("cdPipelinejenkinsFolder"), row.get("name"));

            AtomicReference<JSONObject> inputResponse = new AtomicReference<>();
            AtomicReference<JSONArray> inputs = new AtomicReference<>();
            AtomicReference<JSONObject> definition = new AtomicReference<>();
            AtomicReference<JSONArray> choices = new AtomicReference<>();
            Predicate<HttpResponseWrapper> checkStatus = status -> {
                HttpResponseWrapper response = Try.of(() ->
                                HttpRequest.get(url)
                                        //                        .addAccept(ANY.toString())
                                        .addContentType(APPLICATION_JSON.toString())
                                        .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                                getJenkinsSecretFieldValue("password"))
                                        //                        .addBody(IParser.toJson(params))
                                        .sendAndGetResponse(200))
                        .onFailure(exception -> {
                            log.error(String.format("Failed to execute create change request by following url %s",
                                    url));
                            throw new EnvironmentException(
                                    String.format("Failed to execute create change request by following url %s", url),
                                    exception);
                        }).get();
                inputResponse.set(new JSONObject(response.getBody()));
                inputs.set(inputResponse.get().getJSONArray("inputs"));
                definition.set(inputs.get().getJSONObject(0).getJSONObject("definition"));
                choices.set(definition.get().getJSONArray("choices"));
                return inputResponse.get().get("id").equals("UserInput");
            };
            new FlexWait<HttpResponseWrapper>("Wait for components field data")
                    .during(200000).tryTo(checkStatus).every(10000).executeWithoutResult();

            TestCache.putDataInCache(TestCacheKey.INPUT_APPLICATION_NAME,
                    inputs.get().getJSONObject(0).get("name"));
            TestCache.putDataInCache(TestCacheKey.INPUT_APPLICATION_VERSION, choices.get().get(1).toString());
        }
    }

    public void collectParametersForPromote(DataTable table) throws URISyntaxException, IOException {
        JenkinsServer jenkins = new JenkinsServer(new URI(edpComponentsConfig.getJenkinsUrl())
                , getJenkinsSecretFieldValue("username"), getJenkinsSecretFieldValue("password"));

        List<Map<String, String>> listRows = table.asMaps();
        for (Map<String, String> row : listRows) {
            JobWithDetails job = jenkins.getJob(row.get("cdPipelinejenkinsFolder"));
            Optional<FolderJob> folder = jenkins.getFolderJob(job);
            Assertions.assertNotNull(job);

            pollingJenkins()
                    .ignoreExceptionsInstanceOf(NullPointerException.class)
                    .untilAsserted(() -> {
                        Build build = jenkins.getJob(folder.get(), row.get("name")).getBuildByNumber(1);
                        Assertions.assertTrue(build.details().isBuilding(),
                                String.format("Waiting for job completion: %s", row.get("name")));
                    });

            String url = String.format(GET_USER_INPUT, edpComponentsConfig.getJenkinsUrl(),
                    row.get("cdPipelinejenkinsFolder"), row.get("name"));

            AtomicReference<JSONObject> inputResponse = new AtomicReference<>();
            AtomicReference<JSONArray> inputs = new AtomicReference<>();
            AtomicReference<JSONObject> definition = new AtomicReference<>();
            AtomicReference<JSONArray> choices = new AtomicReference<>();
            Predicate<HttpResponseWrapper> checkStatus = status -> {
                HttpResponseWrapper response = Try.of(() ->
                                HttpRequest.get(url)
                                        .addContentType(APPLICATION_JSON.toString())
                                        .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                                getJenkinsSecretFieldValue("password"))
                                        .sendAndGetResponse(200))
                        .onFailure(exception -> {
                            log.error(String.format("Failed to execute get input data request by following url %s",
                                    url));
                            throw new EnvironmentException(
                                    String.format("Failed to execute get input data request by following url %s", url),
                                    exception);
                        }).get();
                inputResponse.set(new JSONObject(response.getBody()));
                return !inputResponse.get().isEmpty();
            };
            new FlexWait<HttpResponseWrapper>("Wait for Input be available")
                    .during(200000).tryTo(checkStatus).every(10000).executeWithoutResult();

            TestCache.putDataInCache(TestCacheKey.PROCEED_INPUT_ID, inputResponse.get().get("id"));
        }
    }

    public void approveQualityGate(DataTable table) {
        List<Map<String, String>> listRows = table.asMaps();
        for (Map<String, String> row : listRows) {
            String url = String.format(PROCEED_QUALITY_GATE_URL, edpComponentsConfig.getJenkinsUrl(),
                    row.get("cdPipelinejenkinsFolder"), row.get("name"), TestCache.get(TestCacheKey.PROCEED_INPUT_ID));
            Try.run(() ->
                            HttpRequest.post(url).addAccept(ANY.toString())
                                    .addContentType(CTFS_CONTENT_HEADER.toString())
                                    .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                            getJenkinsSecretFieldValue("password"))
                                    .sendAndGetResponse(200))
                    .onFailure(exception -> {
                        log.error(String.format("Failed to execute delete codebase request by following url %s", url));
                        throw new EnvironmentException(
                                String.format("Failed to execute delete codebase request by following url %s", url),
                                exception);
                    });
        }
    }

    public void setParametersForDeployJobInJenkinsFolder(String name, String cdPipelinejenkinsFolder,
                                                         Map<String, String> params) {
        String url = String.format(SET_USER_INPUT, edpComponentsConfig.getJenkinsUrl(), cdPipelinejenkinsFolder, name);
        Try.run(() ->
                        HttpRequest.post(url).addAccept(ANY.toString())
                                .addContentType(CTFS_CONTENT_HEADER.toString())
                                .addBasicAuth(getJenkinsSecretFieldValue("username"),
                                        getJenkinsSecretFieldValue("password"))
                                .addBodyAsFormData((params))
                                .sendAndGetResponse(302))
                .onFailure(exception -> {
                    log.error(String.format("Failed to execute delete codebase request by following url %s", url));
                    throw new EnvironmentException(
                            String.format("Failed to execute delete codebase request by following url %s", url),
                            exception);
                });
    }

    private String getJenkinsSecretFieldValue(String fieldName) {
        return secretsSteps.getSecretFieldValue(JENKINS_SECRET_NAME, fieldName);
    }
}
