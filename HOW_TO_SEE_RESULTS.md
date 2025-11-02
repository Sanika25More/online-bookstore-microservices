# How to See the Results - Phase 5 Implementation Guide

This guide will help you see and test all the Phase 5 features including Swagger documentation, database schemas, and CI/CD pipeline.

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Starting the Services](#starting-the-services)
3. [Accessing Swagger API Documentation](#accessing-swagger-api-documentation)
4. [Viewing Database Data](#viewing-database-data)
5. [Testing APIs](#testing-apis)
6. [CI/CD Pipeline Results](#cicd-pipeline-results)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before starting, ensure you have:
- ✅ Docker and Docker Compose installed
- ✅ Java 17+ (for local development)
- ✅ Maven 3.8+ (for building)
- ✅ MySQL client (optional, for direct database access)
- ✅ Web browser (for Swagger UI)

---

## Starting the Services

### Option 1: Using Docker Compose (Recommended)

```bash
# Navigate to project directory
cd online-bookstore-microservices

# Start all services
docker-compose up -d

# Check if all services are running
docker-compose ps

# View logs
docker-compose logs -f
```

**Expected Output:**
- Config Server: Running on port 8889
- Eureka Server: Running on port 8761
- MySQL: Running on port 3306
- Book Service: Running on port 8081
- User Service: Running on port 8082
- Order Service: Running on port 8083
- Payment Service: Running on port 8084
- API Gateway: Running on port 8765

### Option 2: Start Services Manually

If you prefer to run services individually:

```bash
# Terminal 1: Start MySQL
docker run -d -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=root \
  -v $(pwd)/mysql-init:/docker-entrypoint-initdb.d \
  --name mysql mysql:8.0

# Terminal 2: Start Config Server
cd config-server && mvn spring-boot:run

# Terminal 3: Start Eureka Server
cd eureka-server && mvn spring-boot:run

# Terminal 4: Start Book Service
cd book-service && mvn spring-boot:run

# Terminal 5: Start User Service
cd user-service && mvn spring-boot:run

# Terminal 6: Start Order Service
cd order-service && mvn spring-boot:run

# Terminal 7: Start Payment Service
cd payment-service && mvn spring-boot:run

# Terminal 8: Start API Gateway
cd apigateway && mvn spring-boot:run
```

---

## Accessing Swagger API Documentation

Once services are running, access Swagger UI in your browser:

### 🌐 Swagger UI URLs

1. **Book Service Swagger**
   - URL: http://localhost:8081/swagger-ui.html
   - API Docs: http://localhost:8081/api-docs
   - Features: View all book-related APIs, test endpoints

2. **User Service Swagger**
   - URL: http://localhost:8082/swagger-ui.html
   - API Docs: http://localhost:8082/api-docs
   - Features: View all user-related APIs, test endpoints

3. **Order Service Swagger**
   - URL: http://localhost:8083/swagger-ui.html
   - API Docs: http://localhost:8083/api-docs
   - Features: View all order-related APIs, test endpoints

4. **Payment Service Swagger**
   - URL: http://localhost:8084/swagger-ui.html
   - API Docs: http://localhost:8084/api-docs
   - Features: View all payment-related APIs, test endpoints

### 📝 How to Use Swagger UI

1. Open any Swagger UI URL in your browser
2. You'll see all available endpoints listed
3. Click on an endpoint to expand it
4. Click "Try it out" button
5. Fill in parameters (if needed)
6. Click "Execute" to test the API
7. View the response below

### Example: Testing Book Service

1. Go to http://localhost:8081/swagger-ui.html
2. Find `GET /books` endpoint
3. Click "Try it out"
4. Click "Execute"
5. You should see a list of 15 books in the response

---

## Viewing Database Data

### Option 1: Using MySQL Command Line

```bash
# Connect to MySQL
mysql -h localhost -u root -proot

# Show all databases
SHOW DATABASES;

# View books
USE book_service_db;
SELECT * FROM books;

# View users
USE user_service_db;
SELECT * FROM users;

# View orders
USE order_service_db;
SELECT * FROM orders;

# View payments
USE payment_service_db;
SELECT * FROM payments;
```

### Option 2: Using Docker Exec

```bash
# Access MySQL container
docker exec -it mysql bash

# Login to MySQL
mysql -u root -proot

# Then run the same SQL queries as above
```

### Option 3: Using Database GUI Tools

Use tools like:
- MySQL Workbench
- DBeaver
- phpMyAdmin
- DataGrip

**Connection Details:**
- Host: localhost
- Port: 3306
- Username: root
- Password: root

**Databases:**
- `book_service_db` (15 books)
- `user_service_db` (10 users)
- `order_service_db` (15 orders)
- `payment_service_db` (15 payments)

### Quick Verification Queries

```sql
-- Count books
SELECT COUNT(*) FROM book_service_db.books;
-- Expected: 15

-- Count users
SELECT COUNT(*) FROM user_service_db.users;
-- Expected: 10

-- Count orders
SELECT COUNT(*) FROM order_service_db.orders;
-- Expected: 15

-- Count payments
SELECT COUNT(*) FROM payment_service_db.payments;
-- Expected: 15
```

---

## Testing APIs

### Using cURL Commands

#### Through API Gateway (Port 8765)

```bash
# Get all books
curl http://localhost:8765/books

# Get book by ID
curl http://localhost:8765/books/1

# Get all users
curl http://localhost:8765/users

# Get user by ID
curl http://localhost:8765/users/1

# Get all orders
curl http://localhost:8765/orders

# Get orders by user
curl http://localhost:8765/orders/user/1

# Get all payments
curl http://localhost:8765/payments

# Get payment by ID
curl http://localhost:8765/payments/1
```

#### Direct Service Access

```bash
# Book Service
curl http://localhost:8081/books
curl http://localhost:8081/books/1

# User Service
curl http://localhost:8082/users
curl http://localhost:8082/users/1

# Order Service
curl http://localhost:8083/orders
curl http://localhost:8083/orders/1

# Payment Service
curl http://localhost:8084/payments
curl http://localhost:8084/payments/1
```

### Using Browser

Simply open these URLs in your browser:

- Books: http://localhost:8765/books
- Users: http://localhost:8765/users
- Orders: http://localhost:8765/orders
- Payments: http://localhost:8765/payments

### Using Postman

1. Import the collection (or create manually)
2. Set base URL: `http://localhost:8765`
3. Test endpoints:
   - GET `/books`
   - GET `/users`
   - GET `/orders`
   - GET `/payments`

---

## Service Monitoring

### Eureka Dashboard

Access Eureka Server dashboard to see registered services:

- **URL**: http://localhost:8761
- **What you'll see:**
  - List of all registered microservices
  - Service health status
  - Instance information

### Health Checks

```bash
# Book Service Health
curl http://localhost:8081/actuator/health

# User Service Health
curl http://localhost:8082/actuator/health

# Order Service Health
curl http://localhost:8083/actuator/health

# Payment Service Health
curl http://localhost:8084/actuator/health

# API Gateway Health
curl http://localhost:8765/actuator/health
```

---

## CI/CD Pipeline Results

### Viewing GitHub Actions Results

1. **Go to your GitHub repository**
2. **Click on "Actions" tab**
3. **You'll see workflow runs listed**

### For Each Workflow Run:

#### 1. Build and Test Job
- Shows compilation results for each service
- Displays test results
- Indicates success/failure for each microservice

**What to check:**
- ✅ All services compile successfully
- ✅ All tests pass
- ✅ JAR files are generated

#### 2. Docker Build Job
- Shows Docker image build progress
- Displays push status to container registry
- Shows image tags

**What to check:**
- ✅ All Docker images build successfully
- ✅ Images are pushed to registry
- ✅ Correct tags are applied

#### 3. Security Scan Job
- Shows vulnerability scan results
- Lists security issues (if any)

**What to check:**
- ✅ No critical vulnerabilities
- ✅ Review warnings if any
- ✅ Security report uploaded

#### 4. Deploy Job (if enabled)
- Shows deployment progress
- Displays service status

**What to check:**
- ✅ Services deploy successfully
- ✅ Health checks pass
- ✅ Services are accessible

### Viewing Logs

1. Click on a workflow run
2. Click on a specific job
3. Expand steps to see detailed logs
4. Download logs if needed

### Running CI/CD Pipeline

#### Trigger Methods:

1. **Push to main/develop branch**
   ```bash
   git add .
   git commit -m "Update code"
   git push origin main
   ```

2. **Create Pull Request**
   - Create PR to main/develop
   - Pipeline runs automatically

3. **Manual Trigger**
   - Go to Actions tab
   - Select workflow
   - Click "Run workflow"

---

## Verification Checklist

### ✅ Services Running

- [ ] Config Server: http://localhost:8889
- [ ] Eureka Server: http://localhost:8761
- [ ] API Gateway: http://localhost:8765
- [ ] Book Service: http://localhost:8081
- [ ] User Service: http://localhost:8082
- [ ] Order Service: http://localhost:8083
- [ ] Payment Service: http://localhost:8084

### ✅ Swagger Documentation

- [ ] Book Service Swagger: http://localhost:8081/swagger-ui.html
- [ ] User Service Swagger: http://localhost:8082/swagger-ui.html
- [ ] Order Service Swagger: http://localhost:8083/swagger-ui.html
- [ ] Payment Service Swagger: http://localhost:8084/swagger-ui.html

### ✅ Database Data

- [ ] 15 books in `book_service_db.books`
- [ ] 10 users in `user_service_db.users`
- [ ] 15 orders in `order_service_db.orders`
- [ ] 15 payments in `payment_service_db.payments`

### ✅ APIs Working

- [ ] GET /books returns list
- [ ] GET /users returns list
- [ ] GET /orders returns list
- [ ] GET /payments returns list

### ✅ CI/CD Pipeline

- [ ] Workflow runs successfully
- [ ] All builds pass
- [ ] Docker images created
- [ ] Security scan completes

---

## Troubleshooting

### Services Not Starting

```bash
# Check Docker status
docker ps -a

# View service logs
docker-compose logs <service-name>

# Restart specific service
docker-compose restart <service-name>
```

### Database Connection Issues

```bash
# Check MySQL is running
docker ps | grep mysql

# Test MySQL connection
docker exec -it mysql mysql -u root -proot -e "SHOW DATABASES;"

# Recreate database
docker-compose down -v
docker-compose up -d mysql
```

### Swagger UI Not Loading

1. Check service is running: `curl http://localhost:8081/actuator/health`
2. Verify SpringDoc dependency in pom.xml
3. Check application.properties for Swagger config
4. Rebuild service: `mvn clean install`

### API Gateway Not Routing

1. Check Eureka dashboard: http://localhost:8761
2. Verify services are registered
3. Check API Gateway routes in application.properties
4. Restart API Gateway: `docker-compose restart apigateway`

### Port Already in Use

```bash
# Find process using port
# Windows
netstat -ano | findstr :8765

# Linux/Mac
lsof -i :8765

# Kill process or change port in application.properties
```

---

## Quick Start Script

Create a file `check-services.sh`:

```bash
#!/bin/bash

echo "Checking all services..."

echo -n "Config Server: "
curl -s http://localhost:8889/actuator/health > /dev/null && echo "✅" || echo "❌"

echo -n "Eureka Server: "
curl -s http://localhost:8761 > /dev/null && echo "✅" || echo "❌"

echo -n "API Gateway: "
curl -s http://localhost:8765/actuator/health > /dev/null && echo "✅" || echo "❌"

echo -n "Book Service: "
curl -s http://localhost:8081/actuator/health > /dev/null && echo "✅" || echo "❌"

echo -n "User Service: "
curl -s http://localhost:8082/actuator/health > /dev/null && echo "✅" || echo "❌"

echo -n "Order Service: "
curl -s http://localhost:8083/actuator/health > /dev/null && echo "✅" || echo "❌"

echo -n "Payment Service: "
curl -s http://localhost:8084/actuator/health > /dev/null && echo "✅" || echo "❌"

echo ""
echo "Swagger URLs:"
echo "Book Service: http://localhost:8081/swagger-ui.html"
echo "User Service: http://localhost:8082/swagger-ui.html"
echo "Order Service: http://localhost:8083/swagger-ui.html"
echo "Payment Service: http://localhost:8084/swagger-ui.html"
```

Make it executable: `chmod +x check-services.sh`  
Run it: `./check-services.sh`

---

## Summary

After following this guide, you should be able to:

✅ See all services running  
✅ Access Swagger documentation for each service  
✅ View database data with sample records  
✅ Test APIs through Swagger UI or curl  
✅ Monitor services through Eureka dashboard  
✅ View CI/CD pipeline results on GitHub  

**All Phase 5 features are now accessible and ready to use!** 🎉

