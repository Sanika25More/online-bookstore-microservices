# Online Bookstore Microservices

This project implements a microservices architecture for an online bookstore using Spring Boot, Spring Cloud, Eureka Server, and Spring Cloud Gateway.

## Architecture

- **Eureka Server** (Port 8761): Service discovery and registration
- **Config Server** (Port 8889): Centralized configuration management
- **API Gateway** (Port 9090): Single entry point for all microservices
- **User Service** (Port 8082): User management
- **Book Service** (Port 8081): Book catalog management
- **Order Service** (Port 8083): Order processing
- **Payment Service** (Port 8084): Payment processing

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher
- MySQL 8.0 or higher

## Database Setup

Create the following databases in MySQL:

```sql
CREATE DATABASE user_service_db;
CREATE DATABASE book_service_db;
CREATE DATABASE order_service_db;
CREATE DATABASE payment_service_db;
```

## Running the Services

### Option 1: Using the Batch Script (Windows)

1. Double-click `start-services.bat`
2. Wait for all services to start up
3. Check Eureka dashboard at http://localhost:8761

### Option 2: Manual Startup

Start services in the following order:

1. **Eureka Server**
   ```bash
   cd eureka-server
   mvn spring-boot:run
   ```

2. **Config Server**
   ```bash
   cd config-server
   mvn spring-boot:run
   ```

3. **Microservices** (in any order)
   ```bash
   cd user-service
   mvn spring-boot:run
   
   cd book-service
   mvn spring-boot:run
   
   cd order-service
   mvn spring-boot:run
   
   cd payment-service
   mvn spring-boot:run
   ```

4. **API Gateway**
   ```bash
   cd apigateway
   mvn spring-boot:run
   ```

## Service URLs

- **Eureka Dashboard**: http://localhost:8761
- **Config Server**: http://localhost:8889
- **API Gateway**: http://localhost:9090

### API Gateway Routes

- **User Service**: http://localhost:9090/users/**
- **Book Service**: http://localhost:9090/books/**
- **Order Service**: http://localhost:9090/orders/**
- **Payment Service**: http://localhost:9090/payments/**

## Configuration

All services are configured to:
- Register with Eureka Server
- Use Config Server for centralized configuration
- Use MySQL databases for data persistence
- Support load balancing through API Gateway

## Testing

1. Check Eureka dashboard to ensure all services are registered
2. Test API endpoints through the API Gateway
3. Verify service-to-service communication

## Troubleshooting

- Ensure MySQL is running and databases are created
- Check that all services are running on their assigned ports
- Verify Eureka registration in the dashboard
- Check logs for any configuration or connection issues

