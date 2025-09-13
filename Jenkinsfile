pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Clona o seu repositório específico
                git branch: 'main', url: 'https://github.com/nun3/playwrightCICD.git'
            }
        }

        stage('Install Node.js') {
            steps {
                sh '''
                    # Instalar Node.js 18 sem sudo
                    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
                    apt-get update
                    apt-get install -y nodejs
                    
                    # Verificar instalação
                    node --version
                    npm --version
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
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
}
