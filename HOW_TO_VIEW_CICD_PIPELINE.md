# How to View and Use CI/CD Pipeline

This guide explains how to view, trigger, and monitor the CI/CD pipeline for the Online Bookstore Microservices project.

## 📋 Table of Contents

1. [Understanding CI/CD Pipeline](#understanding-cicd-pipeline)
2. [Prerequisites](#prerequisites)
3. [Triggering the Pipeline](#triggering-the-pipeline)
4. [Viewing Pipeline Results](#viewing-pipeline-results)
5. [Understanding Pipeline Stages](#understanding-pipeline-stages)
6. [Troubleshooting Pipeline Issues](#troubleshooting-pipeline-issues)
7. [Pipeline Status Indicators](#pipeline-status-indicators)

---

## Understanding CI/CD Pipeline

### Important Note:
⚠️ **CI/CD pipelines run on GitHub Actions (cloud), NOT locally when you run services!**

- Running services locally (`docker-compose up`) = Testing your services
- CI/CD Pipeline = Automated testing, building, and deployment on GitHub's servers

The pipeline automatically runs when you push code to GitHub. It:
1. ✅ Builds all microservices
2. ✅ Runs tests
3. ✅ Creates Docker images
4. ✅ Scans for security vulnerabilities
5. ✅ Deploys to cloud (if configured)

---

## Prerequisites

1. ✅ Code pushed to GitHub repository
2. ✅ GitHub repository exists: `https://github.com/Sanika25More/online-bookstore-microservices`
3. ✅ GitHub Actions enabled (enabled by default)
4. ✅ Workflow files present in `.github/workflows/`

---

## Triggering the Pipeline

### Method 1: Push to Branch (Automatic)

```bash
# Make any change and push
git add .
git commit -m "Update code"
git push origin main
```

The pipeline will automatically start running.

### Method 2: Create Pull Request

1. Create a new branch:
   ```bash
   git checkout -b feature/new-feature
   git add .
   git commit -m "Add new feature"
   git push origin feature/new-feature
   ```

2. Go to GitHub and create a Pull Request
3. Pipeline will run automatically for the PR

### Method 3: Manual Trigger (Workflow Dispatch)

1. Go to GitHub repository
2. Click on **"Actions"** tab
3. Select the workflow (e.g., "CI/CD Pipeline")
4. Click **"Run workflow"** button
5. Select branch and click **"Run workflow"**

### Method 4: Push Version Tag

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

This triggers deployment workflow.

---

## Viewing Pipeline Results

### Step 1: Go to GitHub Repository

1. Open your browser
2. Navigate to: `https://github.com/Sanika25More/online-bookstore-microservices`
3. Click on the **"Actions"** tab at the top

### Step 2: View Workflow Runs

You'll see a list of all workflow runs:
- ✅ Green checkmark = Success
- ❌ Red X = Failed
- 🟡 Yellow circle = In Progress
- ⚪ Gray circle = Pending

### Step 3: Click on a Workflow Run

Click on any workflow run to see detailed information.

---

## Understanding Pipeline Stages

### What You'll See in Each Run:

#### 1. **Build and Test Job** 🔨

**What it does:**
- Builds all 7 microservices (book, user, order, payment, api-gateway, config-server, eureka-server)
- Runs unit tests for each service
- Compiles Java code
- Creates JAR files

**How to view:**
1. Click on the workflow run
2. Expand "Build and Test" job
3. Click on a specific service (e.g., "book-service")
4. View logs showing:
   - Maven build output
   - Test results
   - Compilation status

**What to look for:**
```
✅ Tests run: 5, Failures: 0, Errors: 0
✅ BUILD SUCCESS
```

#### 2. **Build Docker Images Job** 🐳

**What it does:**
- Builds Docker images for all services
- Pushes images to GitHub Container Registry
- Tags images with commit SHA, branch name, and version

**How to view:**
1. Click on "Build Docker Images" job
2. See logs showing:
   - Docker build process
   - Image tagging
   - Push to registry

**What to look for:**
```
✅ Successfully built abc123def456
✅ Successfully pushed to ghcr.io/...
```

#### 3. **Security Scan Job** 🔒

**What it does:**
- Scans code for security vulnerabilities
- Uses Trivy scanner
- Uploads results to GitHub Security tab

**How to view:**
1. Click on "Security Scan" job
2. View vulnerability report
3. Check "Security" tab in repository for detailed results

**What to look for:**
```
✅ No critical vulnerabilities found
⚠️ Warnings: X (review if needed)
```

#### 4. **Deploy Job** 🚀

**What it does:**
- Deploys services to cloud (Kubernetes/AWS/Azure/GCP)
- Runs health checks
- Verifies deployment

**How to view:**
1. Click on "Deploy" job
2. View deployment logs
3. Check service status

**Note:** This job only runs on pushes to `main` branch.

#### 5. **Notify Job** 📧

**What it does:**
- Sends notifications about pipeline status

**Status:**
- ✅ Success notification
- ❌ Failure notification

---

## Detailed View of Pipeline Results

### Viewing Job Logs

1. **Click on a workflow run**
2. **Click on a job** (e.g., "Build and Test")
3. **Expand steps** to see detailed output:

```
✓ Checkout code (completed)
✓ Set up JDK 17 (completed)
✓ Build with Maven (completed)
✓ Run tests (completed)
```

### Viewing Service-Specific Builds

In "Build and Test" job, you'll see matrix builds:
- `config-server` ✅
- `eureka-server` ✅
- `apigateway` ✅
- `book-service` ✅
- `user-service` ✅
- `order-service` ✅
- `payment-service` ✅

Click on any service to see its specific build logs.

---

## Pipeline Status Indicators

### Status Colors:

| Color | Status | Meaning |
|-------|--------|---------|
| ✅ Green | Success | All checks passed |
| ❌ Red | Failed | One or more checks failed |
| 🟡 Yellow | In Progress | Currently running |
| ⚪ Gray | Queued | Waiting to start |
| 🟠 Orange | Cancelled | Manually cancelled |

### Status Badge

You can add a status badge to your README:
```markdown
![CI/CD Pipeline](https://github.com/Sanika25More/online-bookstore-microservices/workflows/CI/CD%20Pipeline/badge.svg)
```

---

## Viewing Pipeline History

### See All Runs:

1. Go to **Actions** tab
2. See list of all runs with:
   - Workflow name
   - Branch/PR
   - Status
   - Duration
   - Commit message

### Filter Runs:

- Filter by workflow
- Filter by status (success/failure)
- Filter by branch
- Filter by actor (who triggered it)

---

## Common Pipeline Scenarios

### Scenario 1: First Push to Repository

**Steps:**
1. Push code to GitHub
2. Go to Actions tab
3. See "CI/CD Pipeline" running
4. Wait for completion (5-10 minutes)

**Expected Result:**
- ✅ All services build successfully
- ✅ Docker images created
- ✅ Security scan completes

### Scenario 2: Failed Build

**What happens:**
- Red X appears next to workflow run
- Job shows "Failed" status

**How to fix:**
1. Click on failed job
2. Expand failed step
3. Read error message
4. Fix issue locally
5. Push again

### Scenario 3: Pull Request

**Steps:**
1. Create PR
2. Pipeline runs automatically
3. See status checks on PR page
4. All checks must pass before merge

---

## Real-Time Monitoring

### Watch Pipeline Progress:

1. **Start a workflow** (push code or manual trigger)
2. **Go to Actions tab**
3. **Click on the running workflow**
4. **Watch in real-time:**
   - Jobs starting
   - Logs appearing
   - Status changes

### Refresh Page:

- GitHub updates automatically
- Or refresh manually (F5)

---

## Understanding Logs

### Build Logs Show:

```
[INFO] Building book-service 0.0.1-SNAPSHOT
[INFO] --- maven-compiler-plugin:3.8.1:compile
[INFO] Compiling 6 source files
[INFO] --- maven-surefire-plugin:2.22.2:test
[INFO] Tests run: 5, Failures: 0, Errors: 0
[INFO] BUILD SUCCESS
```

### Error Logs Show:

```
[ERROR] Failed to execute goal...
[ERROR] Compilation failure
```

**Action:** Fix the error and push again.

---

## Checking Pipeline Configuration

### View Workflow Files:

1. Go to repository
2. Navigate to `.github/workflows/`
3. View:
   - `ci-cd.yml` - Main pipeline
   - `docker-compose-deploy.yml` - Docker deployment

### Modify Pipeline:

1. Edit workflow files locally
2. Test changes
3. Commit and push
4. See updated pipeline run

---

## Troubleshooting Pipeline Issues

### Issue: Pipeline Not Running

**Solutions:**
1. Check GitHub Actions is enabled:
   - Settings → Actions → General
   - Ensure "Allow all actions" is selected

2. Verify workflow files exist:
   - `.github/workflows/ci-cd.yml`

3. Check branch name:
   - Pipeline triggers on `main` or `develop`

### Issue: Build Failures

**Common causes:**
- Compilation errors
- Missing dependencies
- Test failures
- Docker build errors

**Solutions:**
1. Check job logs for error messages
2. Fix issues locally
3. Run tests locally: `mvn test`
4. Push fixed code

### Issue: Docker Build Fails

**Solutions:**
1. Check Dockerfile exists
2. Verify Dockerfile syntax
3. Test Docker build locally:
   ```bash
   docker build -t test-image ./book-service
   ```

### Issue: Security Scan Warnings

**Solutions:**
1. Review vulnerabilities in Security tab
2. Update dependencies:
   ```bash
   mvn versions:use-latest-versions
   ```
3. Push updated dependencies

---

## Pipeline Notifications

### Email Notifications:

GitHub sends emails when:
- Pipeline completes
- Pipeline fails
- You're watching the repository

### Configure Notifications:

1. Repository → Settings → Notifications
2. Enable workflow notifications

---

## Viewing Published Docker Images

### GitHub Container Registry:

After pipeline runs, images are published to:
- `ghcr.io/Sanika25More/online-bookstore-microservices/book-service:latest`
- `ghcr.io/Sanika25More/online-bookstore-microservices/user-service:latest`
- etc.

### View Images:

1. Go to repository
2. Click on "Packages" (right sidebar)
3. See all published Docker images

---

## Best Practices

### ✅ Do:
- Check pipeline status before merging PRs
- Review failed builds immediately
- Keep workflow files updated
- Monitor security scan results

### ❌ Don't:
- Ignore failed pipelines
- Skip security warnings
- Disable pipeline checks
- Merge PRs with failing checks

---

## Quick Reference

### URLs:

- **Repository:** https://github.com/Sanika25More/online-bookstore-microservices
- **Actions Tab:** https://github.com/Sanika25More/online-bookstore-microservices/actions
- **Workflow Runs:** https://github.com/Sanika25More/online-bookstore-microservices/actions/workflows/ci-cd.yml

### Commands:

```bash
# Push code to trigger pipeline
git add .
git commit -m "Trigger CI/CD"
git push origin main

# Check pipeline status (via GitHub web)
# Or use GitHub CLI:
gh workflow list
gh run list
gh run watch
```

---

## Summary

**To view CI/CD pipeline:**

1. ✅ Push code to GitHub
2. ✅ Go to repository → Actions tab
3. ✅ Click on workflow run
4. ✅ View detailed logs and results

**Pipeline runs automatically on:**
- Push to `main` or `develop` branch
- Pull requests
- Manual trigger
- Version tags

**All services are checked in the pipeline!** 🚀

---

## Need Help?

If pipeline fails:
1. Click on failed job
2. Read error messages
3. Check logs
4. Fix issues
5. Push again

The pipeline ensures all your microservices are properly built, tested, and ready for deployment! ✅

