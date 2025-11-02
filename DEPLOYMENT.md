# Deployment Guide - Phase 5: Cloud Deployment with CI/CD

This guide covers the deployment of the Online Bookstore Microservices application on cloud platforms with CI/CD pipeline.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Swagger API Documentation](#swagger-api-documentation)
3. [Database Setup](#database-setup)
4. [CI/CD Pipeline](#cicd-pipeline)
5. [Cloud Deployment Options](#cloud-deployment-options)
6. [Accessing Services](#accessing-services)

## Prerequisites

- Java 17 or higher
- Maven 3.8+
- Docker and Docker Compose
- MySQL 8.0+
- Git
- Cloud Provider Account (AWS, Azure, GCP, etc.)
- Kubernetes cluster (for K8s deployment)

## Swagger API Documentation

Each microservice now includes Swagger/OpenAPI documentation. Access the Swagger UI at:

- **Book Service**: http://localhost:8081/swagger-ui.html
- **User Service**: http://localhost:8082/swagger-ui.html
- **Order Service**: http://localhost:8083/swagger-ui.html
- **Payment Service**: http://localhost:8084/swagger-ui.html

### API Documentation Features

- Interactive API testing
- Request/Response schemas
- Parameter descriptions
- Example requests and responses
- Authentication support (if configured)

### Configuration

Swagger is automatically configured in each service. Customize it in:
- `SwaggerConfig.java` in each service's config package
- Application properties for advanced settings

## Database Setup

### MySQL Schema with Sample Data

The database schemas are located in:
- `mysql-init/` directory - Individual SQL files for Docker initialization
- `init.sql` - Complete schema with all tables and sample data

### Database Schemas

#### 1. Book Service Database (`book_service_db`)
- **Table**: `books`
- **Fields**: book_id, title, author, genre, price, stock
- **Sample Data**: 15 books pre-loaded

#### 2. User Service Database (`user_service_db`)
- **Table**: `users`
- **Fields**: user_id, name, email, password, role, address
- **Sample Data**: 10 users pre-loaded (1 admin, 9 buyers)

#### 3. Order Service Database (`order_service_db`)
- **Table**: `orders`
- **Fields**: id, user_id, book_id, quantity, total_price, order_date, status
- **Sample Data**: 15 orders pre-loaded with various statuses

#### 4. Payment Service Database (`payment_service_db`)
- **Table**: `payments`
- **Fields**: id, order_id, amount, method, status, transaction_id, payment_date
- **Sample Data**: 15 payments pre-loaded matching orders

### Initializing Database

#### Using Docker Compose

```bash
cd online-bookstore-microservices
docker-compose up -d mysql
```

The MySQL container will automatically execute scripts in `mysql-init/` directory.

#### Manual Setup

```bash
mysql -u root -p < init.sql
```

## CI/CD Pipeline

### GitHub Actions Workflows

Two workflows are configured:

1. **Main CI/CD Pipeline** (`.github/workflows/ci-cd.yml`)
   - Builds and tests all microservices
   - Builds Docker images
   - Security scanning
   - Cloud deployment
   - Notifications

2. **Docker Compose Deployment** (`.github/workflows/docker-compose-deploy.yml`)
   - Docker Compose based deployment
   - Integration testing
   - Health checks

### Pipeline Stages

1. **Build & Test**
   - Compiles all services
   - Runs unit tests
   - Generates JAR artifacts

2. **Docker Build**
   - Builds Docker images for all services
   - Pushes to GitHub Container Registry
   - Tags images with SHA, branch, and version

3. **Security Scan**
   - Trivy vulnerability scanning
   - Reports to GitHub Security tab

4. **Deploy**
   - Kubernetes deployment
   - Service health checks
   - Rolling updates

### Setting Up CI/CD

1. **Enable GitHub Actions** in your repository settings

2. **Configure Secrets** (if needed):
   - `KUBECONFIG` - Kubernetes configuration
   - Cloud provider credentials

3. **Trigger Pipeline**:
   - Push to `main` or `develop` branch
   - Create a pull request
   - Push version tags (v*.*.*)

### Viewing Pipeline Results

- Go to GitHub repository → Actions tab
- View workflow runs and job logs
- Check security scan results in Security tab

## Cloud Deployment Options

### Option 1: Docker Compose (Local/Simple Cloud)

```bash
docker-compose up -d
```

### Option 2: Kubernetes

#### Prerequisites
- Kubernetes cluster (local or cloud)
- kubectl configured
- Helm (optional)

#### Deployment Steps

```bash
# Apply configurations
kubectl apply -f k8s/services/
kubectl apply -f k8s/deployments/

# Check status
kubectl get pods
kubectl get services
```

#### Kubernetes Services

- Config Server: Port 8889
- Eureka Server: Port 8761
- API Gateway: Port 8765
- Book Service: Port 8081
- User Service: Port 8082
- Order Service: Port 8083
- Payment Service: Port 8084
- MySQL: Port 3306

### Option 3: AWS Deployment

#### Using AWS ECS/EKS

1. Build and push images to Amazon ECR
2. Create ECS task definitions or EKS deployments
3. Configure load balancers
4. Set up RDS for MySQL

#### AWS Resources Needed
- ECS Cluster or EKS Cluster
- RDS MySQL instance
- Application Load Balancer
- Security Groups
- IAM Roles

### Option 4: Azure Deployment

#### Using Azure Kubernetes Service (AKS)

1. Create AKS cluster
2. Configure Azure Container Registry (ACR)
3. Deploy using kubectl or Azure DevOps
4. Use Azure Database for MySQL

### Option 5: Google Cloud Platform (GCP)

#### Using Google Kubernetes Engine (GKE)

1. Create GKE cluster
2. Configure Google Container Registry
3. Deploy services
4. Use Cloud SQL for MySQL

## Accessing Services

### Local Development

After starting services:

- **API Gateway**: http://localhost:8765
- **Eureka Dashboard**: http://localhost:8761
- **Config Server**: http://localhost:8889

### Service Endpoints

All services are accessible through API Gateway:

- **Books**: http://localhost:8765/books
- **Users**: http://localhost:8765/users
- **Orders**: http://localhost:8765/orders
- **Payments**: http://localhost:8765/payments

### Direct Service Access

- **Book Service**: http://localhost:8081/books
- **User Service**: http://localhost:8082/users
- **Order Service**: http://localhost:8083/orders
- **Payment Service**: http://localhost:8084/payments

### Swagger UI

- **Book Service Swagger**: http://localhost:8081/swagger-ui.html
- **User Service Swagger**: http://localhost:8082/swagger-ui.html
- **Order Service Swagger**: http://localhost:8083/swagger-ui.html
- **Payment Service Swagger**: http://localhost:8084/swagger-ui.html

## Monitoring and Health Checks

### Actuator Endpoints

Each service exposes Spring Boot Actuator endpoints:

- Health: `/actuator/health`
- Info: `/actuator/info`
- Metrics: `/actuator/metrics`

### Example Health Check

```bash
curl http://localhost:8081/actuator/health
curl http://localhost:8082/actuator/health
curl http://localhost:8083/actuator/health
curl http://localhost:8084/actuator/health
```

## Troubleshooting

### Common Issues

1. **Services not starting**
   - Check MySQL connection
   - Verify Eureka Server is running
   - Check Config Server accessibility

2. **Database connection errors**
   - Verify MySQL is running
   - Check database credentials
   - Ensure databases are created

3. **Swagger UI not accessible**
   - Verify SpringDoc dependency is added
   - Check application port
   - Ensure controller annotations are correct

4. **CI/CD Pipeline failures**
   - Check build logs
   - Verify Maven dependencies
   - Check Docker build context

## Best Practices

1. **Security**
   - Use secrets management for credentials
   - Enable HTTPS in production
   - Implement authentication/authorization

2. **Monitoring**
   - Set up application monitoring (Prometheus, Grafana)
   - Configure log aggregation
   - Set up alerting

3. **Scalability**
   - Configure auto-scaling
   - Use load balancers
   - Implement circuit breakers

4. **Backup**
   - Regular database backups
   - Configuration versioning
   - Disaster recovery plan

## Support

For issues or questions:
- Check service logs
- Review GitHub Actions workflow logs
- Consult Swagger documentation
- Review Kubernetes events (if using K8s)

