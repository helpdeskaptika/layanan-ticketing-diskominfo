# osTicket v1.18.3 - Docker Compose Installation Guide

## 📋 Daftar Isi

1. [Struktur Folder](#struktur-folder)
2. [Persiapan](#persiapan)
3. [Langkah Instalasi](#langkah-instalasi)
4. [Konfigurasi](#konfigurasi)
5. [Troubleshooting](#troubleshooting)
6. [Security Best Practices](#security-best-practices)

---

## 🗂️ Struktur Folder

```
osticket/
├── docker-compose.yml       # Docker Compose configuration
├── Dockerfile               # Custom PHP Apache Alpine image
├── php.ini                  # PHP Configuration untuk osTicket
├── entrypoint.sh            # Startup script untuk database check
├── .env                     # Environment variables (JANGAN commit!)
├── .env.example             # Template file .env
├── db_init.sql              # Database initialization script
├── src/                     # Folder untuk source code osTicket
│   └── (kosong, akan diisi saat instalasi)
├── README.md                # File ini
└── docker-compose.override.yml # (optional) Development overrides
```

---

## 🚀 Persiapan

### Requirements

- Docker Engine 20.10+ (atau terbaru)
- Docker Compose 1.29+ (atau terbaru, sebaiknya v2+)
- Minimal 4GB RAM
- Port 8080 dan 3306 tersedia di localhost

### Verifikasi Instalasi Docker

```bash
# Check Docker version
docker --version
# Expected: Docker version 20.10 or higher

# Check Docker Compose version
docker compose version
# Expected: Docker Compose version v2.x.x or higher

# Verifikasi Docker daemon berjalan
docker ps
# Tidak boleh error
```

---

## 📥 Langkah Instalasi

### Step 1: Download osTicket v1.18.3

```bash
# Buat folder untuk project
mkdir -p ~/osticket-docker
cd ~/osticket-docker

# Download osTicket v1.18.3 dari official source
wget https://github.com/osTicket/osTicket/releases/download/v1.18.3/osTicket-v1.18.3.zip

# Atau gunakan curl jika wget tidak tersedia
curl -L -o osTicket-v1.18.3.zip https://github.com/osTicket/osTicket/releases/download/v1.18.3/osTicket-v1.18.3.zip

# Extract file
unzip osTicket-v1.18.3.zip

# Verifikasi struktur
ls -la
# Harus ada folder: osTicket-1.18.3 atau upload

# Pindahkan ke folder src/ (atau buat symlink)
mv osTicket-1.18.3/* src/
# atau
# mkdir -p src
# cp -r osTicket-1.18.3/* src/
```

### Step 2: Setup Environment Variables

```bash
# Copy template .env
cp .env.example .env

# Edit .env dengan text editor favorit Anda
nano .env
# atau
vim .env
# atau buka dengan VS Code

# Ubah nilai-nilai berikut sesuai kebutuhan:
# - MYSQL_PASSWORD (ubah dari default)
# - MYSQL_ROOT_PASSWORD (ubah dari default)
# - WEB_PORT (default 8080, bisa diubah)
# - TIMEZONE (default Asia/Jakarta)
```

### Step 3: Build Docker Image

```bash
# Build image dengan custom Dockerfile
docker compose build

# Output akan menunjukkan proses building
# - Download Alpine Linux image
# - Install dependencies
# - Install PHP extensions
# - Copy configurations
```

### Step 4: Jalankan Containers

```bash
# Jalankan dalam detached mode (background)
docker compose up -d

# Lihat status containers
docker compose ps

# Lihat logs realtime (tekan Ctrl+C untuk exit)
docker compose logs -f

# Tunggu sampai kedua service ready:
# - osticket_web: healthy
# - osticket_db: healthy (startup time: ~15-30 detik)
```

### Step 5: Verifikasi Containers

```bash
# Check status
docker compose ps

# Expected output:
# NAME                 COMMAND                  SERVICE             STATUS
# osticket_db   docker-entrypoint.sh mysqld   db                 Up 1 min (healthy)
# osticket_web  /usr/local/bin/entrypoint.sh web                Up 50 sec (healthy)

# Test database connection dari web container
docker compose exec web mysql -h db -u osticket -p -e "SELECT 1;"

# Setelah diminta password, masukkan password yang ada di .env
```

### Step 6: Akses Web Installer

```bash
# Buka browser dan akses:
http://localhost:8080

# Anda akan melihat osTicket Installer
# Jika belum ada, tunggu beberapa detik dan refresh
```

---

## ⚙️ Konfigurasi

### Web Installer Configuration

Ketika Anda membuka `http://localhost:8080`, ikuti langkah-langkah berikut:

#### Step 1: System Check

- Periksa semua requirement
- Semua harus berwarna hijau (✓)
- Jika ada warning, catat untuk troubleshooting

#### Step 2: Database Configuration

**Isi dengan data dari file .env Anda:**

```
Database Hostname:      db
Database Port:          3306
Database Name:          osticket
Database Username:      osticket
Database Password:      osticketpass (dari .env)
```

**Catatan Penting:**
- Hostname adalah nama service Docker: `db` (BUKAN localhost)
- Gunakan nilai yang sama dengan .env
- Test koneksi sebelum lanjut

#### Step 3: Administrator Account

```
First Name:             Nama depan admin
Last Name:              Nama belakang admin
Email Address:          admin@yourdomain.com
Username:               admin (bisa diubah)
Password:               (buat password yang kuat!)
Retype Password:        (konfirmasi password)
```

#### Step 4: osTicket Configuration

```
Helpdesk Name:          PT/CV Anda
Helpdesk URL:           http://localhost:8080
Default Email:          helpdesk@yourdomain.com
```

#### Step 5: Email Configuration (Optional)

Bisa dilewati untuk sekarang, atau setup:

```
POP3 Host:              (mail server POP3)
SMTP Host:              localhost
SMTP Port:              25 atau 587
```

#### Step 6: Install osTicket

- Klik tombol "Install Now"
- Tunggu proses instalasi selesai
- Akan redirect ke halaman sukses

---

## 🔧 Troubleshooting

### Problem 1: Database Connection Failed

**Error:**
```
Could not connect to the database server provided
```

**Solusi:**

```bash
# 1. Verifikasi database container berjalan
docker compose ps

# 2. Check logs database
docker compose logs db

# 3. Cek koneksi dari web container
docker compose exec web mysql -h db -u osticket -p -e "SELECT 1;"

# 4. Verifikasi .env sudah benar
cat .env | grep MYSQL

# 5. Restart database
docker compose restart db

# 6. Tunggu ~30 detik dan coba lagi
```

### Problem 2: Web Server Not Responding

**Error:**
```
Connection refused atau timeout
```

**Solusi:**

```bash
# 1. Verifikasi web container running
docker compose ps web

# 2. Check logs
docker compose logs web

# 3. Verifikasi port 8080 tidak terpakai
# Windows:
netstat -ano | findstr :8080

# Linux/Mac:
lsof -i :8080

# 4. Jika port terpakai, ubah WEB_PORT di .env menjadi port lain
# Kemudian rebuild:
docker compose down
docker compose up -d

# 5. Cek Apache status
docker compose exec web apache2ctl status
```

### Problem 3: PHP Extensions Missing

**Error:**
```
Fatal error: Call to undefined function mysqli_connect()
```

**Solusi:**

```bash
# 1. Verifikasi PHP extensions terpasang
docker compose exec web php -m | grep mysqli

# 2. Jika tidak ada, rebuild image
docker compose down
docker compose build --no-cache
docker compose up -d

# 3. Check log build untuk error
docker compose build 2>&1 | grep -i error
```

### Problem 4: Permission Denied

**Error:**
```
Permission denied atau 403 Forbidden
```

**Solusi:**

```bash
# 1. Verifikasi permissions
docker compose exec web ls -la /var/www/html/

# 2. Fix permissions
docker compose exec web chown -R www-data:www-data /var/www/html
docker compose exec web chmod -R 755 /var/www/html
docker compose exec web chmod -R 775 /var/www/html/upload/attachments
docker compose exec web chmod -R 775 /var/www/html/upload/include

# 3. Restart web service
docker compose restart web
```

### Problem 5: Disk Space Issues

**Error:**
```
No space left on device
```

**Solusi:**

```bash
# 1. Check disk usage
docker system df

# 2. Clean up unused images/volumes
docker system prune -a
# atau hanya untuk volumes tertentu:
docker volume rm osticket_osticket_db_data

# 3. Recreate containers
docker compose up -d
```

### Problem 6: entrypoint.sh: permission denied

**Error:**
```
exec /usr/local/bin/entrypoint.sh: permission denied
```

**Solusi:**

```bash
# Pastikan file punya permission execute di host
# Windows (menggunakan Git Bash atau WSL):
chmod +x entrypoint.sh

# Linux/Mac:
chmod +x entrypoint.sh

# Rebuild image
docker compose build --no-cache
docker compose up -d
```

---

## 🔐 Security Best Practices

### After Installation

#### 1. Secure Setup Directory

```bash
# Setup folder harus di-protect setelah instalasi
docker compose exec web chmod -R 000 /var/www/html/setup

# Atau rename folder
docker compose exec web mv /var/www/html/setup /var/www/html/setup.disabled

# Untuk akses kembali ke setup:
docker compose exec web chmod -R 755 /var/www/html/setup
```

#### 2. Set Correct Permissions

```bash
# Read-only untuk public files
docker compose exec web chmod -R 755 /var/www/html/upload

# Write-able untuk directories yang perlu
docker compose exec web chmod -R 775 /var/www/html/upload/attachments
docker compose exec web chmod -R 775 /var/www/html/upload/include

# Include directory
docker compose exec web chmod -R 755 /var/www/html/upload/include
docker compose exec web chown -R www-data:www-data /var/www/html/upload/include
```

#### 3. Change Default Credentials

- Ubah username admin (dari 'admin')
- Ubah password admin dengan password yang kuat
- Hapus default email jika ada

#### 4. Configure Firewall

```bash
# Batasi akses database hanya dari web container
# Docker compose sudah menggunakan internal network

# Jika menggunakan UFW (Linux):
sudo ufw allow 8080/tcp    # Web access
sudo ufw deny 3306         # Database hanya internal
```

#### 5. Backup Database

```bash
# Create backup
docker compose exec db mysqldump -u osticket -p osticket > backup.sql

# Atau gunakan volume backup:
docker run --rm -v osticket_osticket_db_data:/data -v $(pwd):/backup \
  alpine tar czf /backup/osticket_backup.tar.gz -C /data .
```

#### 6. Update .env Configuration

```env
# Production recommendations

# 1. Ubah password database dengan password kuat
MYSQL_PASSWORD=S3cur3P@ssw0rd!2024#ABC123XYZ

# 2. Ubah root password
MYSQL_ROOT_PASSWORD=R00tP@ssw0rd!2024#ABC123XYZ

# 3. Ubah WEB_PORT jika diperlukan
WEB_PORT=8080

# 4. Sesuaikan timezone dengan region
TIMEZONE=Asia/Jakarta
```

#### 7. Use Environment File Properly

```bash
# Jangan commit .env ke git
echo ".env" >> .gitignore

# Gunakan .env.example sebagai template
cp .env .env.example

# Hanya commit .env.example (dengan nilai dummy)
git add .env.example
git add .gitignore

# Jangan commit .env
git rm --cached .env 2>/dev/null || true
```

---

## 📊 Docker Commands Reference

### Container Management

```bash
# Start containers
docker compose up -d

# Stop containers
docker compose stop

# Stop and remove containers
docker compose down

# Stop dan remove semua termasuk volumes (HATI-HATI!)
docker compose down -v

# Restart containers
docker compose restart

# View status
docker compose ps

# View logs
docker compose logs -f           # Follow all logs
docker compose logs web          # Logs dari service tertentu
docker compose logs db
```

### Container Execution

```bash
# Execute command dalam container
docker compose exec web bash
docker compose exec db mysql -u osticket -p

# Copy files
docker compose cp web:/var/www/html/include/ost-config.php ./
docker compose cp ./backup.sql db:/

# Inspect container
docker compose inspect web
```

### Database Management

```bash
# Enter MySQL console
docker compose exec db mysql -u root -p

# Backup database
docker compose exec db mysqldump -u osticket -p osticket > backup.sql

# Restore database
docker compose exec db mysql -u osticket -p osticket < backup.sql

# Check database size
docker compose exec db mysql -u osticket -p -e "SELECT table_name, ROUND((data_length + index_length) / 1024 / 1024, 2) AS size_mb FROM information_schema.tables WHERE table_schema = 'osticket';"
```

### Image Management

```bash
# List images
docker images

# Build image
docker compose build

# Build dengan no-cache (force rebuild)
docker compose build --no-cache

# Remove image
docker rmi image_name

# Clean up unused images
docker image prune -a
```

### Volume Management

```bash
# List volumes
docker volume ls

# Inspect volume
docker volume inspect osticket_osticket_db_data

# Remove volume
docker volume rm osticket_osticket_db_data

# Backup volume
docker run --rm -v osticket_osticket_db_data:/data -v $(pwd):/backup \
  alpine tar czf /backup/db_backup.tar.gz -C /data .
```

---

## 📝 osTicket Configuration Files

### Important Files Location

```
/var/www/html/upload/include/ost-config.php        # Main configuration
/var/www/html/upload/include/ost-scp.php           # Secret code
/var/www/html/setup/                               # Setup directory (disable after install)
/var/www/html/api/                                 # API endpoint
```

### Accessing Configuration Files

```bash
# Copy config file to host
docker compose cp web:/var/www/html/upload/include/ost-config.php ./

# Edit in container
docker compose exec web nano /var/www/html/upload/include/ost-config.php

# View file in container
docker compose exec web cat /var/www/html/upload/include/ost-config.php
```

---

## 🔄 Upgrade Guide

### Backing Up Before Upgrade

```bash
# 1. Backup database
docker compose exec db mysqldump -u osticket -p osticket > backup_pre_upgrade.sql

# 2. Backup source code
docker compose cp web:/var/www/html ./backup_html_pre_upgrade

# 3. Stop containers
docker compose stop
```

### Upgrade Process

```bash
# 1. Download new version
# (Follow osTicket official upgrade guide)

# 2. Replace source in src/

# 3. Restart containers
docker compose up -d

# 4. Check web interface at http://localhost:8080/setup
```

---

## 📞 Support & Resources

### Official Resources

- osTicket Official: https://osticket.com
- osTicket GitHub: https://github.com/osTicket/osTicket
- Docker Documentation: https://docs.docker.com
- Docker Compose: https://docs.docker.com/compose/

### Common Issues & Solutions

- Database connection issues → Check .env variables
- Permission errors → Fix file permissions
- Port conflicts → Change WEB_PORT or DB_PORT
- Performance issues → Increase PHP memory_limit

---

## 📜 License & Notes

- osTicket v1.18.3: Licensed under GNU General Public License v2.0+
- Docker configuration: Provided as-is for development/testing
- Untuk production: Konsultasi dengan DevOps/Security team

---

**Dibuat untuk osTicket v1.18.3 dengan Docker Compose**
**Last Updated: 2024**

---

## ✅ Checklist Post-Installation

- [ ] osTicket installer berhasil dijalankan
- [ ] Database terkoneksi dengan baik
- [ ] Admin account sudah dibuat
- [ ] Setup folder sudah di-secure (chmod 000)
- [ ] File permissions sudah benar
- [ ] Backup database sudah dibuat
- [ ] .env sudah ditambah ke .gitignore
- [ ] Email configuration (jika diperlukan)
- [ ] Test sending ticket dari web
- [ ] Test ticket creation dari API (optional)
