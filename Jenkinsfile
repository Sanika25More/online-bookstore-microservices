pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
    }

    stages {
        stage('Cleanup') {
            steps {
                echo '🧹 Cleaning workspace...'
                cleanWs()
            }
        }

        stage('Checkout') {
            steps {
                echo '📦 Cloning Repository...'
                git branch: 'main', url: 'https://github.com/Sanika25More/online-bookstore-microservices.git'
            }
        }

        stage('Build') {
            steps {
                echo '⚙️ Building Project using Maven...'
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running Tests...'
                bat 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                bat 'docker build -t sani427/online-bookstore:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                echo '⬆️ Pushing Docker image to DockerHub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    bat '''
                        echo Logging into Docker Hub...
                        echo %PASSWORD% | docker login -u %USERNAME% --password-stdin
                        docker push sani427/online-bookstore:latest
                    '''
                }
            }
        }

        stage('Deploy (Optional)') {
            steps {
                echo '🚀 Deployment stage (can be integrated with Kubernetes or Docker Compose).'
            }
        }
    }

    post {
        always {
            echo '📘 Pipeline completed (success or failure).'
        }
        success {
            echo '✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Please check the logs.'
        }
    }
}
