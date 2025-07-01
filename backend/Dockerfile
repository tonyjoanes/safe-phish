# Use the official .NET 8 SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy csproj files and restore dependencies
COPY PhishGuardAI.Api/*.csproj ./PhishGuardAI.Api/
COPY PhishGuardAI.Tests/*.csproj ./PhishGuardAI.Tests/
RUN dotnet restore PhishGuardAI.Api/PhishGuardAI.Api.csproj

# Copy everything else and build the application
COPY . ./
RUN dotnet publish PhishGuardAI.Api/PhishGuardAI.Api.csproj -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Create a non-root user
RUN adduser --disabled-password --gecos '' appuser && chown -R appuser /app
USER appuser

# Expose port
EXPOSE 8080

# Set environment variables
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Development

# Entry point
ENTRYPOINT ["dotnet", "PhishGuardAI.Api.dll"] 