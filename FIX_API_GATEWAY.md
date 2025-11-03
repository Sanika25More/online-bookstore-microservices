# Fix API Gateway - Step by Step Guide

## Issues Found and Fixed:

### ✅ Fixed Issues:
1. **Dockerfile** - Removed duplicate EXPOSE statements
2. **Eureka URL** - Changed from `localhost` to `eureka-server` for Docker environment

### 🔧 Additional Steps Needed:

#### Step 1: Rebuild API Gateway JAR (since we changed application.properties)
```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices\apigateway"
mvn clean package -DskipTests
```

#### Step 2: Stop All Services
```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices"
docker-compose down
```

#### Step 3: Check for Port Conflicts
```powershell
# Check what's using ports 8889, 8761, 8765
netstat -ano | findstr ":8889"
netstat -ano | findstr ":8761"
netstat -ano | findstr ":8765"
```

If ports are in use, kill the processes:
```powershell
# Replace <PID> with the process ID from netstat
taskkill /PID <PID> /F
```

#### Step 4: Rebuild API Gateway Docker Image
```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices"
docker-compose build apigateway
```

#### Step 5: Start All Services
```powershell
docker-compose up -d
```

#### Step 6: Check API Gateway Logs
```powershell
docker-compose logs -f apigateway
```

You should see:
```
Started ApiGatewayApplication
```

---

## Alternative: Run API Gateway Standalone (Without Docker)

If Docker is causing issues, you can run API Gateway directly:

### Option 1: Run from IDE
1. Open project in IDE
2. Run `ApiGatewayApplication.java`
3. It will start on port 8765

### Option 2: Run from Command Line
```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices\apigateway"
mvn spring-boot:run
```

**Note:** Update `application.properties` to use `localhost` instead of `eureka-server` when running standalone.

---

## Verify API Gateway is Working

### Check Container Status:
```powershell
docker ps | findstr apigateway
```

Should show: `Up X minutes` status

### Test API Gateway:
```powershell
# Health check
Invoke-WebRequest -Uri http://localhost:8765/actuator/health

# Test routing to books
Invoke-WebRequest -Uri http://localhost:8765/books
```

### Check Logs:
```powershell
docker-compose logs apigateway
```

Look for:
- ✅ "Started ApiGatewayApplication"
- ✅ "Routes configured"
- ❌ Any ERROR messages

---

## Common Issues and Solutions

### Issue 1: Port Already in Use
**Solution:**
```powershell
# Find process
netstat -ano | findstr :8765
# Kill process
taskkill /PID <PID> /F
```

### Issue 2: Eureka Connection Failed
**Solution:**
- Make sure Eureka Server is running first
- Check `application.properties` uses `eureka-server` (not `localhost`) in Docker

### Issue 3: JAR File Not Found
**Solution:**
```powershell
cd apigateway
mvn clean package
```

### Issue 4: Container Exits Immediately
**Solution:**
- Check logs: `docker-compose logs apigateway`
- Rebuild: `docker-compose build --no-cache apigateway`

---

## Quick Fix Commands

```powershell
# 1. Stop everything
docker-compose down

# 2. Rebuild API Gateway
cd apigateway
mvn clean package -DskipTests
cd ..

# 3. Rebuild Docker image
docker-compose build apigateway

# 4. Start all services
docker-compose up -d

# 5. Check status
docker-compose ps
docker-compose logs apigateway
```

---

**After following these steps, API Gateway should be running on http://localhost:8765** ✅

