@echo off
echo Starting Online Bookstore Microservices...
echo.

echo Starting Eureka Server...
start "Eureka Server" cmd /k "cd eureka-server && mvn spring-boot:run"
timeout /t 10 /nobreak >nul

echo Starting Config Server...
start "Config Server" cmd /k "cd config-server && mvn spring-boot:run"
timeout /t 15 /nobreak >nul

echo Starting User Service...
start "User Service" cmd /k "cd user-service && mvn spring-boot:run"
timeout /t 10 /nobreak >nul

echo Starting Book Service...
start "Book Service" cmd /k "cd book-service && mvn spring-boot:run"
timeout /t 10 /nobreak >nul

echo Starting Order Service...
start "Order Service" cmd /k "cd order-service && mvn spring-boot:run"
timeout /t 10 /nobreak >nul

echo Starting Payment Service...
start "Payment Service" cmd /k "cd payment-service && mvn spring-boot:run"
timeout /t 10 /nobreak >nul

echo Starting API Gateway...
start "API Gateway" cmd /k "cd apigateway && mvn spring-boot:run"
timeout /t 10 /nobreak >nul

echo.
echo All services are starting up!
echo.
echo Service URLs:
echo - Eureka Server: http://localhost:8761
echo - Config Server: http://localhost:8889
echo - User Service: http://localhost:8082
echo - Book Service: http://localhost:8081
echo - Order Service: http://localhost:8083
echo - Payment Service: http://localhost:8084
echo - API Gateway: http://localhost:9090
echo.
echo Wait for all services to start up completely before testing.
echo Check Eureka dashboard at http://localhost:8761 to see registered services.
echo.
pause

