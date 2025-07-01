# PhishGuardAI Setup Script for Windows
# This script helps set up the development environment

Write-Host "🎣 PhishGuardAI Setup Script" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

# Get the script directory and navigate to project root
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
Set-Location $ProjectRoot

Write-Host "Working in project directory: $ProjectRoot" -ForegroundColor Cyan

# Check if Docker is installed
Write-Host "Checking Docker installation..." -ForegroundColor Yellow
$dockerCheck = & { docker --version 2>&1 }
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Docker found: $dockerCheck" -ForegroundColor Green
} else {
    Write-Host "❌ Docker not found. Please install Docker Desktop first." -ForegroundColor Red
    exit 1
}

# Check if .NET is installed
Write-Host "Checking .NET installation..." -ForegroundColor Yellow
$dotnetCheck = & { dotnet --version 2>&1 }
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ .NET found: $dotnetCheck" -ForegroundColor Green
} else {
    Write-Host "❌ .NET not found. Please install .NET 8 SDK first." -ForegroundColor Red
    exit 1
}

# Check if Node.js is installed
Write-Host "Checking Node.js installation..." -ForegroundColor Yellow
$nodeCheck = & { node --version 2>&1 }
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Node.js found: $nodeCheck" -ForegroundColor Green
} else {
    Write-Host "❌ Node.js not found. Please install Node.js 18+ first." -ForegroundColor Red
    exit 1
}

# Create environment file if it doesn't exist
Write-Host "Setting up environment configuration..." -ForegroundColor Yellow
if (!(Test-Path ".env")) {
    if (Test-Path "env.template") {
        Copy-Item "env.template" ".env"
        Write-Host "✅ Created .env file from template" -ForegroundColor Green
        Write-Host "⚠️  Please edit .env file with your API keys" -ForegroundColor Yellow
    } else {
        Write-Host "❌ env.template file not found" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✅ .env file already exists" -ForegroundColor Green
}

# Restore backend dependencies
Write-Host "Restoring backend dependencies..." -ForegroundColor Yellow
if (Test-Path "PhishGuardAI.sln") {
    $restoreResult = & { dotnet restore PhishGuardAI.sln 2>&1 }
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Backend dependencies restored" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to restore backend dependencies: $restoreResult" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "❌ PhishGuardAI.sln not found" -ForegroundColor Red
    exit 1
}

# Install frontend dependencies
Write-Host "Installing frontend dependencies..." -ForegroundColor Yellow
if (Test-Path "frontend/phishguardai-dashboard") {
    Push-Location "frontend/phishguardai-dashboard"
    $npmResult = & { npm install 2>&1 }
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Frontend dependencies installed" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to install frontend dependencies: $npmResult" -ForegroundColor Red
        Pop-Location
        exit 1
    }
    Pop-Location
} else {
    Write-Host "❌ Frontend directory not found" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🎉 Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Edit .env file with your API keys (if not already done)" -ForegroundColor White
Write-Host "2. Start the PostgreSQL database:" -ForegroundColor White
Write-Host "   docker run --name phishguardai-db -e POSTGRES_DB=phishguardai -e POSTGRES_USER=phishuser -e POSTGRES_PASSWORD=phishpass123 -p 5432:5432 -d postgres:15" -ForegroundColor Gray
Write-Host "3. Start the backend API:" -ForegroundColor White
Write-Host "   cd backend; dotnet run --project PhishGuardAI.Api" -ForegroundColor Gray
Write-Host "4. Start the frontend (in a new terminal):" -ForegroundColor White
Write-Host "   cd frontend/phishguardai-dashboard; npm run dev" -ForegroundColor Gray
Write-Host ""
Write-Host "URLs:" -ForegroundColor Cyan
Write-Host "- Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "- Backend API: http://localhost:5000" -ForegroundColor White
Write-Host "- Database: localhost:5432" -ForegroundColor White
Write-Host ""
Write-Host "For testing:" -ForegroundColor Cyan
Write-Host "- Run tests: cd backend; dotnet test" -ForegroundColor White 