pipeline {
    agent any

    environment {
        MAVEN_HOME = "/usr/share/maven"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning Repository...'
                git branch: 'main', url: 'https://github.com/Sanika25More/onlinebookstoremicroservices.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building with Maven...'
                sh "mvn clean package -DskipTests"
            }
        }

        stage('Test') {
            steps {
                echo 'Running Unit Tests...'
                sh "mvn test"
            }
        }

        stage('Build Docker Images') {
            steps {
                echo 'Building Docker Images for each microservice...'
                script {
                    def services = ["config-server", "discovery-server", "api-gateway", "book-service", "order-service", "user-service"]
                    for (svc in services) {
                        sh "docker build -t sani427/${svc}:latest -f ${svc}/Dockerfile ${svc}"
                    }
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                echo 'Pushing Docker Images to Docker Hub...'
                script {
                    def services = ["config-server", "discovery-server", "api-gateway", "book-service", "order-service", "user-service"]
                    for (svc in services) {
                        sh "docker push sani427/${svc}:latest"
                    }
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                echo 'Deploying all services to Minikube...'
                sh "kubectl apply -f k8s/deployments/"
                sh "kubectl apply -f k8s/services/"
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
    }
}
