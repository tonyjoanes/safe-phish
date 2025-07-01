# Getting Started with PhishGuardAI

Welcome to PhishGuardAI - an AI-powered phishing simulation tool designed to help small businesses test and train employees against phishing attacks.

## 🚀 Quick Start

### Prerequisites

Before you begin, make sure you have the following installed:

- **Docker Desktop** (for containerized development)
- **.NET 8 SDK** (for backend development)
- **Node.js 18+** (for frontend development)
- **Git** (for version control)

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/PhishGuardAI.git
cd PhishGuardAI
```

### 2. Environment Setup

1. Copy the environment template:
   ```bash
   cp env.template .env
   ```

2. Edit `.env` file with your API keys:
   ```bash
   # Required API Keys
   OPENAI_API_KEY=your_openai_key_here
   MAILGUN_API_KEY=your_mailgun_key_here
   MAILGUN_DOMAIN=your_mailgun_domain_here
   
   # Firebase Configuration
   FIREBASE_API_KEY=your_firebase_key_here
   FIREBASE_PROJECT_ID=your_project_id_here
   # ... other Firebase settings
   ```

### 3. Run Setup Script

**Windows (PowerShell):**
```powershell
.\scripts\setup.ps1
```

**Manual Setup:**
```bash
# Backend dependencies
cd backend
dotnet restore
cd ..

# Frontend dependencies
cd frontend/phishguardai-dashboard
npm install
cd ../..
```

### 4. Start the Application

**Using Docker (Recommended):**
```bash
docker-compose up --build
```

**Manual Development:**
```bash
# Terminal 1 - Database
docker run -d --name phishguardai-db -p 5432:5432 -e POSTGRES_DB=phishguardai -e POSTGRES_USER=phishuser -e POSTGRES_PASSWORD=phishpass123 postgres:15

# Terminal 2 - Backend API
cd backend
dotnet run --project PhishGuardAI.Api

# Terminal 3 - Frontend
cd frontend/phishguardai-dashboard
npm run dev
```

### 5. Access the Application

- **Frontend Dashboard**: http://localhost:3000
- **Backend API**: http://localhost:5000
- **API Documentation**: http://localhost:5000/swagger (when running)

## 🏗️ Project Structure

```
PhishGuardAI/
├── backend/                    # .NET Core API
│   ├── PhishGuardAI.Api/      # Main API project
│   └── PhishGuardAI.Tests/    # Unit tests
├── frontend/                   # React TypeScript frontend
│   └── phishguardai-dashboard/
├── database/                   # Database scripts and migrations
│   └── init/                  # Initialization scripts
├── docs/                      # Documentation
├── scripts/                   # Setup and utility scripts
├── .github/workflows/         # CI/CD pipelines
├── docker-compose.yml         # Docker orchestration
└── PhishGuardAI.sln          # Solution file
```

## 🛠️ Development Workflow

### Backend Development

1. **Add new features**:
   ```bash
   cd backend/PhishGuardAI.Api
   # Create your controllers, services, models
   ```

2. **Run tests**:
   ```bash
   cd backend
   dotnet test
   ```

3. **Database migrations** (when using EF Core):
   ```bash
   cd backend/PhishGuardAI.Api
   dotnet ef migrations add YourMigrationName
   dotnet ef database update
   ```

### Frontend Development

1. **Start development server**:
   ```bash
   cd frontend/phishguardai-dashboard
   npm run dev
   ```

2. **Build for production**:
   ```bash
   npm run build
   ```

3. **Run linting**:
   ```bash
   npm run lint
   ```

## 🧪 Testing

### Backend Tests
```bash
cd backend
dotnet test --logger trx --collect:"XPlat Code Coverage"
```

### Frontend Tests
```bash
cd frontend/phishguardai-dashboard
npm test
```

## 📊 Key Features to Implement

Based on the README requirements, focus on these core features:

### Phase 1 - MVP (Weeks 1-4)
- [ ] User authentication (Firebase)
- [ ] Campaign management (CRUD operations)
- [ ] Email template system
- [ ] Basic email sending (Mailgun integration)
- [ ] Simple dashboard with metrics

### Phase 2 - AI Integration (Weeks 5-6)
- [ ] OpenAI API integration for email generation
- [ ] Template customization
- [ ] Advanced tracking

### Phase 3 - Analytics & Reports (Weeks 7-8)
- [ ] Advanced dashboard with Chart.js
- [ ] PDF report generation (jsPDF)
- [ ] Training recommendations

## 🔧 Configuration

### Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `OPENAI_API_KEY` | OpenAI API key for email generation | `sk-...` |
| `MAILGUN_API_KEY` | Mailgun API key for email sending | `key-...` |
| `MAILGUN_DOMAIN` | Your Mailgun domain | `mg.yourdomain.com` |
| `FIREBASE_API_KEY` | Firebase API key | `AIza...` |
| `FIREBASE_PROJECT_ID` | Firebase project ID | `your-project-id` |

### Optional Configuration

- `LOG_LEVEL`: Set to `Debug` for detailed logging
- `ASPNETCORE_ENVIRONMENT`: Set to `Development` for dev mode
- `JWT_SECRET`: Custom JWT secret (auto-generated if not provided)

## 🚨 Troubleshooting

### Common Issues

1. **Docker port conflicts**:
   ```bash
   # Check what's running on ports
   netstat -an | findstr :5000
   netstat -an | findstr :3000
   netstat -an | findstr :5432
   ```

2. **Database connection issues**:
   - Ensure PostgreSQL container is running
   - Check connection string in `appsettings.json`
   - Verify database credentials

3. **API key errors**:
   - Double-check all API keys in `.env` file
   - Ensure no trailing spaces in environment variables
   - Restart containers after changing environment variables

### Getting Help

- Check the [API Documentation](./API.md)
- Review [Deployment Guide](./DEPLOYMENT.md)
- Open an issue on GitHub for bugs
- Contact the development team for urgent issues

## 📈 Monitoring & Logs

### Development Logs
```bash
# Backend logs
cd backend && dotnet run --project PhishGuardAI.Api

# Frontend logs
cd frontend/phishguardai-dashboard && npm run dev

# Docker logs
docker-compose logs -f
```

### Production Monitoring
- Application logs are stored in `/var/log/phishguardai/`
- Use `docker-compose logs` to view container logs
- Monitor database performance with PostgreSQL logs

---

**Next Steps**: Once you have the basic setup running, proceed to the [API Documentation](./API.md) to understand the available endpoints and start building your first phishing campaign! 