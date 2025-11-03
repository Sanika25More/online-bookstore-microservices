pipeline {
    agent any

    environment {
        MAVEN_HOME = "/usr/share/maven"
        DOCKER_HUB_REPO = "sani427"
        IMAGE_NAME = "onlinebookstore"
    }

    stages {

        stage('Checkout') {
            steps {
                echo '📦 Cloning Repository...'
                git branch: 'main', url: 'https://github.com/Sanika25More/online-bookstore-microservices.git'
            }
        }

        stage('Build') {
            steps {
                echo '⚙️ Building Project using Maven...'
                sh "mvn clean package -DskipTests"
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running Unit Tests...'
                sh "mvn test"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker Image...'
                sh "docker build -t ${DOCKER_HUB_REPO}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                echo '📤 Pushing Docker Image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_HUB_REPO}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy (Optional)') {
            steps {
                echo '🚀 Deployment stage (can include Kubernetes or server deploy commands here)'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Please check the logs.'
        }
        always {
            echo '📘 Pipeline completed (success or failure).'
        }
    }
}
