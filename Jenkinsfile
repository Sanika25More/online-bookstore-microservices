pipeline {
    agent any

    environment {
        COMPOSE_PROJECT_NAME = "bookstore"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Sanika25More/online-bookstore-microservices.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker compose -f ${DOCKER_COMPOSE_FILE} build'
            }
        }

        stage('Start Containers') {
            steps {
                sh 'docker compose -f ${DOCKER_COMPOSE_FILE} up -d'
            }
        }

        stage('Health Check') {
            steps {
                echo "Waiting for services to be healthy..."
                sh 'sleep 30'
                sh 'docker compose ps'
            }
        }

        stage('Integration Tests') {
            steps {
                echo "Running integration tests..."
                // Add test commands if available
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
        always {
            echo '🧹 Cleaning up workspace'
            sh 'docker compose -f ${DOCKER_COMPOSE_FILE} down --remove-orphans || true'
        }
    }
}
