// Jenkinsfile - Declarative Pipeline for Online Bookstore Microservices
pipeline {
  agent any

  environment {
    // Change these image prefix/tag as needed
    DOCKER_REGISTRY = "docker.io"
    IMAGE_PREFIX = "sani427"            // replace with your Docker Hub username
    COMPOSE_FILE = "docker-compose.yml"
  }

  options {
    // Keep last 10 builds
    buildDiscarder(logRotator(numToKeepStr: '10'))
    timestamps()
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Setup JDK & Maven') {
      steps {
        echo "Ensure Java/Maven available on agent"
        // If you have Jenkins tools configured, you could use tool(...) here.
      }
    }

    stage('Build with Maven') {
      steps {
        echo "Running mvn clean package -DskipTests"
        sh 'mvn clean package -DskipTests'
      }
    }

    stage('Build Docker Images') {
      steps {
        script {
          // Build using docker-compose so it picks up service Dockerfiles
          sh "docker compose -f ${env.COMPOSE_FILE} build --parallel"
        }
      }
    }

    stage('Login to Docker Hub') {
      steps {
        // Use credentials stored in Jenkins (dockerhub-creds)
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
          '''
        }
      }
    }

    stage('Push Docker Images') {
      steps {
        script {
          // Push images defined in docker-compose (ensure images: tags exist in compose file)
          // This uses docker compose push; your compose file must have image: fields set
          sh "docker compose -f ${env.COMPOSE_FILE} push || true"
        }
      }
    }

    stage('Deploy (docker-compose)') {
      steps {
        echo "Deploying containers via docker compose"
        sh "docker compose -f ${env.COMPOSE_FILE} up -d"
      }
    }

    stage('Health Check / Integration smoke tests') {
      steps {
        echo "Waiting for services to start..."
        sh 'sleep 20'
        // Example simple check (customize to your endpoints)
        sh '''
          echo "Listing containers..."
          docker ps --format "table {{.Names}}\\t{{.Status}}\\t{{.Image}}"
        '''
        // Add any curl checks you want, e.g.
        // sh 'curl -fsS http://localhost:8081/actuator/health'
      }
    }
  }

  post {
    success {
      echo 'Pipeline completed successfully.'
    }
    failure {
      echo 'Pipeline failed.'
    }
    always {
      // Optional: keep services running; if you want to teardown, uncomment next line
      // sh "docker compose -f ${env.COMPOSE_FILE} down --remove-orphans"
    }
  }
}
