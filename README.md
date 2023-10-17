## Prerequisites to run tests:
1. java 11 should be installed
2. kubeconfig file with parameters for cluster access to `$HOME/.kube/config`
3. encoded config with following structure should be stored in secret:
```
   {
    "cluster": {
        "sandbox": {
            "server": "https://XXXXXXXXXXXXXXXXXXXX.gr7.<REGION>.eks.amazonaws.com",
            "bearerToken": "<CLUSTER_TOKEN_WITH_ADMIN_ACCESS>"
            "tlsClientConfig": {
                "insecure": false,
                "caData": "<CLUSTER_CERT>"
            }
        }
    },
    "secrets": {
        "gitlab": {
            "idRsa": "<SSH_PRIVATE_KEY>",
            "idRsaPub": "<SSH_PUBLIC_KEY>",
            "password": "<PASSWORD>",
            "token": "<ACCESS_TOKEN>",
            "username": "<Autotest@*.com>"
        },
        "github": {
            "idRsa": "<SSH_KEY>",
            "password": "<PASSWORD>",
            "token": "<ACCESS_TOKEN>",
            "username": "<USERNAME>"
        },
        "keycloak": {
            "firstName": "",
            "lastName": "",
            "password": "",
            "username": "",
            "acCreatorId": "",
            "clientId": ""
        },
        "secretData": {
            "kanikoDockerConfig": "<CONFIIG_IN_BASE_64>"  #  { "auths": {"https://index.docker.io/v1/": { "auth": "<TOKEN?>" }}}
        },
        "reportPortal": {
            "endpoint": "<URL_TO_REPORT_PORTAL>",
            "project": "<PROJECT_NAME_IN_BASE_64>",
            "uuid": ""
        }
    }
} 
```

## Local launch
1. Clone project from repository.  
2. To run test suite bootRun command needs to be executed. Run parameters should be passed as system properties.
Ex: `./gradlew bootRun -Dnamespace="edp-delivery-sf-dev" -Dtags=@Run -Dci.tool=tekton`
#### Run parameters list:
  - `namespace` - namespace to run tests against(**mandatory**)
  - `tags` - test suite marked with specified tag to run. Several tags can be specified. Ex: @TektonSmoke,@TektonClone(**mandatory**)
  - `ci.tool` - CI tool to test. Possible options: tekton, jenkins(**mandatory**)
  - `cluster` - namespace cluster(**optional, by default use "sandbox"**)
  - `treads.number` - amount of threads to run in parallel(**optional, by default use "1"**)
  - `git.provider` - git provider to test. Possible options: gerrit, github, gitlab(**optional, by default use "gerrit"**)
  - `kubeconfig` - path to kubeconfig file from prerequisites in next format "/home/user/.kube/your_kubeconfig"(**optional**)
  - `secret.name` - secret from prerequisites name(**optional, by default use "autotests"**)
  - `secret.namespace` - secret from prerequisites namespace(**optional, by default use "security"**)
  - `browser.version` - browser version(**optional, by default use "114.0.5735.133-5"**)
  - `browser.name` - browser name(**optional, by default use "chrome"**)
  - `browser.type` - browser type(**mandatory for remote launch "remote", by default use "local"**)
  - `moon.url` - remote launch browsers(**mandatory for remote launch `https://moon.eks-sandbox.aws.main.edp.projects.epam.com/wd/hub`**)

### Tags list:
#### Create strategy:
  - @TektonSmoke(5 scenarios)  
  - @TektonGerrit(all gerrit scenarios)
#### Import strategy:
  - @TektonGithubSmoke(4 scenarios)
  - @TektonGithub(all github scenarios)
  - @TektonGitlabSmoke(4 scenarios)
  - @TektonGitlab(all gitlab scenarios)
#### Clone strategy:
  - @TektonClone
#### Performance
  - @TektonPerformance
#### Regression
  - @TektonGerrit(All tekton gerrit API tests)
  - @TektonGerritUI(All tekton gerrit UI tests)
  - @TektonGithub(All tekton github API tests)
  - @TektonGithubUI(All tekton github UI tests)
  - @TektonGithubShortRegression(Short regression tekton github API tests 16 scenarios)
  - @TektonGitlab(All tekton gitlab API tests)
  - @TektonGitlabUI(All tekton gitlab UI tests)
  - @Regression(All jenkins gerrit gethub gitlab tests)
#### Post run action
  - @Clean scenario should be executed after each test run.

## Jenkins job launch
1. Create credentials in Jenkins:
   *  Create ssh key from autotest repository
   *  Create kube config where stored secret with kube config to target cluster
2. Create Job in Jenkins
```
pipeline {
    agent {label 'gradle-java8'}
    
    parameters {
        string(
            name: 'NAMESPACE',
            defaultValue: ''
        )
        string(
            name: 'AUTOTESTS_COMMIT_TAG',
            defaultValue: 'master'
        )
        choice(
            name: 'THREADS_NUM',
            choices: [],
            description: 'Number of threads'
        )
        choice(
            name: 'TAG',
            choices: [],
            description: 'Suit to run'
        )
        choice(
            name: 'CLUSTERNAME',
            choices: [],
            description: 'Cluster to use'
        )
        choice(
            name: 'GIT_PROVIDER',
            choices: ['gerrit', 'github', 'gitlab']
        )
        choice(
            name: 'CI_TOOL',
            choices: ['tekton', 'jenkins']
        )
    }

    environment {
        CLUSTERSECRET = 'autotests'
    }

    stages {
        stage('Checkout') {
            steps {
                sh 'mkdir -p tmp'
                dir("tmp")
                {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: "${params.AUTOTESTS_COMMIT_TAG}"]],
                        userRemoteConfigs: [[credentialsId: '<SECRET_WITH_ACCES_TO_AUTOTEST_REPO>(ssh key)', url: '<URL_TO_AUTOTEST_REPO>']]
                    ])
                }
            }
        }
        stage('Autotests') {
            steps {
                dir("tmp")
                {
                    withCredentials([file(credentialsId: '<CLUSTER_WITH_KUBE_CONFIG>', variable: 'KUBECONFIG_CONFIG')]) {
                        sh """
                        rm -rf target TestResults
                        ./gradlew bootRun -Dkubeconfig="${KUBECONFIG_CONFIG}" -Dcluster="${params.CLUSTERNAME}" -Dthreads.number="${params.THREADS_NUM}" -Dnamespace="${params.NAMESPACE}" -Dtags="${params.TAG}" -Dci.tool=${params.CI_TOOL} -Dgit.provider="${params.GIT_PROVIDER}"
                        """
                    }
                }
            }
        post {
          always {
            script {
                currentBuild.displayName = "${params.TAG}-${params.NAMESPACE}"
                allure([
                    includeProperties: false,
                    jdk: '',
                    properties: [],
                    reportBuildPolicy: 'ALWAYS',
                    results: [[path: 'tmp/target/allure-results']]
                ])
            }
          }
        }
    }
  }
} 
```
#### Job parameters
- `NAMESPACE` - namespace where autotest run
- `AUTOTESTS_COMMIT_TAG` - branch/sha/commit to use autotest
- `THREADS_NUM` - how many cobases create in parallel
- `TAG` - autotest scenario
- `CLUSTERNAME` - target cluster where autotests runninh
- `GIT_PROVIDER` - git provider for autotest scenarion (git proveder in target edp namespace)
- `CI_TOOL` - jenkins/tekton
3. Create secret autotests in Jenkins namespace with kube config to <CLUSTER_WITH_KUBE_CONFIG>. 
4. Create secret in <CLUSTER_WITH_KUBE_CONFIG> cluster(See Prerequisites to run tests: point 3) 