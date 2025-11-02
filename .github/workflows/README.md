# CI/CD Pipeline Documentation

This directory contains GitHub Actions workflows for automated CI/CD pipeline.

## Workflows

### 1. `ci-cd.yml` - Main CI/CD Pipeline

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop` branches

**Jobs:**

1. **Build and Test** - Builds and tests all microservices:
   - Config Server
   - Eureka Server
   - API Gateway
   - Book Service
   - User Service
   - Order Service
   - Payment Service

2. **Build Docker Images** - Builds and pushes Docker images to GitHub Container Registry:
   - Only runs on push events
   - Tags images with SHA, branch name, and version tags
   - Uses Docker Buildx for multi-platform support
   - Implements caching for faster builds

3. **Security Scan** - Runs Trivy vulnerability scanner:
   - Scans file system for vulnerabilities
   - Uploads results to GitHub Security tab

4. **Deploy** - Deploys to cloud environment:
   - Only runs on pushes to `main` branch
   - Configures Kubernetes
   - Deploys all microservices
   - Runs health checks

5. **Notify** - Sends notifications:
   - Success/failure notifications (can be extended with Slack, Email, etc.)

### 2. `docker-compose-deploy.yml` - Docker Compose Deployment

**Triggers:**
- Push to `main` branch
- Version tags (v*)
- Manual workflow dispatch

**Jobs:**
- Builds all services using Docker Compose
- Starts services
- Runs health checks
- Runs integration tests
- Stops services

## Configuration

### Required Secrets

For cloud deployment, you may need to configure the following secrets in GitHub:

- `KUBECONFIG` - Kubernetes configuration
- `DOCKER_REGISTRY_TOKEN` - Docker registry authentication token (if using private registry)
- Cloud provider credentials (AWS, Azure, GCP, etc.)

### Environment Variables

- `JAVA_VERSION`: Java version (default: 17)
- `MAVEN_VERSION`: Maven version (default: 3.8.6)
- `REGISTRY`: Container registry (default: ghcr.io)

## Usage

### Running the Pipeline

1. Push code to `main` or `develop` branch to trigger the pipeline
2. Create a pull request to trigger tests
3. Push a tag starting with `v` to trigger deployment

### Viewing Results

- Go to the "Actions" tab in your GitHub repository
- Select the workflow run to view details
- Check individual job logs for debugging

## Customization

### Adding New Services

1. Add the service name to the matrix in `build-and-test` job
2. Add the service name to the matrix in `build-docker-images` job
3. Update Kubernetes deployment files if deploying to K8s

### Cloud Provider Configuration

The deploy job can be customized for different cloud providers:

- **AWS**: Use AWS EKS with aws-actions/amazon-eks-deploy
- **Azure**: Use Azure Kubernetes Service with azure/k8s-deploy
- **GCP**: Use Google Kubernetes Engine with google-github-actions/deploy-cloudrun
- **Kubernetes**: Direct kubectl deployment (as shown)

### Notification Setup

Extend the `notify` job to send notifications via:
- Slack: Use `slackapi/slack-github-action`
- Email: Use `sendgrid/sendgrid-nodejs`
- Teams: Use `OfficeDev/microsoft-teams-actions`

## Best Practices

1. **Branch Protection**: Enable branch protection rules on `main` branch
2. **Review Requirements**: Require pull request reviews before merging
3. **Status Checks**: Require all CI checks to pass before merging
4. **Secrets Management**: Store sensitive data in GitHub Secrets
5. **Environment Protection**: Use GitHub Environments for production deployments

## Troubleshooting

### Build Failures

- Check Maven dependencies in `pom.xml`
- Verify Java version compatibility
- Check Dockerfile syntax

### Deployment Failures

- Verify Kubernetes configuration
- Check cloud provider credentials
- Review service health check endpoints

### Security Scan Failures

- Review vulnerability reports
- Update dependencies with known vulnerabilities
- Use dependency management tools

