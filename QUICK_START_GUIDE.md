# 🚀 Quick Start Guide - Run and Show Results

## Step-by-Step Instructions

### 1. Build and Start Services

```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices"
docker-compose up -d --build
```

**Wait 2-3 minutes** for all services to start up.

---

### 2. Check Service Status

```powershell
docker-compose ps
```

You should see 8 services running:
- config-server
- eureka-server  
- mysql
- apigateway
- book-service
- user-service
- order-service
- payment-service

---

### 3. Open These URLs (Copy and Paste in Browser)

#### 🔍 Service Registry:
```
http://localhost:8761
```
**See:** All microservices registered in Eureka

#### 📚 Swagger Documentation:

**Book Service:**
```
http://localhost:8081/swagger-ui.html
```

**User Service:**
```
http://localhost:8082/swagger-ui.html
```

**Order Service:**
```
http://localhost:8083/swagger-ui.html
```

**Payment Service:**
```
http://localhost:8084/swagger-ui.html
```

#### 🌐 API Gateway Endpoints:

**Get Books:**
```
http://localhost:8765/books
```

**Get Users:**
```
http://localhost:8765/users
```

**Get Orders:**
```
http://localhost:8765/orders
```

**Get Payments:**
```
http://localhost:8765/payments
```

---

### 4. Test APIs in PowerShell

```powershell
# Get all books
Invoke-RestMethod -Uri http://localhost:8765/books

# Get all users  
Invoke-RestMethod -Uri http://localhost:8765/users

# Get all orders
Invoke-RestMethod -Uri http://localhost:8765/orders

# Get all payments
Invoke-RestMethod -Uri http://localhost:8765/payments
```

---

### 5. View Logs (if needed)

```powershell
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f book-service
```

---

## ✅ Expected Results

### Eureka Dashboard shows:
- BOOK-SERVICE: UP (1 instance)
- USER-SERVICE: UP (1 instance)  
- ORDER-SERVICE: UP (1 instance)
- PAYMENT-SERVICE: UP (1 instance)
- API-GATEWAY: UP (1 instance)

### Swagger UI shows:
- Complete API documentation
- All endpoints listed
- Try it out functionality
- Request/Response schemas

### API Returns:
- **Books**: 15 books in JSON format
- **Users**: 10 users in JSON format
- **Orders**: 15 orders in JSON format  
- **Payments**: 15 payments in JSON format

---

## 🔧 Troubleshooting

### Services not starting?
```powershell
# Check logs
docker-compose logs

# Restart services
docker-compose restart

# Rebuild services
docker-compose up -d --build
```

### Port conflicts?
```powershell
# Check what's using the port
netstat -ano | findstr :8081
```

### Database issues?
```powershell
# Check MySQL logs
docker-compose logs mysql

# Restart MySQL
docker-compose restart mysql
```

---

## 🛑 Stop Services

```powershell
docker-compose down
```

---

**That's it! Services are running and ready to show results!** 🎉

