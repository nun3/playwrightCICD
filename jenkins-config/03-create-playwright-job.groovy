import jenkins.model.*
import hudson.model.*
import hudson.plugins.git.*
import org.jenkinsci.plugins.workflow.job.WorkflowJob
import org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition
import hudson.plugins.git.BranchSpec
import hudson.plugins.git.UserRemoteConfig

def instance = Jenkins.getInstance()

// Criar o job do Playwright
def jobName = "playwright-tests"
def job = new WorkflowJob(instance, jobName)

// Configurar o job
job.setDescription("Executa testes Playwright usando Docker")

// Configurar SCM (Git)
def scm = new GitSCM(".")
scm.setUserRemoteConfigs([
    new UserRemoteConfig("https://github.com/seu-usuario/seu-repo.git", "", "", "")
])
scm.setBranches([new BranchSpec("*/main")])

// Configurar Pipeline
def flowDefinition = new CpsScmFlowDefinition(scm, "Jenkinsfile")
job.setDefinition(flowDefinition)

// Configurar triggers
def triggers = new ArrayList()
triggers.add(new hudson.triggers.SCMTrigger("H/5 * * * *")) // Poll a cada 5 minutos
job.addTriggers(triggers)

// Adicionar job ao Jenkins
instance.add(job, jobName)

println "Job '${jobName}' criado com sucesso!"

instance.save()
