import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.jenkins.plugins.docker_build_env.*
import hudson.model.*

def instance = Jenkins.getInstance()

// Configurar Docker globalmente
def descriptor = instance.getDescriptor("com.cloudbees.jenkins.plugins.docker_build_env.Docker")

if (descriptor != null) {
    descriptor.setDockerHost("unix:///var/run/docker.sock")
    descriptor.setDockerCertPath("")
    descriptor.setDockerApiVersion("")
    descriptor.setDockerTlsVerify(false)
    descriptor.save()
}

println "Docker configurado para usar socket Unix"

instance.save()
