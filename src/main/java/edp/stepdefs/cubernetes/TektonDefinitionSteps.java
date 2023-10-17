package edp.stepdefs.cubernetes;

import edp.core.config.EdpComponentsConfig;
import edp.core.crd.tekton.pipeline_run.PipelineRun;
import edp.core.crd.tekton.task_run.TaskRun;
import edp.core.service.kubernetes.KubernetesClientFactory;
import io.cucumber.java.en.Then;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.stream.Collectors;
import lombok.extern.log4j.Log4j;
import org.opentest4j.TestAbortedException;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static edp.core.crd.codebase.codebase_branch.CodebaseBranch.formatCodebaseBranchName;
import static edp.core.crd.codebase.codebase_branch.CodebaseBranch.formatCodebaseBranchNameForManualLaunch;
import static edp.core.crd.tekton.pipeline_run.PipelineRun.formatPipelineRunName;
import static edp.utils.consts.Constants.FORMATTER;
import static edp.utils.wait.WaitingUtils.pollingTektonPipelineRun;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@Log4j
public class TektonDefinitionSteps {

    private static final int GENERATED_EXTRA_CHARACTERS_AMOUNT = 6;
    private static final int GENERATED_EXTRA_CHARACTERS_AMOUNT_MANUAL = 5;
    private static final int GENERATED_EXTRA_CHARACTERS_AMOUNT_AUTOTESTS = 11;

    @Autowired
    private KubernetesClientFactory factory;
    @Autowired
    private EdpComponentsConfig edpComponentsConfig;

    @Then("User checks {word} pipeline status for {string} branch in {string} codebase")
    public void checkPipelineStatusForBranchInCodebase(String pipelineType, String branchName, String codeBaseName) {
        pollingTektonPipelineRun().untilAsserted(
                () -> pipelineRunIsSucceeded(pipelineType, codeBaseName, branchName,
                        GENERATED_EXTRA_CHARACTERS_AMOUNT, false, 1));
    }

    @Then("User checks {word} pipeline status for {string} branch in {string} codebase is failed on push-to-jira stage")
    public void checkPipelineStatusForCodebaseIsFailed(String pipelineType, String branchName, String codeBaseName) {
        pollingTektonPipelineRun().untilAsserted(
                () -> pipelineRunIsFailed(pipelineType, codeBaseName, branchName, GENERATED_EXTRA_CHARACTERS_AMOUNT));
        pollingTektonPipelineRun().untilAsserted(
                () -> taskRunIsFailedOnPushToJiraStage(pipelineType, codeBaseName, branchName));
    }

    @Then("User checks {word} pipeline status submitted manually for {string} branch in {string} codebase")
    public void checkPipelineStatusForBranchInCodebaseManualLaunch(String pipelineType, String branchName,
                                                                   String codeBaseName) {
        pollingTektonPipelineRun().untilAsserted(
                () -> pipelineRunIsSucceeded(pipelineType, codeBaseName, branchName,
                        GENERATED_EXTRA_CHARACTERS_AMOUNT_MANUAL, true, 1));
    }

    @Then("User checks second {word} pipeline status for {string} branch in {string} codebase")
    public void checkSecondPipelineStatusForBranchInCodebaseManualLaunch(String pipelineType, String branchName,
                                                                         String codeBaseName) {
        pollingTektonPipelineRun().untilAsserted(
                () -> pipelineRunIsSucceeded(pipelineType, codeBaseName, branchName,
                        GENERATED_EXTRA_CHARACTERS_AMOUNT, false, 2));
    }

    @Then("User checks {word} autotest pipeline status for {string} stage in {string} pipeline")
    public void checkPipelineStatusForAutotest(String pipelineType, String stageName, String pipelineName) {
        pollingTektonPipelineRun().untilAsserted(
                () -> pipelineAutotestRunIsSucceeded(pipelineType, stageName, pipelineName,
                        GENERATED_EXTRA_CHARACTERS_AMOUNT_AUTOTESTS, 1));
    }

    private void pipelineRunIsSucceeded(String pipelineType, String codebaseName, String branchName,
                                        Integer extraCharacters, Boolean isManualBuild, Integer runNumber) {
        Map<String, String> labels = new HashMap<>();
        labels.put("app.edp.epam.com/codebasebranch", formatCodebaseBranchName(codebaseName, branchName));
        labels.put("app.edp.epam.com/pipelinetype", pipelineType);

        List<PipelineRun> list = factory.getCustomResourcesList(PipelineRun.class, labels).stream()
                .sorted(Comparator.comparing(TektonDefinitionSteps::apply).reversed())
                .collect(Collectors.toList());
        assertEquals(runNumber, list.size());
        PipelineRun run = list.get(0);

        String formattedCodebaseName = isManualBuild ? formatCodebaseBranchNameForManualLaunch(codebaseName, branchName)
                : formatCodebaseBranchName(codebaseName, branchName);
        String runName = run.getMetadata().getName();
        assertEquals(formatPipelineRunName(pipelineType, formattedCodebaseName),
                runName.substring(0, runName.length() - extraCharacters));

        if (!codebaseName.contains("-auto-")) {
            assertEquals(String.format(
                    "%s/#/namespaces/$(context.pipelineRun.namespace)/pipelineruns/$(context.pipelineRun.name)",
                    edpComponentsConfig.getTektonUrl()), run.getPipelineRunUrl());
        }

        if (run.isFailed()) {
            log.error(String.format("%s pipeline for %s is failed", pipelineType, formattedCodebaseName));
            throw new TestAbortedException();
        }
        assertTrue(run.isSucceeded());
        log.info(String.format("%s pipeline for %s is succeeded", pipelineType, formattedCodebaseName));
    }

    private void pipelineRunIsFailed(String pipelineType, String codebaseName, String branchName,
                                     Integer extraCharacters) {
        Map<String, String> labels = new HashMap<>();
        labels.put("app.edp.epam.com/codebasebranch", formatCodebaseBranchName(codebaseName, branchName));
        labels.put("app.edp.epam.com/pipelinetype", pipelineType);

        List<PipelineRun> list = factory.getCustomResourcesList(PipelineRun.class, labels);
        assertEquals(1, list.size());
        PipelineRun run = list.get(0);

        String formattedCodebaseName = formatCodebaseBranchName(codebaseName, branchName);
        String runName = run.getMetadata().getName();
        assertEquals(formatPipelineRunName(pipelineType, formattedCodebaseName),
                runName.substring(0, runName.length() - extraCharacters));

        assertEquals(String.format(
                "%s/#/namespaces/$(context.pipelineRun.namespace)/pipelineruns/$(context.pipelineRun.name)",
                edpComponentsConfig.getTektonUrl()), run.getPipelineRunUrl());

        assertTrue(run.isFailed());
        log.info(String.format("%s pipeline for %s is failed", pipelineType, formattedCodebaseName));
    }

    private void taskRunIsFailedOnPushToJiraStage(String pipelineType, String codebaseName, String branchName) {
        String formattedCodebaseName = formatCodebaseBranchName(codebaseName, branchName);

        TaskRun taskRun = factory.getTargetClient().customResources(TaskRun.class)
                .inNamespace(edpComponentsConfig.getNamespace())
                .list().getItems().stream().filter(item -> item.getMetadata().getName().endsWith("push-to-jira") &&
                        item.getMetadata().getName().startsWith(formattedCodebaseName.substring(0, 18)))
                .max(Comparator.comparing(TektonDefinitionSteps::applyTaskRun)).get();

        assertTrue(taskRun.isFailed());
        log.info(String.format("%s task push-to-jira for %s is failed", pipelineType, formattedCodebaseName));
    }

    private void pipelineAutotestRunIsSucceeded(String pipelineType, String stageName, String pipelineName,
                                                Integer extraCharacters, Integer runNumber) {
        Map<String, String> labels = new HashMap<>();
        labels.put("app.edp.epam.com/pipeline", pipelineName);
        labels.put("app.edp.epam.com/pipelinetype", pipelineType);
        labels.put("app.edp.epam.com/stage", stageName);

        List<PipelineRun> list = factory.getCustomResourcesList(PipelineRun.class, labels).stream()
                .sorted(Comparator.comparing(TektonDefinitionSteps::apply).reversed())
                .collect(Collectors.toList());
        assertEquals(runNumber, list.size());
        PipelineRun run = list.get(0);

        String formattedCodebaseName = pipelineName.concat("-").concat(stageName);
        String runName = run.getMetadata().getName();
        assertEquals(formattedCodebaseName, runName.substring(0, runName.length() - extraCharacters));

        assertEquals(String.format(
                "%s/#/namespaces/$(context.pipelineRun.namespace)/pipelineruns/$(context.pipelineRun.name)",
                edpComponentsConfig.getTektonUrl()), run.getPipelineRunUrl());

        if (run.isFailed()) {
            log.error(String.format("%s pipeline for %s is failed", pipelineType, formattedCodebaseName));
            throw new TestAbortedException();
        }
        assertTrue(run.isSucceeded());
        log.info(String.format("%s pipeline for %s is succeeded", pipelineType, formattedCodebaseName));
    }

    private static LocalDateTime apply(PipelineRun e) {
        return LocalDateTime.parse(e.getMetadata().getCreationTimestamp(), FORMATTER);
    }

    private static LocalDateTime applyTaskRun(TaskRun e) {
        return LocalDateTime.parse(e.getMetadata().getCreationTimestamp(), FORMATTER);
    }
}
