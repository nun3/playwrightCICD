pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/playwright:v1.30.0-focal'
            args '-v /dev/shm:/dev/shm'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                // Clona o seu repositório específico
                git branch: 'main', url: 'https://github.com/nun3/playwrightCICD.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Playwright Tests') {
            steps {
                sh 'npx playwright test'
            }
        }
    }
}
