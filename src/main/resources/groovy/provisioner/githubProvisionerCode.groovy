import groovy.json.*
import jenkins.model.Jenkins
import javaposse.jobdsl.plugin.*
import com.cloudbees.hudson.plugins.folder.*

Jenkins jenkins = Jenkins.instance
def stages = [:]
def jiraIntegrationEnabled = Boolean.parseBoolean("${JIRA_INTEGRATION_ENABLED}" as String)
def commitValidateStage = jiraIntegrationEnabled ? ',{"name": "commit-validate"}' : ''
def createJIMStage = jiraIntegrationEnabled ? ',{"name": "create-jira-issue-metadata"}' : ''
def platformType = "${PLATFORM_TYPE}"
def buildStage = platformType == "kubernetes" ? ',{"name": "build-image-kaniko"},' : ',{"name": "build-image-from-dockerfile"},'
def buildTool = "${BUILD_TOOL}"
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
stages['Build-application-npm'] = stages['Build-application-maven']
stages['Build-application-gradle'] = stages['Build-application-maven']
stages['Build-application-dotnet'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "compile"},' +
        '{"name": "tests"},{"name": "sonar"}' + "${buildStage}" +
        '{"name": "push"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-application-go'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "tests"},{"name": "sonar"},' +
        '{"name": "build"}' + "${buildStage}" + "${createJIMStage}" + ',{"name": "git-tag"}]'
stages['Build-application-python'] = '[{"name": "checkout"},{"name": "get-version"},{"name": "compile"},{"name": "tests"},{"name": "sonar"}' +
        "${buildStage}" + '{"name":"push"}' + "${createJIMStage}" + ',{"name": "git-tag"}]'

stages['Create-release'] = '[{"name": "checkout"},{"name": "create-branch"},{"name": "trigger-job"}]'

def buildToolsOutOfTheBox = ["maven","npm","gradle","dotnet","none","go","python"]
def defaultStages = '[{"name": "checkout"}' + "${createJIMStage}" + ']'

def codebaseName = "${NAME}"
def gitServerCrName = "${GIT_SERVER_CR_NAME}"
def gitServerCrVersion = "${GIT_SERVER_CR_VERSION}"
def gitCredentialsId = "${GIT_CREDENTIALS_ID ? GIT_CREDENTIALS_ID : 'gerrit-ciuser-sshkey'}"
def repositoryPath = "${REPOSITORY_PATH.replaceAll(~/:\d+\\//,"/")}"
def githubRepository = "https://${repositoryPath.split("@")[1]}"
def defaultBranch = "${DEFAULT_BRANCH}"

def codebaseFolder = jenkins.getItem(codebaseName)
if (codebaseFolder == null) {
    folder(codebaseName)
}

createListView(codebaseName, "Releases")
createReleasePipeline("Create-release-${codebaseName}", codebaseName, stages["Create-release"], "create-release.groovy",
        repositoryPath, gitCredentialsId, gitServerCrName, gitServerCrVersion, jiraIntegrationEnabled, platformType, defaultBranch)

if (buildTool.toString().equalsIgnoreCase('none')) {
    return true
}

if (BRANCH) {
    def branch = "${BRANCH}"
    def formattedBranch = "${branch.toUpperCase().replaceAll(/\\//, "-")}"
    createListView(codebaseName, formattedBranch)

    def type = "${TYPE}"
    def supBuildTool = buildToolsOutOfTheBox.contains(buildTool.toString())
    def crKey = "Code-review-${type}".toString()
    createCodeReviewPipeline("Code-review-${codebaseName}", codebaseName, stages.get(crKey, defaultStages), "code-review.groovy",
            repositoryPath, gitCredentialsId, branch, gitServerCrName, gitServerCrVersion, githubRepository)
    registerWebHook(repositoryPath)


    def buildKey = "Build-${type}-${buildTool.toLowerCase()}".toString()

    if (type.equalsIgnoreCase('application') || type.equalsIgnoreCase('library')) {
        def jobExists = false
        if("${formattedBranch}-Build-${codebaseName}".toString() in Jenkins.instance.getAllItems().collect{it.name})
            jobExists = true
        createBuildPipeline("Build-${codebaseName}", codebaseName, stages.get(buildKey, defaultStages), "build.groovy",
                repositoryPath, gitCredentialsId, branch, gitServerCrName, gitServerCrVersion, githubRepository)
        registerWebHook(repositoryPath, 'build')

        if(!jobExists)
            queue("${codebaseName}/${formattedBranch}-Build-${codebaseName}")
    }
}

def createCodeReviewPipeline(pipelineName, codebaseName, codebaseStages, pipelineScript, repository, credId, watchBranch = "master", gitServerCrName, gitServerCrVersion, githubRepository) {
    pipelineJob("${codebaseName}/${watchBranch.toUpperCase().replaceAll(/\\//, "-")}-${pipelineName}") {
        logRotator {
            numToKeep(10)
            daysToKeep(7)
        }
        definition {
            cpsScm {
                scm {
                    git {
                        remote {
                            url(repository)
                            credentials(credId)
                            refspec("+refs/pull/*:refs/remotes/origin/pr/*")
                        }
                        branches("\${ghprbActualCommit}")
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
            githubPullRequest {
                cron('')
                onlyTriggerPhrase(false)
                useGitHubHooks(true)
                permitAll(true)
                autoCloseFailedPullRequests(false)
                displayBuildErrorsOnDownstreamBuilds(false)
                whiteListTargetBranches([watchBranch.toString()])
                extensions {
                    commitStatus {
                        context('Jenkins Code-Review')
                        triggeredStatus('Build is Triggered')
                        startedStatus('Build is Started')
                        addTestResults(true)
                        completedStatus('SUCCESS', 'Verified')
                        completedStatus('FAILURE', 'Failed')
                        completedStatus('PENDING', 'Penging')
                        completedStatus('ERROR', 'Error')
                    }
                }
            }
        }
        properties {
            githubProjectProperty {
                projectUrlStr("${githubRepository}")
            }
        }
    }
}

def createBuildPipeline(pipelineName, codebaseName, codebaseStages, pipelineScript, repository, credId, watchBranch = "master", gitServerCrName, gitServerCrVersion, githubRepository) {
    pipelineJob("${codebaseName}/${watchBranch.toUpperCase().replaceAll(/\\//, "-")}-${pipelineName}") {
        logRotator {
            numToKeep(10)
            daysToKeep(7)
        }
        definition {
            cpsScm {
                scm {
                    git {
                        remote {
                            url(repository)
                            credentials(credId)
                        }
                        branches("${watchBranch}")
                        scriptPath("${pipelineScript}")
                    }
                }
                parameters {
                    stringParam("GIT_SERVER_CR_NAME", "${gitServerCrName}", "Name of Git Server CR to generate link to Git server")
                    stringParam("GIT_SERVER_CR_VERSION", "${gitServerCrVersion}", "Version of GitServer CR Resource")
                    stringParam("STAGES", "${codebaseStages}", "Consequence of stages in JSON format to be run during execution")
                    stringParam("GERRIT_PROJECT_NAME", "${codebaseName}", "Gerrit project name(Codebase name) to be build")
                    stringParam("BRANCH", "${watchBranch}", "Branch to run from")
                }
            }
        }
        triggers {
            gitHubPushTrigger()
        }
        properties {
            githubProjectProperty {
                projectUrlStr("${githubRepository}")
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

def registerWebHook(repositoryPath, type = 'code-review') {
    def url = repositoryPath.split('@')[1].split('/')[0]
    def owner = repositoryPath.split('@')[1].split('/')[1]
    def repo = repositoryPath.split('@')[1].split('/')[2]
    def apiUrl = 'https://api.' + url + '/repos/' + owner + '/' + repo + '/hooks'
    def webhookUrl = ''
    def webhookConfig = [:]
    def config = [:]
    def events = []

    if (type.equalsIgnoreCase('build')) {
        webhookUrl = System.getenv('JENKINS_UI_URL') + "/github-webhook/"
        events = ["push"]
        config["url"] = webhookUrl
        config["content_type"] = "json"
        config["insecure_ssl"] = 0
        webhookConfig["name"] = "web"
        webhookConfig["config"] = config
        webhookConfig["events"] = events
        webhookConfig["active"] = true

    } else {
        webhookUrl = System.getenv('JENKINS_UI_URL') + "/ghprbhook/"
        events = ["issue_comment","pull_request"]
        config["url"] = webhookUrl
        config["content_type"] = "form"
        config["insecure_ssl"] = 0
        webhookConfig["name"] = "web"
        webhookConfig["config"] = config
        webhookConfig["events"] = events
        webhookConfig["active"] = true
    }

    def requestBody = JsonOutput.toJson(webhookConfig)
    def http = new URL(apiUrl).openConnection() as HttpURLConnection
    http.setRequestMethod('POST')
    http.setDoOutput(true)
    println(apiUrl)
    http.setRequestProperty("Accept", 'application/json')
    http.setRequestProperty("Content-Type", 'application/json')
    http.setRequestProperty("Authorization", "token ${getSecretValue('github-access-token')}")
    http.outputStream.write(requestBody.getBytes("UTF-8"))
    http.connect()
    println(http.responseCode)

    if (http.responseCode == 201) {
        response = new JsonSlurper().parseText(http.inputStream.getText('UTF-8'))
    } else {
        response = new JsonSlurper().parseText(http.errorStream.getText('UTF-8'))
    }

    println "response: ${response}"
}

def getSecretValue(name) {
    def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
            com.cloudbees.plugins.credentials.common.StandardCredentials.class,
            Jenkins.instance,
            null,
            null
    )

    def secret = creds.find { it.properties['id'] == name }
    return secret != null ? secret['secret'] : null
}