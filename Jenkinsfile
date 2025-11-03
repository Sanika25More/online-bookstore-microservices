pipeline {
    agent any

    tools {
        jdk 'jdk21'
        maven 'maven3'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_HUB_REPO = "sani427"
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

        stage('Build with Maven') {
            steps {
                echo '⚙️ Building all microservices...'
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build & Push Docker Images') {
            steps {
                script {
                    def services = ['user-service', 'book-service', 'order-service', 'payment-service']

                    for (svc in services) {
                        echo "🐳 Building Docker image for ${svc}..."
                        dir(svc) {
                            bat "docker build -t ${DOCKER_HUB_REPO}/${svc}:latest ."
                        }

                        echo "⬆️ Pushing ${svc} image to Docker Hub..."
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                            bat """
                                echo %PASSWORD% | docker login -u %USERNAME% --password-stdin
                                docker push ${DOCKER_HUB_REPO}/${svc}:latest
                            """
                        }
                    }
                }
            }
        }

        stage('Deploy (Optional)') {
            steps {
                echo '🚀 You can integrate Kubernetes or Docker Compose here later.'
            }
        }
    }

    post {
        always {
            echo '📘 Pipeline completed (success or failure).'
        }
        success {
            echo '✅ All microservices built and pushed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Please check logs.'
        }
    }
}
