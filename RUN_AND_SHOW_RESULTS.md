# Run and Show Results - Quick Guide

## 🚀 Quick Start Commands

### Step 1: Start All Services
```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices"
docker-compose up -d
```

### Step 2: Check Service Status
```powershell
docker-compose ps
```

### Step 3: View Service Logs
```powershell
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f book-service
docker-compose logs -f user-service
docker-compose logs -f apigateway
```

---

## 🌐 Access URLs (Open in Browser)

### Infrastructure Services:
1. **Eureka Dashboard**: http://localhost:8761
   - View all registered microservices
   - See service health status

2. **Config Server**: http://localhost:8889

### API Gateway:
3. **API Gateway**: http://localhost:8765

### Swagger API Documentation:
4. **Book Service Swagger**: http://localhost:8081/swagger-ui.html
5. **User Service Swagger**: http://localhost:8082/swagger-ui.html
6. **Order Service Swagger**: http://localhost:8083/swagger-ui.html
7. **Payment Service Swagger**: http://localhost:8084/swagger-ui.html

### API Endpoints (Through Gateway):
8. **Get All Books**: http://localhost:8765/books
9. **Get All Users**: http://localhost:8765/users
10. **Get All Orders**: http://localhost:8765/orders
11. **Get All Payments**: http://localhost:8765/payments

---

## 📊 What You'll See

### 1. Eureka Dashboard (http://localhost:8761)

You'll see:
- **Application** | **AMIs** | **Availability Zones** | **Status**
- BOOK-SERVICE | n/a (1) | (1) | UP
- USER-SERVICE | n/a (1) | (1) | UP
- ORDER-SERVICE | n/a (1) | (1) | UP
- PAYMENT-SERVICE | n/a (1) | (1) | UP
- API-GATEWAY | n/a (1) | (1) | UP

### 2. Swagger UI Pages

Each Swagger page shows:
- API endpoints list
- Request/Response schemas
- Try it out functionality
- Example requests

### 3. API Responses

**Books API** returns:
```json
[
  {
    "bookId": 1,
    "title": "The Great Gatsby",
    "author": "F. Scott Fitzgerald",
    "genre": "Fiction",
    "price": 12.99,
    "stock": 50
  },
  ...
]
```

**Users API** returns:
```json
[
  {
    "userId": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "role": "buyer",
    "address": "123 Main St, New York, NY 10001"
  },
  ...
]
```

---

## 🧪 Test Commands (PowerShell)

### Test APIs via Gateway:

```powershell
# Get all books
Invoke-WebRequest -Uri http://localhost:8765/books -Method GET | Select-Object -ExpandProperty Content

# Get all users
Invoke-WebRequest -Uri http://localhost:8765/users -Method GET | Select-Object -ExpandProperty Content

# Get all orders
Invoke-WebRequest -Uri http://localhost:8765/orders -Method GET | Select-Object -ExpandProperty Content

# Get all payments
Invoke-WebRequest -Uri http://localhost:8765/payments -Method GET | Select-Object -ExpandProperty Content
```

### Test Health Endpoints:

```powershell
# Book Service Health
Invoke-WebRequest -Uri http://localhost:8081/actuator/health -Method GET

# User Service Health
Invoke-WebRequest -Uri http://localhost:8082/actuator/health -Method GET

# Order Service Health
Invoke-WebRequest -Uri http://localhost:8083/actuator/health -Method GET

# Payment Service Health
Invoke-WebRequest -Uri http://localhost:8084/actuator/health -Method GET
```

---

## 📋 Service Status Check

### View Running Containers:
```powershell
docker ps
```

### Expected Output:
```
CONTAINER ID   IMAGE                    STATUS         PORTS
xxx            apigateway               Up 2 minutes   0.0.0.0:8765->8765/tcp
xxx            book-service             Up 2 minutes   0.0.0.0:8081->8081/tcp
xxx            user-service             Up 2 minutes   0.0.0.0:8082->8082/tcp
xxx            order-service            Up 2 minutes   0.0.0.0:8083->8083/tcp
xxx            payment-service          Up 2 minutes   0.0.0.0:8084->8084/tcp
xxx            eureka-server            Up 3 minutes   0.0.0.0:8761->8761/tcp
xxx            config-server            Up 3 minutes   0.0.0.0:8889->8889/tcp
xxx            mysql                    Up 3 minutes   0.0.0.0:3306->3306/tcp
```

---

## 🗄️ Database Verification

### Connect to MySQL:
```powershell
docker exec -it mysql mysql -u root -proot
```

### Check Databases:
```sql
SHOW DATABASES;
USE book_service_db;
SELECT COUNT(*) FROM books;
USE user_service_db;
SELECT COUNT(*) FROM users;
USE order_service_db;
SELECT COUNT(*) FROM orders;
USE payment_service_db;
SELECT COUNT(*) FROM payments;
```

### Expected Results:
- books: 15 records
- users: 10 records
- orders: 15 records
- payments: 15 records

---

## 🎯 Verification Checklist

- [ ] All containers running (`docker ps` shows 8 containers)
- [ ] Eureka Dashboard accessible and shows all services
- [ ] Swagger UI pages load for all 4 services
- [ ] API Gateway returns data (http://localhost:8765/books)
- [ ] Direct service access works (http://localhost:8081/books)
- [ ] Database has sample data (15 books, 10 users, 15 orders, 15 payments)

---

## 🔧 Troubleshooting

### Services Not Starting:
```powershell
# View logs
docker-compose logs

# Restart specific service
docker-compose restart book-service

# Rebuild and restart
docker-compose up -d --build
```

### Port Already in Use:
```powershell
# Find process using port
netstat -ano | findstr :8081

# Kill process (replace PID)
taskkill /PID <PID> /F
```

### Database Connection Issues:
```powershell
# Check MySQL logs
docker-compose logs mysql

# Restart MySQL
docker-compose restart mysql
```

---

## 📸 Screenshots to Take

1. **Eureka Dashboard** - Showing all registered services
2. **Swagger UI** - For each service (book, user, order, payment)
3. **API Response** - JSON data from /books endpoint
4. **Docker Containers** - Running services list
5. **Database Query Results** - Sample data counts

---

## 🎉 Success Indicators

✅ **All services UP in Eureka**  
✅ **Swagger UI accessible for all services**  
✅ **API Gateway routing requests correctly**  
✅ **Database contains sample data**  
✅ **No error logs in docker-compose logs**

---

## 🛑 Stop Services

```powershell
docker-compose down
```

To stop and remove containers:
```powershell
docker-compose down -v
```

---

**All services are ready to run and show results!** 🚀

