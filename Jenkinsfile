pipeline {
    agent any

    tools {
        jdk 'jdk21'
        maven 'maven3'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_HUB_REPO = "sani427"
        IMAGE_NAME = "onlinebookstore"
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
                echo '🧪 Running Unit Tests...'
                bat 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker Image...'
                bat "docker build -t %DOCKER_HUB_REPO%/%IMAGE_NAME%:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                echo '⬆️ Pushing Docker image to DockerHub...'

                // ✅ First push (optional)
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    bat '''
                        echo Logging into Docker Hub...
                        echo %PASSWORD% | docker login -u %USERNAME% --password-stdin
                        docker push sani427/online-bookstore:latest
                    '''
                }

                // ✅ Second push (environment variables)
                echo '📤 Pushing Docker Image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push %DOCKER_HUB_REPO%/%IMAGE_NAME%:latest
                    """
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
