# Fix API Gateway - Not Running Issue

## Current Status
- ❌ API Gateway is NOT running
- ❌ No ports listening (9090 or 8765)
- ❌ Docker container is in "Created" status (not started)

## Step-by-Step Fix

### Step 1: Check Prerequisites

**Make sure these are running first:**
1. ✅ Eureka Server on port 8761
2. ✅ Config Server on port 8889 (or make it optional)

### Step 2: Option A - Run Standalone (Easiest)

```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices\apigateway"
mvn spring-boot:run
```

**Wait for:**
```
Started ApiGatewayApplication
```

### Step 2: Option B - Run JAR File

```powershell
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices\apigateway"
java -jar target/apigateway-1.0.0.jar
```

### Step 3: Verify It's Running

```powershell
# Check port
netstat -ano | findstr ":8765"

# Test health
Invoke-WebRequest -Uri http://localhost:8765/actuator/health
```

## Common Issues

### Issue 1: Port Already in Use
**Solution:** Kill the process using the port
```powershell
netstat -ano | findstr ":8765"
taskkill /PID <PID> /F
```

### Issue 2: Eureka Not Available
**Solution:** API Gateway needs Eureka running first
- Start Eureka Server: http://localhost:8761

### Issue 3: Config Server Not Available
**Solution:** Make Config Server optional in bootstrap.properties
- Already configured as optional ✅

### Issue 4: JAR File Missing
**Solution:** Build it first
```powershell
cd apigateway
mvn clean package -DskipTests
```

## Quick Fix Commands

```powershell
# 1. Navigate to API Gateway
cd "D:\MCA sem3\JAVA\project\online-bookstore-microservices\apigateway"

# 2. Build if needed
mvn clean package -DskipTests

# 3. Run
mvn spring-boot:run
```

## What to Look For

### Successful Startup:
```
Started ApiGatewayApplication in X seconds
Netty started on port 8765
Registered with Eureka
```

### Error Messages:
- Connection refused → Eureka not running
- Port already in use → Kill existing process
- JAR not found → Build first

## After It Starts

### Test URLs:
- Health: http://localhost:8765/actuator/health
- Books: http://localhost:8765/books
- Users: http://localhost:8765/users

---

**Follow these steps to get API Gateway running!**

