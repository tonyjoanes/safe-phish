# PhishGuardAI - Project Specification & Development Guide

## Project Overview
Phishing attacks are a leading threat to small businesses, with a market demand for simulation tools projected to reach $183.85B by 2032 (7.2% CAGR) [Phishing Simulator Market]. Our tool addresses this by offering:

- **AI-Generated Emails**: Realistic phishing templates powered by OpenAI
- **Campaign Management**: Easy-to-use dashboard for creating and tracking campaigns  
- **Metrics & Reports**: Detailed analytics and PDF reports to train employees
- **Scalability**: Dockerized architecture for seamless deployment on AWS
- **Low Cost**: ~$894 setup, ~$120/month ongoing

This document outlines the project setup and the components to be built to achieve a market-ready product.

## Features

- **Backend (.NET Core)**: REST API for campaign management, email sending, and metrics tracking
- **Frontend (React)**: Responsive dashboard for login, campaign creation, and report viewing
- **AI Integration**: OpenAI API for generating phishing email templates
- **Email Delivery**: Mailgun for sending and tracking emails (opens, clicks)
- **Authentication**: Firebase for secure user login
- **Reports**: jsPDF for generating PDF reports with metrics and training tips
- **Containerization**: Docker for consistent development and deployment
- **CI/CD**: GitHub Actions for automated testing and building

## Prerequisites

### Development Tools:
- .NET 8 SDK
- Node.js (v20)
- Docker Desktop
- Cursor IDE with C# Dev Kit, ESLint, Prettier, and Docker extensions

### Services:
- OpenAI API key (~$100/month)
- Mailgun account (~$15/month)
- Firebase project (free tier)
- AWS S3 for hosting (~$5/month)

### Optional:
- Carrd account for landing page ($19/year)
- Google Analytics for tracking (free)

## What Needs to Be Built

To achieve a market-ready phishing simulation tool, the following components must be developed within 6-8 weeks:

### 1. Backend (.NET Core API)

**Tech**: .NET 8, Entity Framework Core, PostgreSQL

**Tasks**:
- Build REST API endpoints:
  - `POST /campaigns`: Create a phishing campaign (template ID, recipients)
  - `GET /campaigns/{id}`: Retrieve campaign details
  - `POST /emails/send`: Send phishing emails via Mailgun
  - `GET /metrics/{campaignId}`: Track opens and clicks
- Integrate OpenAI API for email template generation (prompt: "Generate a phishing email mimicking a Google password reset")
- Implement database models: Campaign, Email, Metric
- Add xUnit tests for all endpoints (e.g., campaign creation, email sending)

**Cursor Prompt**: "Generate a .NET Core API with Entity Framework for a phishing campaign manager."

### 2. Frontend (React Dashboard)

**Tech**: React, TypeScript, Tailwind CSS, Chart.js, Firebase, jsPDF

**Tasks**:
- Create components:
  - **Login**: Firebase email/password authentication
  - **Campaign Creator**: Form to select templates and recipients
  - **Dashboard**: Visualize metrics (e.g., open/click rates) with Chart.js
  - **Report Viewer**: Download PDF reports with jsPDF (include 3 hardcoded tips, e.g., "Verify sender domains")
- Style with Tailwind CSS for responsiveness
- Deploy to AWS S3 as a static site

**Cursor Prompt**: "Generate a React component for a phishing campaign dashboard with Chart.js and Tailwind."

### 3. Email System

**Tech**: Mailgun API

**Tasks**:
- Integrate Mailgun to send emails and track opens/clicks
- Configure DKIM/SPF for deliverability
- Create tracking URLs (e.g., `https://yourapp.com/track?campaignId=123&email=employee@company.com`)
- Test delivery with Gmail/Outlook

**Cursor Prompt**: "Generate C# code for sending emails with Mailgun API."

### 4. Docker Configuration

**Tech**: Docker, Docker Compose

**Tasks**:
- Create Dockerfile for:
  - Backend (.NET Core API)
  - Frontend (React app)
- Update docker-compose.yml (see repository) for local development
- Test multi-container setup locally

**Cursor Prompt**: "Generate a Dockerfile for a .NET 8 API."

### 5. CI/CD Pipeline

**Tech**: GitHub Actions

**Tasks**:
- Create a workflow to:
  - Run xUnit tests on push
  - Build Docker images
  - Deploy to AWS (optional)
- Ensure zero downtime during updates

**Cursor Prompt**: "Generate a GitHub Actions workflow for .NET Core testing and Docker build."

### 6. Market Validation

**Tech**: Carrd, Google Forms, Google Analytics, LinkedIn Ads

**Tasks**:
- Build a Carrd landing page with demo video (Loom), mock report (Canva), and sign-up form
- Create a Google Form survey for phishing pain points and pricing ($50-$200/year)
- Add Google Analytics to track landing page visits
- Run LinkedIn Ads ($100-$200) targeting small business owners

**Goal**: 200 sign-ups in 30 days for beta testing.

### 7. Documentation

**Tech**: GitHub Wiki, Notion

**Tasks**:
- Create GitHub Wiki pages:
  - Installation instructions
  - API usage guide
  - Troubleshooting
- Set up Notion workspace for tasks, API docs, and validation results

**Cursor Prompt**: "Generate a GitHub Wiki for a phishing simulation tool."

### 8. Future Integrations

**Secure Coding Tutorials**:
- Add links in the dashboard to promote tutorials (e.g., "Learn secure coding")
- Reuse .NET 8 SDK and Cursor for Roslyn-based validation 