# 🚀 Run and Show Results - Step by Step

## ✅ Services Are Starting!

I've started all services with `docker-compose up -d`. Here's how to see the results:

---

## 📋 Step 1: Check Service Status

Run this command to see all running services:
```powershell
docker-compose ps
```

Or:
```powershell
docker ps
```

---

## 🌐 Step 2: Open These URLs in Your Browser

### 1️⃣ Eureka Dashboard (Service Registry)
```
http://localhost:8761
```
**What you'll see:** All registered microservices with their status (UP/DOWN)

### 2️⃣ API Gateway
```
http://localhost:8765
```

### 3️⃣ Book Service Swagger UI
```
http://localhost:8081/swagger-ui.html
```
**What you'll see:** Interactive API documentation with all book endpoints

### 4️⃣ User Service Swagger UI
```
http://localhost:8082/swagger-ui.html
```
**What you'll see:** Interactive API documentation with all user endpoints

### 5️⃣ Order Service Swagger UI
```
http://localhost:8083/swagger-ui.html
```
**What you'll see:** Interactive API documentation with all order endpoints

### 6️⃣ Payment Service Swagger UI
```
http://localhost:8084/swagger-ui.html
```
**What you'll see:** Interactive API documentation with all payment endpoints

---

## 📡 Step 3: Test APIs

### Through API Gateway (Port 8765):

Open these URLs in your browser:

1. **Get All Books**: http://localhost:8765/books
2. **Get All Users**: http://localhost:8765/users
3. **Get All Orders**: http://localhost:8765/orders
4. **Get All Payments**: http://localhost:8765/payments

### Direct Service Access:

1. **Books**: http://localhost:8081/books
2. **Users**: http://localhost:8082/users
3. **Orders**: http://localhost:8083/orders
4. **Payments**: http://localhost:8084/payments

---

## 🧪 Step 4: Test in PowerShell

### Get All Books:
```powershell
Invoke-RestMethod -Uri http://localhost:8765/books -Method Get
```

### Get All Users:
```powershell
Invoke-RestMethod -Uri http://localhost:8765/users -Method Get
```

### Get All Orders:
```powershell
Invoke-RestMethod -Uri http://localhost:8765/orders -Method Get
```

### Get All Payments:
```powershell
Invoke-RestMethod -Uri http://localhost:8765/payments -Method Get
```

---

## 📊 Step 5: Check Database Data

```powershell
# Connect to MySQL
docker exec -it mysql mysql -u root -proot

# Then run these SQL commands:
SHOW DATABASES;
USE book_service_db;
SELECT * FROM books LIMIT 5;
USE user_service_db;
SELECT * FROM users LIMIT 5;
```

---

## 🔍 Step 6: View Service Logs

```powershell
# All services logs
docker-compose logs -f

# Specific service logs
docker-compose logs -f book-service
docker-compose logs -f user-service
docker-compose logs -f apigateway
```

---

## ✅ Expected Results

### In Eureka Dashboard (http://localhost:8761):
You should see these services registered:
- ✅ BOOK-SERVICE
- ✅ USER-SERVICE
- ✅ ORDER-SERVICE
- ✅ PAYMENT-SERVICE
- ✅ API-GATEWAY

### In Swagger UI:
- Interactive API documentation
- Try it out buttons
- Request/Response examples
- Schema definitions

### In API Responses:
You'll see JSON data like:
```json
[
  {
    "bookId": 1,
    "title": "The Great Gatsby",
    "author": "F. Scott Fitzgerald",
    "genre": "Fiction",
    "price": 12.99,
    "stock": 50
  }
]
```

---

## 🎯 Quick Verification Commands

```powershell
# Check if services are running
docker ps

# Check service health
Invoke-RestMethod -Uri http://localhost:8081/actuator/health
Invoke-RestMethod -Uri http://localhost:8082/actuator/health
Invoke-RestMethod -Uri http://localhost:8083/actuator/health
Invoke-RestMethod -Uri http://localhost:8084/actuator/health
```

---

## 📸 What to Show/Document

1. ✅ Eureka Dashboard screenshot (showing all services)
2. ✅ Swagger UI pages (for each service)
3. ✅ API response (JSON data from /books endpoint)
4. ✅ Docker containers status
5. ✅ Database query results

---

## 🛑 To Stop Services

```powershell
docker-compose down
```

---

**All services are running! Open the URLs above to see the results!** 🎉

