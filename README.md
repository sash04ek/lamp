# LAMP Stack Docker Project

A complete LAMP (Linux, Apache, MySQL, PHP) stack setup using Docker Compose.

## Overview

This project provides a containerized LAMP environment with a comprehensive PHP application (p9) that includes:
- Core functionality with user authentication and management
- Calendar and contact management features
- File storage and cloud integration (Dropbox, Google Drive, Seafile)
- Email and messaging capabilities
- Administrative panel with advanced security features
- Multi-factor authentication support (Duo, Keycloak)
- WebDAV/DAV support

## Project Structure

```
.
├── Dockerfile              # Docker image configuration for PHP/Apache
├── docker-compose.yml      # Docker Compose service definitions
├── php.ini                 # PHP configuration
├── .env                    # Environment variables
├── .gitignore              # Git ignore rules
└── html/                   # Web root
    ├── index.php           # Main entry point
    └── p9/                 # Main application
        ├── modules/        # Feature modules
        ├── vendor/         # Composer dependencies
        ├── static/         # Static assets
        ├── system/         # System files
        ├── data/           # Application data
        │   ├── cache/
        │   ├── logs/
        │   └── settings/
        ├── adminpanel/     # Administrative interface
        ├── dev/            # Development utilities
        └── composer.json   # PHP dependencies
```

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
   - Admin panel: `http://localhost/p9/adminpanel`

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

## File Structure Details

### Core Modules (`html/p9/modules/`)
The application includes multiple feature modules:
- **Core**: Base functionality and authentication
- **AdminAuth**: Administrator authentication
- **AdminPanelWebclient**: Web-based admin interface
- **Calendar**: Calendar management
- **Contacts**: Contact management
- **Files**: File storage and management
- **Dav**: WebDAV protocol support
- **DavContacts**: WebDAV contacts synchronization
- **Google, Facebook, Keycloak**: Third-party integrations
- **And many more...**

### Static Assets (`html/p9/static/`)
Contains compiled JavaScript, CSS, and other frontend assets.

### Data Directory (`html/p9/data/`)
Application runtime data including:
- **cache/**: Cached data
- **logs/**: Application logs
- **settings/**: User and system settings
- **encryption_key.php**: Encryption configuration

## Database Setup

Database migrations and setup scripts are available in `html/p9/dev/`:
- `migrate.php`: Database migration script
- `migrate-contacts-to-dav-cards.php`: Contacts migration

Run migrations after initial setup:
```bash
docker-compose exec php php /var/www/html/p9/dev/migrate.php
```

## API Documentation

API documentation is available in:
- `html/p9/apidoc.json`: OpenAPI specification
- `html/p9/apidoc-overview.md`: API overview

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
