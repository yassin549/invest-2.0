@echo off
echo ========================================
echo  Deploying Railway Fix
echo ========================================
echo.

echo [1/4] Checking git status...
git status

echo.
echo [2/4] Adding all changes...
git add .

echo.
echo [3/4] Committing changes...
git commit -m "Fix: Railway deployment - Add storage directories and startup script with error handling"

echo.
echo [4/4] Pushing to GitHub...
git push origin main

echo.
echo ========================================
echo  Deployment Fix Pushed Successfully!
echo ========================================
echo.
echo Next steps:
echo 1. Go to Railway dashboard
echo 2. Wait for auto-deployment (2-3 minutes)
echo 3. Check Deploy Logs tab for startup script output
echo 4. Look for: "Starting HYIP Lab Application"
echo.
echo If you see errors in the logs, they will now be clearly visible!
echo.
pause
