pipeline {
   agent { docker { image 'mcr.microsoft.com/playwright:v1.55.0-noble' } }
   
   stages {
      stage('Checkout') {
         steps {
            checkout scm
         }
      }
      
      stage('Install Dependencies') {
         steps {
            sh 'npm ci'
         }
      }
      
      stage('Run Playwright Tests') {
         steps {
            sh 'npx playwright test'
         }
      }
   }
   
   post {
      always {
         node('master') {
            // Publicar relatórios de teste
            publishHTML([
               allowMissing: false,
               alwaysLinkToLastBuild: true,
               keepAll: true,
               reportDir: 'playwright-report',
               reportFiles: 'index.html',
               reportName: 'Playwright Test Report'
            ])
            
            // Arquivos de evidência (screenshots, traces)
            archiveArtifacts artifacts: 'test-results/**/*', allowEmptyArchive: true
         }
      }
      
      failure {
         echo 'Pipeline falhou! Verifique os relatórios para mais detalhes.'
      }
      
      success {
         echo 'Pipeline executado com sucesso!'
      }
   }
}
