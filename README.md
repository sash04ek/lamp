# LAMP Stack Docker Project

A complete LAMP (Linux, Apache, MySQL, PHP) stack setup using Docker Compose.

## Overview

This project provides a containerized LAMP environment with Docker Compose, configured to run a sophisticated PHP application with support for multiple features including authentication, calendar management, contacts, file storage, and more.

## Project Structure

```
.
├── Dockerfile              # Docker image configuration for PHP/Apache
├── docker-compose.yml      # Docker Compose service definitions
├── php.ini                 # PHP configuration
├── .env                    # Environment variables
├── .gitignore              # Git ignore rules
├── README.md               # This file
└── html/                   # Web root (content managed separately)
```

> **Note:** The `html/` directory contains the web application and is managed separately (see `.gitignore`). This repository tracks the Docker and configuration files needed to run the LAMP stack.

## Requirements

- Docker Desktop (for Mac/Windows) or Docker Engine (for Linux)
- Docker Compose

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/sash04ek/lamp.git
   cd lamp
   ```

2. **Configure environment variables:**
   ```bash
   # Edit .env file with your settings
   cp .env.example .env  # if applicable
   ```

3. **Start the containers:**
   ```bash
   docker-compose up -d
   ```

4. **Access the application:**
   - Web application: `http://localhost`

## Services

The `docker-compose.yml` defines the following services:

- **PHP/Apache**: Main web server running PHP
- **MySQL**: Database server (configured in docker-compose.yml)
- **Additional services**: As defined in docker-compose.yml

## Configuration

### PHP Configuration
Edit `php.ini` to customize PHP settings such as:
- Memory limits
- Upload file sizes
- Session timeouts
- Display errors

### Switching PHP Version
The PHP version is controlled by the `PHP_VERSION` variable in `.env` (e.g. `PHP_VERSION=8.4`), which is passed as a build arg to the `php:${PHP_VERSION}-apache` base image in the `Dockerfile`.

To switch versions:
```bash
# Edit PHP_VERSION in .env, then rebuild the image
docker-compose build --no-cache web
docker-compose up -d
```
Any tag from the [official PHP Docker images](https://hub.docker.com/_/php) that has an `-apache` variant works (e.g. `8.1`, `8.2`, `8.3`, `8.4`).

### Docker Configuration
Modify `docker-compose.yml` to:
- Change port mappings
- Add environment variables
- Mount additional volumes
- Configure database parameters

## Development

### Building Custom Images
```bash
docker-compose build
```

### Viewing Logs
```bash
docker-compose logs -f php
docker-compose logs -f mysql
```

### Accessing Container Shell
```bash
docker-compose exec php bash
docker-compose exec mysql mysql -u root -p
```

## Application Features

The p9 application includes modules for:
- User authentication and management
- Calendar and contact management
- File storage and synchronization
- Email and messaging
- Administrative panel
- Multi-factor authentication
- Third-party integrations (Google, Facebook, Keycloak, etc.)
- WebDAV/DAV support
- And many more features

## Useful Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# Remove all volumes and data
docker-compose down -v

# Rebuild images
docker-compose build --no-cache

# Run a one-off command
docker-compose exec php php script.php

# View resource usage
docker stats
```

## Troubleshooting

### Port Already in Use
If port 80 or 3306 is already in use:
1. Modify the port mappings in `docker-compose.yml`
2. Or stop other services using those ports

### Permission Issues
If you encounter permission errors in the container:
```bash
docker-compose exec php chown -R www-data:www-data /var/www/html
```

### Database Connection Issues
- Check MySQL is running: `docker-compose ps`
- Verify credentials in `.env`
- Check MySQL logs: `docker-compose logs mysql`

## License

See LICENSE file in `html/p9/` directory for licensing information.

## Support

For issues and questions, please visit the repository:
https://github.com/sash04ek/lamp

---

Last updated: 2026-09-12
