  post {
    success {
      echo '✅ Pipeline completed successfully.'
    }
    failure {
      echo '❌ Pipeline failed.'
    }
    always {
      echo '🧹 Cleaning up workspace (always runs)'
      // Optional cleanup commands:
      // sh "docker compose -f ${env.COMPOSE_FILE} down --remove-orphans"
    }
  }
