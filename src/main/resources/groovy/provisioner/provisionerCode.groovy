import groovy.json.*
import jenkins.model.Jenkins

Jenkins jenkins = Jenkins.instance
def stages = [:]
def jiraIntegrationEnabled = Boolean.parseBoolean("${JIRA_INTEGRATION_ENABLED}" as String)
def commitValidateStage = jiraIntegrationEnabled ? ',{"name": "commit-validate"}' : ''
def createJIMStage = jiraIntegrationEnabled ? ',{"name": "create-jira-issue-metadata"}' : ''
def platformType = "${PLATFORM_TYPE}"
def buildTool = "${BUILD_TOOL}"
def buildStage = platformType == "kubernetes" ? ',{"name": "build-image-kaniko"},' : ',{"name": "build-image-from-dockerfile"},'
def goBuildStage = buildTool.toString() == "go" ? ',{"name": "build"}' : ',{"name": "compile"}'

stages['Code-review-application'] = '[{"name": "gerrit-checkout"}' + "${commitValidateStage}" + goBuildStage +
        ',{"name": "tests"},[{"name": "sonar"},{"name": "dockerfile-lint"},{"name": "helm-lint"}]]'
stages['Code-review-library'] = '[{"name": "gerrit-checkout"}' + "${commitValidateStage}" +
        ',{"name": "compile"},{"name": "tests"},' +
        '{"name": "sonar"}]'
stages['Code-review-autotests'] = '[{"name": "gerrit-checkout"},{"name": "get-version"}' + "${commitValidateStage}" +
        ',{"name": "tests"},{"name": "sonar"}' + "${createJIMStage}" + ']'
stages['Code-review-default'] = '[{"name": "gerrit-checkout"}' + "${commitValidateStage}" + ']'
stages['Code-review-library-terraform'] = '[{"name": "gerrit-checkout"}' + "${commitValidateStage}" +
        ',{"name": "terraform-lint"}]'
stages['Code-review-library-opa'] = '[{"name": "gerrit-checkout"}' + "${commitValidateStage}" +
        ',{"name": "tests"}]'
stages['Code-review-library-codenarc'] = '[{"name": "gerrit-checkout"}' + "${commitValidateStage}" +
        ',{"name": "sonar"},{"name": "build"}]'

stages['Build-library-maven'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "compile"},' +
        '{"name": "tests"},{"name": "sonar"},{"name": "build"},{"name": "push"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-library-npm'] = stages['Build-library-maven']
stages['Build-library-gradle'] = stages['Build-library-maven']
stages['Build-library-dotnet'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "compile"},' +
        '{"name": "tests"},{"name": "sonar"},{"name": "push"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-library-python'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "compile"},' +
        '{"name": "tests"},{"name": "sonar"},{"name": "push"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-library-terraform'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "terraform-lint"}' +
        ',{"name": "terraform-plan"},{"name": "terraform-apply"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-library-opa'] = '[{"name": "checkout"},{"name": "get-version"}' +
        ',{"name": "tests"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-library-codenarc'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "sonar"},{"name": "build"}' +
        "${createJIMStage}" + ',{"name": "git-tag"}]'

stages['Build-application-maven'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "compile"},' +
        '{"name": "tests"},{"name": "sonar"},{"name": "build"}' + "${buildStage}" +
        '{"name": "push"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-application-python'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "compile"},{"name": "tests"},{"name": "sonar"}' +
        "${buildStage}" + '{"name":"push"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-application-npm'] = stages['Build-application-maven']
stages['Build-application-gradle'] = stages['Build-application-maven']
stages['Build-application-dotnet'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "compile"},' +
        '{"name": "tests"},{"name": "sonar"}' + "${buildStage}" +
        '{"name": "push"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-application-terraform'] = '[{"name": "checkout"},{"name": "tool-init"},' +
        '{"name": "lint"},{"name": "git-tag"}]'
stages['Build-application-helm'] = '[{"name": "checkout"},{"name": "lint"}]'
stages['Build-application-docker'] = '[{"name": "checkout"},{"name": "lint"}]'
stages['Build-application-go'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "tests"},{"name": "sonar"},' +
        '{"name": "build"}' + "${buildStage}" + "${createJIMStage}" + '{"name": "git-tag"}]'
stages['Create-release'] = '[{"name": "checkout"},{"name": "create-branch"},{"name": "trigger-job"}]'


def codebaseName = "${NAME}"
def gitServerCrName = "${GIT_SERVER_CR_NAME}"
def gitServerCrVersion = "${GIT_SERVER_CR_VERSION}"
def gitServer = "${GIT_SERVER ? GIT_SERVER : 'gerrit'}"
def gitSshPort = "${GIT_SSH_PORT ? GIT_SSH_PORT : '29418'}"
def gitUsername = "${GIT_USERNAME ? GIT_USERNAME : 'jenkins'}"
def gitCredentialsId = "${GIT_CREDENTIALS_ID ? GIT_CREDENTIALS_ID : 'gerrit-ciuser-sshkey'}"
def defaultRepoPath = "ssh://${gitUsername}@${gitServer}:${gitSshPort}/${codebaseName}"
def repositoryPath = "${REPOSITORY_PATH ? REPOSITORY_PATH : defaultRepoPath}"
def defaultBranch = "${DEFAULT_BRANCH}"

def codebaseFolder = jenkins.getItem(codebaseName)
if (codebaseFolder == null) {
    folder(codebaseName)
}

createListView(codebaseName, "Releases")
createReleasePipeline("Create-release-${codebaseName}", codebaseName, stages["Create-release"], "create-release.groovy",
        repositoryPath, gitCredentialsId, gitServerCrName, gitServerCrVersion, jiraIntegrationEnabled, platformType, defaultBranch)

if (BRANCH) {
    def branch = "${BRANCH}"
    def formattedBranch = "${branch.toUpperCase().replaceAll(/\\//, "-")}"
    createListView(codebaseName, formattedBranch)

    def type = "${TYPE}"
    createCiPipeline("Code-review-${codebaseName}", codebaseName, stages["Code-review-${type}-${buildTool.toLowerCase()}"], "code-review.groovy",
            repositoryPath, gitCredentialsId, branch, gitServerCrName, gitServerCrVersion)

    if (type.equalsIgnoreCase('application') || type.equalsIgnoreCase('library')) {
        def jobExists = false
        if("${formattedBranch}-Build-${codebaseName}".toString() in Jenkins.instance.getAllItems().collect{it.name}) {
            jobExists = true
        }
        createCiPipeline("Build-${codebaseName}", codebaseName, stages["Build-${type}-${buildTool.toLowerCase()}"], "build.groovy",
                repositoryPath, gitCredentialsId, branch, gitServerCrName, gitServerCrVersion)
        if(!jobExists) {
            queue("${codebaseName}/${formattedBranch}-Build-${codebaseName}")
        }
    }
}


def createCiPipeline(pipelineName, codebaseName, codebaseStages, pipelineScript, repository, credId, watchBranch = "master", gitServerCrName, gitServerCrVersion) {
    def jobName = "${watchBranch.toUpperCase().replaceAll(/\\//, "-")}-${pipelineName}"
    def existingJob = Jenkins.getInstance().getItemByFullName("${codebaseName}/${jobName}")
    def webhookToken = null
    if (existingJob) {
        def triggersMap = existingJob.getTriggers()
        triggersMap.each { key, value ->
            webhookToken = value.getSecretToken()
        }
    } else {
        def random = new byte[16]
        new java.security.SecureRandom().nextBytes(random)
        webhookToken = random.encodeHex().toString()
    }
    pipelineJob("${codebaseName}/${jobName}") {
        logRotator {
            numToKeep(10)
            daysToKeep(7)
        }
        properties {
            gitLabConnection {
                gitLabConnection('git.epam.com')
            }
        }
        definition {
            cpsScm {
                scm {
                    git {
                        remote {
                            url(repository)
                            credentials(credId)
                        }
                        branches(pipelineName.contains("Build") ? "${watchBranch}" : "\${gitlabMergeRequestLastCommit}")
                        scriptPath("${pipelineScript}")
                    }
                }
                parameters {
                    stringParam("GIT_SERVER_CR_NAME", "${gitServerCrName}", "Name of Git Server CR to generate link to Git server")
                    stringParam("GIT_SERVER_CR_VERSION", "${gitServerCrVersion}", "Version of GitServer CR Resource")
                    stringParam("STAGES", "${codebaseStages}", "Consequence of stages in JSON format to be run during execution")
                    stringParam("GERRIT_PROJECT_NAME", "${codebaseName}", "Gerrit project name(Codebase name) to be build")
                    stringParam("BRANCH", "${watchBranch}", "Branch to build artifact from")
                }
            }
        }
        triggers {
            gitlabPush {
                buildOnMergeRequestEvents(pipelineName.contains("Build") ? false : true)
                buildOnPushEvents(pipelineName.contains("Build") ? true : false)
                enableCiSkip(false)
                setBuildDescription(true)
                rebuildOpenMergeRequest(pipelineName.contains("Build") ? 'never' : 'source')
                commentTrigger("Build it please")
                skipWorkInProgressMergeRequest(true)
                targetBranchRegex("${watchBranch}")
            }
        }
        configure {
            it / triggers / 'com.dabsquared.gitlabjenkins.GitLabPushTrigger' << secretToken(webhookToken)
            it / triggers / 'com.dabsquared.gitlabjenkins.GitLabPushTrigger' << triggerOnApprovedMergeRequest(pipelineName.contains("Build") ? false : true)
            it / triggers / 'com.dabsquared.gitlabjenkins.GitLabPushTrigger' << pendingBuildName(pipelineName.contains("Build") ? "" : "Jenkins")
        }
    }
    registerWebHook(repository, codebaseName, jobName, webhookToken)
}


def createReleasePipeline(pipelineName, codebaseName, codebaseStages, pipelineScript, repository, credId,
                          gitServerCrName, gitServerCrVersion, jiraIntegrationEnabled, platformType, defaultBranch) {
    pipelineJob("${codebaseName}/${pipelineName}") {
        logRotator {
            numToKeep(14)
            daysToKeep(30)
        }
        definition {
            cpsScm {
                scm {
                    git {
                        remote {
                            url(repository)
                            credentials(credId)
                        }
                        branches("${defaultBranch}")
                        scriptPath("${pipelineScript}")
                    }
                }
                parameters {
                    stringParam("STAGES", "${codebaseStages}", "")
                    if (pipelineName.contains("Create-release")) {
                        stringParam("JIRA_INTEGRATION_ENABLED", "${jiraIntegrationEnabled}", "Is Jira integration enabled")
                        stringParam("PLATFORM_TYPE", "${platformType}", "Platform type")
                        stringParam("GERRIT_PROJECT", "${codebaseName}", "")
                        stringParam("RELEASE_NAME", "", "Name of the release(branch to be created)")
                        stringParam("COMMIT_ID", "", "Commit ID that will be used to create branch from for new release. If empty, HEAD of master will be used")
                        stringParam("GIT_SERVER_CR_NAME", "${gitServerCrName}", "Name of Git Server CR to generate link to Git server")
                        stringParam("GIT_SERVER_CR_VERSION", "${gitServerCrVersion}", "Version of GitServer CR Resource")
                        stringParam("REPOSITORY_PATH", "${repository}", "Full repository path")
                        stringParam("DEFAULT_BRANCH", "${defaultBranch}", "Default repository branch")
                    }
                }
            }
        }
    }
}

def createListView(codebaseName, branchName) {
    listView("${codebaseName}/${branchName}") {
        if (branchName.toLowerCase() == "releases") {
            jobFilters {
                regex {
                    matchType(MatchType.INCLUDE_MATCHED)
                    matchValue(RegexMatchValue.NAME)
                    regex("^Create-release.*")
                }
            }
        } else {
            jobFilters {
                regex {
                    matchType(MatchType.INCLUDE_MATCHED)
                    matchValue(RegexMatchValue.NAME)
                    regex("^${branchName}-(Code-review|Build).*")
                }
            }
        }
        columns {
            status()
            weather()
            name()
            lastSuccess()
            lastFailure()
            lastDuration()
            buildButton()
        }
    }
}

def registerWebHook(repositoryPath, codebaseName, jobName, webhookToken) {
    def apiUrl = 'https://' + repositoryPath.replaceAll("ssh://", "").split('@')[1].replace('/', "%2F").replaceAll(~/:\d+%2F/, '/api/v4/projects/') + '/hooks'
    def jobWebhookUrl = "${System.getenv('JENKINS_UI_URL')}/project/${codebaseName}/${jobName}"
    def gitlabToken = getSecretValue('gitlab-access-token')

    if (checkWebHookExist(apiUrl, jobWebhookUrl, gitlabToken)) {
        println("[JENKINS][DEBUG] Webhook for job ${jobName} is already exist\r\n")
        return
    }

    println("[JENKINS][DEBUG] Creating webhook for job ${jobName}")
    def webhookConfig = [:]
    webhookConfig["url"] = jobWebhookUrl
    webhookConfig["push_events"] = jobName.contains("Build") ? "true" : "false"
    webhookConfig["merge_requests_events"] = jobName.contains("Build") ? "false" : "true"
    webhookConfig["issues_events"] = "false"
    webhookConfig["confidential_issues_events"] = "false"
    webhookConfig["tag_push_events"] = "false"
    webhookConfig["note_events"] = "true"
    webhookConfig["job_events"] = "false"
    webhookConfig["pipeline_events"] = "false"
    webhookConfig["wiki_page_events"] = "false"
    webhookConfig["enable_ssl_verification"] = "true"
    webhookConfig["token"] = webhookToken
    def requestBody = JsonOutput.toJson(webhookConfig)
    def httpConnector = new URL(apiUrl).openConnection() as HttpURLConnection
    httpConnector.setRequestMethod('POST')
    httpConnector.setDoOutput(true)

    httpConnector.setRequestProperty("Accept", 'application/json')
    httpConnector.setRequestProperty("Content-Type", 'application/json')
    httpConnector.setRequestProperty("PRIVATE-TOKEN", "${gitlabToken}")
    httpConnector.outputStream.write(requestBody.getBytes("UTF-8"))
    httpConnector.connect()

    if (httpConnector.responseCode == 201)
        println("[JENKINS][DEBUG] Webhook for job ${jobName} has been created\r\n")
    else {
        println("[JENKINS][ERROR] Responce code - ${httpConnector.responseCode}")
        def response = new JsonSlurper().parseText(httpConnector.errorStream.getText('UTF-8'))
        println("[JENKINS][ERROR] Failed to create webhook for job ${jobName}. Response - ${response}")
    }
}

def checkWebHookExist(apiUrl, jobWebhookUrl, gitlabToken) {
    println("[JENKINS][DEBUG] Checking if webhook ${jobWebhookUrl} exists")
    def httpConnector = new URL(apiUrl).openConnection() as HttpURLConnection
    httpConnector.setRequestMethod('GET')
    httpConnector.setDoOutput(true)

    httpConnector.setRequestProperty("Accept", 'application/json')
    httpConnector.setRequestProperty("Content-Type", 'application/json')
    httpConnector.setRequestProperty("PRIVATE-TOKEN", "${gitlabToken}")
    httpConnector.connect()

    if (httpConnector.responseCode == 200) {
        def response = new JsonSlurper().parseText(httpConnector.inputStream.getText('UTF-8'))
        return response.find { it.url == jobWebhookUrl } ? true : false
    }
}

def getSecretValue(name) {
    def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
            com.cloudbees.plugins.credentials.common.StandardCredentials.class,
            Jenkins.instance,
            null,
            null
    )

    def secret = creds.find { it.properties['id'] == name }
    return secret != null ? secret.getApiToken() : null
}