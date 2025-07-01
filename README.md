# 🛡️ PhishGuardAI

**AI-Powered Phishing Simulation & Security Awareness Platform**

PhishGuardAI is a comprehensive cybersecurity solution that helps organizations test and improve their employees' security awareness through realistic phishing simulations powered by artificial intelligence.

![Build Status](https://github.com/tonyjoanes/safe-phish/actions/workflows/ci-cd.yml/badge.svg)
![Docker Hub](https://img.shields.io/badge/docker-ready-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ Features

- 🤖 **AI-Powered Email Generation** - Create realistic phishing emails using OpenAI
- 📊 **Campaign Management** - Easy-to-use dashboard for creating and tracking campaigns
- 📈 **Analytics & Reports** - Detailed metrics and PDF reports for training insights
- 🔐 **Firebase Authentication** - Secure user login and management
- 🐳 **Docker Ready** - Containerized for easy deployment anywhere
- ⚡ **CI/CD Pipeline** - Automated testing, building, and Docker Hub publishing

## 🚀 Quick Start

### Using Docker (Recommended)

1. **Clone the repository:**
   `ash
   git clone https://github.com/tonyjoanes/safe-phish.git
   cd safe-phish
   `

2. **Set up environment variables:**
   `ash
   cp env.template .env
   # Edit .env with your API keys (Firebase, OpenAI, etc.)
   `

3. **Start the application:**
   `ash
   docker-compose up --build
   `

4. **Access the application:**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000
   - Database: PostgreSQL on localhost:5432

### Using Pre-built Docker Images

You can also run the latest published images:

`ash
# Run the backend API
docker run -p 5000:8080 tonyjoanes/phishguardai-api:latest

# Run the frontend
docker run -p 3000:80 tonyjoanes/phishguardai-frontend:latest
`

## 🛠️ Development Setup

### Prerequisites

- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- [Node.js v20+](https://nodejs.org/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)

### Local Development

1. **Backend (.NET Core):**
   `ash
   cd backend
   dotnet restore
   dotnet run --project PhishGuardAI.Api
   `

2. **Frontend (React):**
   `ash
   cd frontend/phishguardai-dashboard
   npm install
   npm run dev
   `

3. **Database:**
   `ash
   docker run --name postgres -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres:latest
   `

## 🔧 Configuration

### Required Environment Variables

Create a .env file in the project root with:

`ash
# Firebase Configuration
VITE_FIREBASE_API_KEY=your_firebase_api_key
VITE_FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your_project_id
VITE_FIREBASE_STORAGE_BUCKET=your_project.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
VITE_FIREBASE_APP_ID=your_app_id

# API Configuration
VITE_API_URL=http://localhost:5000

# OpenAI Configuration (for AI features)
OPENAI_API_KEY=your_openai_api_key

# Database Configuration
ConnectionStrings__DefaultConnection=Host=localhost;Database=phishguardai;Username=postgres;Password=password
`

## ��️ Architecture

`
PhishGuardAI/
├── backend/                    # .NET Core 8 API
│   ├── PhishGuardAI.Api/      # Main API project
│   └── PhishGuardAI.Tests/    # Unit tests
├── frontend/                   # React TypeScript frontend
│   └── phishguardai-dashboard/ # Main dashboard app
├── database/                   # PostgreSQL initialization
├── docker-compose.yml         # Development environment
└── .github/workflows/         # CI/CD pipeline
`

## 🧪 Testing

Run backend tests:
`ash
cd backend
dotnet test
`

Run frontend tests:
`ash
cd frontend/phishguardai-dashboard
npm test
`

## 🚀 Deployment

The project includes automated CI/CD via GitHub Actions that:

- ✅ Runs automated tests
- ✅ Builds and lints the frontend
- ✅ Performs security scanning
- ✅ Builds and publishes Docker images to Docker Hub

Docker images are automatically published to:
- 	onyjoanes/phishguardai-api:latest
- 	onyjoanes/phishguardai-frontend:latest

## 📚 Documentation

- 📋 [Project Specification](docs/PROJECT_SPECIFICATION.md) - Detailed development roadmap
- 🚀 [Getting Started Guide](docs/GETTING_STARTED.md) - Step-by-step setup instructions
- 🔧 API Documentation - Available at /swagger when running the backend

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (git checkout -b feature/amazing-feature)
3. Commit your changes (git commit -m 'Add some amazing feature')
4. Push to the branch (git push origin feature/amazing-feature)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

If you have any questions or need help getting started:

- 📧 Email: support@phishguardai.com
- 🐛 Issues: [GitHub Issues](https://github.com/tonyjoanes/safe-phish/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/tonyjoanes/safe-phish/discussions)

---

**Made with ❤️ for cybersecurity awareness**
