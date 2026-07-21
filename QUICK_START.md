# ============================================================
# osTicket Docker - Quick Start Guide
# ============================================================

## 🚀 Quick Start (5 Menit)

### 1. Download osTicket

```bash
cd docker-setup

# Download dan extract
wget https://github.com/osTicket/osTicket/releases/download/v1.18.3/osTicket-v1.18.3.zip -O osTicket-v1.18.3.zip
unzip osTicket-v1.18.3.zip

# Setup folder struktur
mkdir -p src
mv osTicket-1.18.3/* src/ 2>/dev/null || mv upload/* src/ 2>/dev/null || true
```

### 2. Setup Environment

```bash
# Copy template
cp .env .env

# Edit dengan text editor (ubah password)
nano .env
```

### 3. Build & Run

```bash
# Build image
docker compose build

# Run containers
docker compose up -d

# Wait 20-30 seconds untuk database ready
docker compose logs -f
```

### 4. Install osTicket

Buka browser: **http://localhost:8080**

- Database Host: `db`
- Database Name: `osticket`
- Database User: `osticket`
- Database Password: (dari .env)

---

## 📋 Command Cheat Sheet

```bash
# Start
docker compose up -d

# Stop
docker compose down

# Logs
docker compose logs -f

# Bash shell
docker compose exec web bash

# MySQL console
docker compose exec db mysql -u osticket -p

# Backup
docker compose exec db mysqldump -u osticket -p osticket > backup.sql

# Restore
docker compose exec db mysql -u osticket -p osticket < backup.sql

# Rebuild
docker compose build --no-cache
docker compose up -d
```

---

## ✅ Verification Checklist

```bash
# Check containers running
docker compose ps

# Check web health
docker compose exec web curl http://localhost

# Check database
docker compose exec web mysql -h db -u osticket -p -e "SELECT 1;"

# Check PHP extensions
docker compose exec web php -m | grep -E "mysqli|gd|imap|intl|zip|mbstring"
```

---

## 🆘 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Connection refused | `docker compose logs web` \| check if port 8080 is free |
| Database error | `docker compose logs db` \| verify .env credentials |
| Permission denied | `docker compose exec web chmod -R 755 /var/www/html` |
| Setup directory access | `docker compose exec web chmod -R 755 /var/www/html/setup` |

---

**Untuk dokumentasi lengkap, lihat INSTALLATION_GUIDE.md**
