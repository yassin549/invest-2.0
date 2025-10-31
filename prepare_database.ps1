# HYIP Lab Database Preparation Script
# This script prepares the full database for import to Railway

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "HYIP Lab Database Preparation" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Copy database file
Write-Host "Step 1: Copying database file..." -ForegroundColor Yellow
$sourcePath = "c:\Users\khoua\OneDrive\Desktop\hyip\install\database.sql"
$destPath = "c:\Users\khoua\OneDrive\Desktop\hyiplab_v5.4.1\database_full.sql"

if (Test-Path $sourcePath) {
    Copy-Item -Path $sourcePath -Destination $destPath -Force
    Write-Host "✓ Database file copied successfully!" -ForegroundColor Green
    Write-Host "  Location: $destPath" -ForegroundColor Gray
    
    # Get file size
    $fileSize = (Get-Item $destPath).Length
    $fileSizeKB = [math]::Round($fileSize / 1KB, 2)
    Write-Host "  Size: $fileSizeKB KB" -ForegroundColor Gray
} else {
    Write-Host "✗ Source file not found: $sourcePath" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Step 2: Show file info
Write-Host "Step 2: Database file information..." -ForegroundColor Yellow
$content = Get-Content $destPath -TotalCount 50
$tableCount = ($content | Select-String "CREATE TABLE").Count
Write-Host "✓ Database file contains approximately $tableCount tables" -ForegroundColor Green

Write-Host ""

# Step 3: Display import instructions
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Next Steps - Choose ONE method:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "METHOD 1: Via Railway Dashboard (EASIEST)" -ForegroundColor Yellow
Write-Host "  1. Go to https://railway.app" -ForegroundColor Gray
Write-Host "  2. Open your project → MySQL service" -ForegroundColor Gray
Write-Host "  3. Click 'Query' tab" -ForegroundColor Gray
Write-Host "  4. Open: $destPath" -ForegroundColor Gray
Write-Host "  5. Copy ALL contents and paste into Query tab" -ForegroundColor Gray
Write-Host "  6. Click 'Run'" -ForegroundColor Gray
Write-Host ""

Write-Host "METHOD 2: Via MySQL Command Line" -ForegroundColor Yellow
Write-Host "  Get Railway MySQL credentials from dashboard, then run:" -ForegroundColor Gray
Write-Host "  mysql -h [HOST] -P [PORT] -u [USER] -p[PASSWORD] railway < database_full.sql" -ForegroundColor Cyan
Write-Host ""

Write-Host "METHOD 3: Via Railway CLI" -ForegroundColor Yellow
Write-Host "  1. Install Railway CLI: npm install -g @railway/cli" -ForegroundColor Gray
Write-Host "  2. Login: railway login" -ForegroundColor Gray
Write-Host "  3. Link project: railway link" -ForegroundColor Gray
Write-Host "  4. Import: railway run mysql -u root -p railway < database_full.sql" -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "After Import:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "1. Visit your Railway app URL" -ForegroundColor Gray
Write-Host "2. Homepage should load with investment plans" -ForegroundColor Gray
Write-Host "3. Login to admin panel: /admin" -ForegroundColor Gray
Write-Host "   Username: admin" -ForegroundColor Gray
Write-Host "   Password: (needs reset - see IMPORT_FULL_DATABASE.md)" -ForegroundColor Gray
Write-Host ""

Write-Host "✓ Preparation complete!" -ForegroundColor Green
Write-Host "  Read IMPORT_FULL_DATABASE.md for detailed instructions" -ForegroundColor Gray
Write-Host ""

# Step 4: Open the guide
$openGuide = Read-Host "Open import guide? (Y/N)"
if ($openGuide -eq "Y" -or $openGuide -eq "y") {
    Start-Process "c:\Users\khoua\OneDrive\Desktop\hyiplab_v5.4.1\IMPORT_FULL_DATABASE.md"
}
