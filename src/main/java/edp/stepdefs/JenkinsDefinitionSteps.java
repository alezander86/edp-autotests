package edp.stepdefs;

import edp.core.cache.TestCache;
import edp.core.config.EdpComponentsConfig;
import edp.core.config.GithubProviderConfig;
import edp.core.config.GitlabProviderConfig;
import edp.core.enums.testcachemanagement.TestCacheKey;
import edp.groovy.service.provisioner.ProvisionerGroovyService;
import edp.pageobject.IBrowserTabProcessing;
import edp.pageobject.pages.Jenkins;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import org.apache.http.auth.AuthenticationException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class JenkinsDefinitionSteps {

    @Autowired
    private Jenkins jenkins;

    @Autowired
    private EdpComponentsConfig edpComponentsConfig;

    @Autowired
    private GitlabProviderConfig gitlabProviderConfig;

    @Autowired
    private GithubProviderConfig githubProviderConfig;

    @Autowired
    private ProvisionerGroovyService provisionerGroovyService;

    @And("User clicks {string} codebase jenkins folder")
    public void userClicksCodebaseJenkinsFolder(final String codebaseJenkinsFolder) {
        jenkins.clickCodebaseJenkinsFolder(codebaseJenkinsFolder);
    }

    @And("User clicks {string} cd pipeline jenkins folder")
    public void userClicksCdPipelineJenkinsFolder(final String cdPipelineName) {
        jenkins.clickCdPipelineJenkinsFolder(cdPipelineName);
//        IBrowserTabProcessing.switchToNewTab();
    }

    @And("User checks {string} build job is created")
    public void userChecksBuildJobIsCreated(final String buildJob) {
        jenkins.checkBuildJobIsCreated(buildJob);
    }

    @And("User checks {string} code review job is created")
    public void userChecksCodeReviewJobIsCreated(final String codeReviewJob) {
        jenkins.checkCodeReviewJobIsCreated(codeReviewJob);
//        IBrowserTabProcessing.switchToFirstTab();
    }

    @And("User opens {string} cd pipeline overview")
    public void userOpensCdPipelineOverview(final String codebaseJenkinsFolder) {
        jenkins.openCdPipelineOverview(codebaseJenkinsFolder);
    }

    @And("User sees success status for {string} create release job")
    public void userSeesSuccessStatusForCreateReleaseJob(final String createReleaseJob) {
        jenkins.createReleaseStatusShouldBeSuccess(createReleaseJob);
    }

    @And("User sees success status for {string} build job")
    public void userSeesSuccessStatusForBuildJob(final String buildJob) {
        jenkins.buildJobStatusShouldBeSuccess(buildJob);
//        IBrowserTabProcessing.switchToFirstTab();
    }

    @And("User checks success status for {string} build job")
    public void userChecksSuccessStatusForBuildJob(final String buildJob) {
        jenkins.buildJobStatusShouldBeSuccess(buildJob);
        IBrowserTabProcessing.switchToFirstTab();
    }

    @And("User checks {string} build  status in {string} jenkins folder")
    public void checkBuildStatusInJenkinsFolder(final String jobName, final String jenkinsFolder) throws IOException, URISyntaxException {
        jenkins.checkBuildStatusInJenkinsFolder(jobName, jenkinsFolder);
    }

    @And("User checks {string} second build  status in {string} jenkins folder")
    public void checkSecondBuildStatusInJenkinsFolder(final String jobName, final String jenkinsFolder) throws IOException, URISyntaxException {
        jenkins.checkSecondBuildStatusInJenkinsFolder(jobName, jenkinsFolder);
    }

    @And("User checks {string} job status in {string} jenkins folder for default branch")
    public void checkJobStatusInJenkinsFolderForDefaultBranch(final String createReleaseJob, final String jenkinsFolder) throws IOException, URISyntaxException {
        jenkins.checkJobStatusInJenkinsFolderForDefaultBranch(createReleaseJob, jenkinsFolder);
    }

    @And("User checks {string} job status in {string} jenkins folder for new branch")
    public void checkJobStatusInJenkinsFolderForNewBranch(final String createReleaseJob, final String jenkinsFolder) throws IOException, URISyntaxException {
        jenkins.checkJobStatusInJenkinsFolderForNewBranch(createReleaseJob, jenkinsFolder);
    }

    @And("User stop {string} build in {string} jenkins folder")
    public void stopBuildInJenkinsFolder(final String jobNameDefault, final String jenkinsFolder) throws IOException, URISyntaxException {
        jenkins.stopBuildInJenkinsFolder(jobNameDefault, jenkinsFolder);
    }

    @And("User triggers {string} job in {string} jenkins folder")
    public void triggerJobInJenkinsFolder(final String name, String cdPipelinejenkinsFolder) throws IOException, URISyntaxException {
        jenkins.triggerJobInJenkinsFolder(name, cdPipelinejenkinsFolder);
    }

    @And("User sees success status for {string} cd pipeline stage")
    public void userSeesSuccessStatusForCdPipelineStage(final String cdPipelineStage) {
        jenkins.cdPipelineStageStatusShouldBeSuccess(cdPipelineStage);
    }

    @And("User sees success status for {string} stage")
    public void userSeesSuccessStatusForStage(final String cdPipelineStage) {
        jenkins.stageStatusShouldBeSuccess(cdPipelineStage);
        IBrowserTabProcessing.switchToFirstTab();
    }

    @And("User clicks 'Manage Jenkins' button")
    public void userClicksManageJenkinsButton() {
        jenkins.clickManageJenkinsButton();
    }

    @And("User clicks 'Configure System' button")
    public void userClicksConfigureSystemButton() {
        jenkins.clickConfigureSystemButton();
    }

    @And("User enters {string} gitlab connection name")
    public void userEntersGitlabConnectionName(final String gitlabConnectionName) {
        jenkins.enterGitlabConnectionName(gitlabConnectionName);
    }

    @And("User enters {string} gitlab host url")
    public void userEntersGitlabHostUrl(final String gitlabHostUrl) {
        jenkins.enterGitlabHostUrl(gitlabHostUrl);
    }

    @And("User enters {string} github host url")
    public void userEntersGithubHostUrl(final String githubHostUrl) {
        jenkins.enterGithubHostUrl(githubHostUrl);
    }

    @And("User selects {string} gitlab access api token")
    public void userSelectsGitlabAccessApiToken(final String gitlabAccessApiToken) {
        jenkins.selectGitlabAccessApiToken(gitlabAccessApiToken);
    }

    @And("User clicks 'Save' button")
    public void userClicksSaveButton() {
        jenkins.clickSaveButton();
    }

    @And("User clicks 'Add Github server' button")
    public void userClicksAddGithubServerButton() {
        jenkins.clickAddGithubServerButton();
    }

    @And("User clicks 'github Server' button")
    public void userClicksGithubServerButton() {
        jenkins.clickGithubServerButton();
    }

    @Then("User enters {string} github connection name")
    public void userEntersGithubConnectionName(final String githubConnectionName) {
        jenkins.enterGithubConnectionName(githubConnectionName);
    }

    @And("User selects {string} github access api token")
    public void userSelectsGithubAccessApiToken(final String githubAccessApiToken) {
        jenkins.selectGithubAccessApiToken(githubAccessApiToken);
    }

    @And("User selects {string} token for pull request builder")
    public void userSelectsTokenForPullRequestBuilder(final String githubAccessApiToken) {
        jenkins.selectsTokenForPullRequestBuilder(githubAccessApiToken);
    }

    @And("User enters GitHub provisioner code")
    public void userEntersGitHubProvisionerCode() {
        String githubProvisioner = provisionerGroovyService.getGithubProvisionerScript();
        jenkins.enterGitHubProvisionerCode(githubProvisioner);
    }

    @And("User clicks {string} job")
    public void userstageNameJob(final String stageName) {
        jenkins.clickStageNameJob(stageName);
    }

    @And("User clicks 'Build with Parameters' button")
    public void userClicksBuildWithParametersButton() {
        jenkins.clickBuildWithParametersButton();
    }

    @And("User clicks 'Build' button")
    public void userClicksBuildButton() {
        jenkins.clickBuildButton();
    }

    @And("User opens 'job info' page")
    public void userOpensJobInfoPage() {
        jenkins.openJobInfoPage();
    }

    @And("User clicks progress bar")
    public void userClicksProgressBar() {
        jenkins.clickProgressBar();
    }

    @And("User selects {string} application version for deploy")
    public void userSelectsApplicationVersionForDeploy(final String applicationVersion) {
        jenkins.selectApplicationVersionForDeploy(applicationVersion);
    }

    @Then("User clicks 'Proceed' button in version info popup")
    public void userClicksProceedButtonInVersionInfoPopup() {
        jenkins.clickProceedButtonInVersionInfoPopup();
    }

    @And("User clicks 'Input requested' button")
    public void userClicksInputRequestedButton() {
        jenkins.clickInputRequestedButton();
    }

    @And("User clicks Proceed' button to promote image")
    public void userClicksProceedButtonToPromoteImage() {
        jenkins.clickProceedButtonToPromoteImage();
    }

    @And("User clicks 'Dashboard' button")
    public void userClicksDashboardButton() {
        jenkins.clickDashboardButton();
    }

    @And("User checks success status for {string} code review job")
    public void userChecksSuccessStatusForCodeReviewJob(final String codeReviewJob) {
        jenkins.codeReviewJobStatusShouldBeSuccess(codeReviewJob);
//        IBrowserTabProcessing.closeCurrentTab();
//        IBrowserTabProcessing.switchToFirstTab();
    }

    @Given("User creates {string} ci provisioner with {string} media type")
    public void createCiProvisioner(final String provisionerName, final String mediaType) throws IOException, AuthenticationException {
        Map<String, String> params = new LinkedHashMap<>();
        params.put("name", provisionerName);
        params.put("mode", mediaType);
        jenkins.createCiProvisioner(params);
    }

    @Then("User configure {string} github ci provisioner")
    public void configureGithubCiProvisioner(final String provisionerName) throws IOException {
        String githubConfig = provisionerGroovyService.getGithubProvisionerConfig();
        Map<String, String> params = new LinkedHashMap<>();
        params.put("name", provisionerName);
        params.put("json", githubConfig);
        jenkins.configureGithubCiProvisioner(params);
    }

    @Then("User configure {string} gitlab ci provisioner")
    public void configureGitlabCiProvisioner(final String provisionerName) throws IOException {
        String githubConfig = provisionerGroovyService.getGitlabProvisionerConfig();
        Map<String, String> params = new LinkedHashMap<>();
        params.put("name", provisionerName);
        params.put("json", githubConfig);
        jenkins.configureGitlabCiProvisioner(params);
    }

    @Given("User sets number of workers in Jenkins for {string} computer name")
    public void setNumberOfWorkersInJenkinsForComputerName(String computerName) throws URISyntaxException, IOException, ClassNotFoundException {

        String jenkinsWorkersConfig = provisionerGroovyService.getJenkinsWorkersConfig();
        Map<String, String> params = new LinkedHashMap<>();
        params.put("name", computerName);
        params.put("json", jenkinsWorkersConfig);
        jenkins.setNumberOfWorkersInJenkinsForComputerName(params);
    }

    @And("User collects parameters for deploy")
    public void collectParametersForDeploy(final DataTable table) throws URISyntaxException, IOException {
        jenkins.collectParametersForDeploy(table);
    }

    @And("User collects parameters for promote")
    public void collectParametersForPromote(final DataTable table) throws URISyntaxException, IOException {
        jenkins.collectParametersForPromote(table);
    }

    @And("User approve quality gate")
    public void approveQualityGate(final DataTable table) throws URISyntaxException, IOException {
        jenkins.approveQualityGate(table);
    }

    @And("User set parameters for deploy {string} job in {string} jenkins folder")
    public void setParametersForDeployJobInJenkinsFolder(final String name, final String cdPipelinejenkinsFolder) throws URISyntaxException, IOException {
        String codebaseName = TestCache.get(TestCacheKey.INPUT_APPLICATION_NAME).toString();
        String codebaseVersion = TestCache.get(TestCacheKey.INPUT_APPLICATION_VERSION).toString();

        Map<String, String> codebaseInput = new HashMap<>();
        codebaseInput.put("name", codebaseName);
        codebaseInput.put("value", codebaseVersion);

        JSONObject ne = new JSONObject();
        ne.put("parameter", codebaseInput);

        String b = ne.toString();

        Map<String, String> params = new LinkedHashMap<>();
        params.put("json", b);
        params.put("proceed", "Proceed");

        jenkins.setParametersForDeployJobInJenkinsFolder(name, cdPipelinejenkinsFolder, params);
    }

}
