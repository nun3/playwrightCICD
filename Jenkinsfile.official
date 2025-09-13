pipeline {
   agent { docker { image 'mcr.microsoft.com/playwright:v1.55.0-noble' } }
   
   environment {
      CI = 'true'
   }
   
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
      
      stage('Install Playwright Browsers') {
         steps {
            sh 'npx playwright install --with-deps'
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
         // Publicar relatórios HTML
         publishHTML([
            allowMissing: false,
            alwaysLinkToLastBuild: true,
            keepAll: true,
            reportDir: 'playwright-report',
            reportFiles: 'index.html',
            reportName: 'Playwright Test Report'
         ])
         
         // Publicar resultados JUnit
         junit 'test-results/junit.xml'
         
         // Arquivos de evidência (screenshots, traces)
         archiveArtifacts artifacts: 'test-results/**/*', allowEmptyArchive: true
      }
      
      failure {
         echo 'Pipeline falhou! Verifique os relatórios para mais detalhes.'
      }
      
      success {
         echo 'Pipeline executado com sucesso!'
      }
   }
}
