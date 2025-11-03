# Run API Gateway - Standalone Method

Since Docker Compose has port conflicts, here's how to run API Gateway standalone:

## Option 1: Run from IDE (Easiest)

1. Open the project in your IDE (IntelliJ/Eclipse/VS Code)
2. Navigate to: `apigateway/src/main/java/com/bookstore/apigateway/ApiGatewayApplication.java`
3. Right-click → Run `ApiGatewayApplication`
4. API Gateway will start on http://localhost:8765

## Option 2: Run from Command Line (Maven)

```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices\apigateway"
mvn spring-boot:run
```

**Note:** Make sure other services (Eureka, Config Server) are running first!

## Option 3: Run JAR File Directly

```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices\apigateway"
java -jar target/apigateway-1.0.0.jar
```

## Verify API Gateway is Running

### Check Port:
```powershell
netstat -ano | findstr ":8765"
```

### Test Health Endpoint:
```powershell
Invoke-WebRequest -Uri http://localhost:8765/actuator/health
```

### Test Routes:
```powershell
# Books
Invoke-WebRequest -Uri http://localhost:8765/books

# Users
Invoke-WebRequest -Uri http://localhost:8765/users

# Orders
Invoke-WebRequest -Uri http://localhost:8765/orders

# Payments
Invoke-WebRequest -Uri http://localhost:8765/payments
```

## Prerequisites

Before running API Gateway standalone, ensure:
- ✅ Eureka Server is running on port 8761
- ✅ Config Server is running on port 8889 (or make it optional)
- ✅ Book Service is running and registered with Eureka
- ✅ User Service is running and registered with Eureka
- ✅ Order Service is running and registered with Eureka
- ✅ Payment Service is running and registered with Eureka

## Expected Output

When API Gateway starts successfully, you'll see:
```
Started ApiGatewayApplication in X.XXX seconds
```

Then you can access:
- **Health:** http://localhost:8765/actuator/health
- **Books:** http://localhost:8765/books
- **Users:** http://localhost:8765/users
- **Orders:** http://localhost:8765/orders
- **Payments:** http://localhost:8765/payments

