# ============================================================
# osTicket Docker - Project README
# ============================================================

Solusi Docker production-ready untuk osTicket v1.18.3 dengan Alpine Linux.

## ✨ Features

✅ PHP 8.1 Apache berbasis Alpine Linux (lightweight)
✅ MariaDB 10.11 Alpine untuk database
✅ Semua PHP extensions yang diperlukan osTicket
✅ Auto database connection checking
✅ Volume persistence untuk data
✅ Network isolation dengan Docker
✅ Health checks otomatis
✅ Production-ready configuration
✅ Comprehensive documentation
✅ Easy backup & restore

## 📂 File Structure

```
osticket-docker/
├── Dockerfile                 # Custom PHP Apache Alpine image
├── docker-compose.yml         # Container orchestration
├── php.ini                    # PHP configuration optimal
├── entrypoint.sh             # Startup & health check script
├── .env                      # Environment variables (JANGAN commit!)
├── .env.example              # Template .env
├── .dockerignore             # Docker build ignore
├── db_init.sql               # Database initialization
├── helper.sh                 # Helper script (Linux/Mac)
├── src/                      # osTicket source code
├── INSTALLATION_GUIDE.md     # Complete installation guide
├── QUICK_START.md            # Quick start guide
└── docker-compose.override.yml.example  # Development overrides
```

## 🚀 Quick Start

```bash
# 1. Download osTicket
wget https://github.com/osTicket/osTicket/releases/download/v1.18.3/osTicket-v1.18.3.zip
unzip osTicket-v1.18.3.zip -d src/

# 2. Setup environment
cp .env .env
nano .env  # Edit password & config

# 3. Build & Run
docker compose build
docker compose up -d

# 4. Open browser
# http://localhost:8080
```

## 📋 Requirements

- Docker Engine 20.10+
- Docker Compose v1.29+ (v2+ recommended)
- 4GB+ RAM
- Port 8080 & 3306 available

## 📚 Documentation

- [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md) - Complete setup guide
- [QUICK_START.md](QUICK_START.md) - 5-minute quick start

## 💻 Useful Commands

```bash
# Start
docker compose up -d

# Stop
docker compose down

# Logs
docker compose logs -f

# Bash access
docker compose exec web bash

# Database access
docker compose exec db mysql -u osticket -p

# Backup
docker compose exec db mysqldump -u osticket -p osticket > backup.sql

# Restore
docker compose exec db mysql -u osticket -p osticket < backup.sql
```

## 🔐 Security

- Change default passwords di .env
- Disable setup directory setelah instalasi
- Use strong database credentials
- Keep .env out of version control

## 🆘 Troubleshooting

### Database Connection Error

```bash
docker compose logs db
# Check .env credentials
docker compose restart db
```

### Web Server Not Responding

```bash
docker compose logs web
# Check if port 8080 is available
lsof -i :8080
```

### Permission Denied

```bash
docker compose exec web chmod -R 755 /var/www/html
docker compose exec web chown -R www-data:www-data /var/www/html
```

## 📝 Environment Variables

Lihat `.env` untuk konfigurasi lengkap:

- `WEB_PORT` - Port untuk web service (default: 8080)
- `MYSQL_HOST` - Database hostname (default: db)
- `MYSQL_PORT` - Database port (default: 3306)
- `MYSQL_DATABASE` - Database name (default: osticket)
- `MYSQL_USER` - Database user (default: osticket)
- `MYSQL_PASSWORD` - Database password (UBAH!)
- `MYSQL_ROOT_PASSWORD` - Root password (UBAH!)
- `TIMEZONE` - Server timezone (default: Asia/Jakarta)

## 📦 Included Packages

### PHP Extensions
- mysqli (database)
- pdo_mysql (database)
- gd (image processing)
- imap (email)
- intl (internationalization)
- zip (archive)
- mbstring (string)
- xml (xml parsing)
- curl (http requests)
- opcache (caching)

### Tools
- MariaDB client tools
- Git, wget, unzip
- MySQL dump & restore

## 🔄 Upgrade

1. Backup database: `docker compose exec db mysqldump -u osticket -p osticket > backup.sql`
2. Download new osTicket version
3. Replace files in `src/`
4. Restart: `docker compose restart web`
5. Visit `http://localhost:8080/setup`

## 📞 Support

- osTicket: https://osticket.com
- Docker: https://docs.docker.com
- Issues: Check INSTALLATION_GUIDE.md troubleshooting section

## 📄 License

- osTicket: GNU General Public License v2.0+
- Docker configuration: Provided as-is

---

**Made for osTicket v1.18.3 with ❤️**
