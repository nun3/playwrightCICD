import jenkins.model.*
import hudson.model.*
import hudson.plugins.*

def instance = Jenkins.getInstance()

// Lista de plugins necessários para Playwright
def plugins = [
    'workflow-aggregator',
    'git',
    'htmlpublisher',
    'junit',
    'blueocean',
    'docker-plugin',
    'docker-workflow',
    'pipeline-stage-view',
    'timestamper',
    'build-timeout',
    'credentials-binding',
    'ws-cleanup',
    'ant',
    'gradle',
    'pipeline-github-lib',
    'pipeline-stage-view',
    'workflow-job',
    'workflow-cps',
    'workflow-durable-task-step',
    'workflow-basic-steps',
    'workflow-multibranch',
    'pipeline-multibranch-defaults',
    'branch-api',
    'cloudbees-folder',
    'antisamy-markup-formatter',
    'build-timeout',
    'credentials',
    'plain-credentials',
    'credentials-binding',
    'ssh-credentials',
    'github-api',
    'github',
    'github-branch-source',
    'pipeline-github-lib',
    'slack',
    'email-ext',
    'mailer'
]

def pm = instance.getPluginManager()
def uc = instance.getUpdateCenter()
uc.updateAllSites()

plugins.each { plugin ->
    if (!pm.getPlugin(plugin)) {
        println "Instalando plugin: ${plugin}"
        def install = uc.getPlugin(plugin)
        if (install) {
            install.deploy()
        }
    } else {
        println "Plugin já instalado: ${plugin}"
    }
}

instance.save()
