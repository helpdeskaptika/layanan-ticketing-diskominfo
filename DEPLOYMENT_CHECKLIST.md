# ============================================================
# osTicket Docker - Deployment Checklist
# ============================================================

## 📋 Pre-Deployment Checklist

### Environment Setup
- [ ] Docker Engine 20.10+ installed
- [ ] Docker Compose 1.29+ installed (v2+ recommended)
- [ ] Minimum 4GB RAM available
- [ ] Ports 8080 & 3306 available
- [ ] osTicket v1.18.3 source downloaded

### Configuration
- [ ] .env file created from .env.example
- [ ] Strong passwords set in .env
- [ ] Correct timezone configured
- [ ] Docker network connectivity verified

### Project Structure
- [ ] `docker-setup/` directory created
- [ ] `src/` directory created with osTicket files
- [ ] All required files present (Dockerfile, docker-compose.yml, etc.)
- [ ] `.env` marked in `.gitignore`

---

## 🚀 Deployment Steps

### Step 1: Initial Build

```bash
# Navigate to project directory
cd docker-setup

# Build image
docker compose build

# Expected: Image layers built successfully
# Check: docker images | grep osticket
```

**Troubleshooting if build fails:**
```bash
# View build logs in detail
docker compose build --verbose

# Common issues:
# - Network problems: Check internet connection
# - Disk space: Check with 'df -h'
# - DNS: Try 'docker system prune' and rebuild
```

### Step 2: Start Services

```bash
# Start containers in background
docker compose up -d

# Wait 20-30 seconds for database initialization
sleep 30

# Check status
docker compose ps

# Expected: Both services showing "Up" and "healthy"
```

**Troubleshooting if services fail:**
```bash
# Check logs
docker compose logs web
docker compose logs db

# Common issues:
# - Port conflict: Check 'netstat -an | grep 8080'
# - Database not ready: Wait longer, check logs
# - Permission denied: Run 'docker compose down && docker compose up -d'
```

### Step 3: Verify Connectivity

```bash
# Test web service
curl http://localhost:8080

# Test database connection from web
docker compose exec web mysql -h db -u osticket -p -e "SELECT 1;"
# Enter password when prompted (from .env MYSQL_PASSWORD)

# Expected: All tests pass without errors
```

### Step 4: Access Web Installer

```bash
# Open browser
firefox http://localhost:8080
# or
google-chrome http://localhost:8080
# or
open -a "Google Chrome" http://localhost:8080  # Mac
```

**osTicket Installer appears:**
1. System check page loads
2. Click "Next"
3. Fill in database configuration:
   - Host: `db`
   - Port: `3306`
   - Name: `osticket` (from .env)
   - User: `osticket` (from .env)
   - Password: (from .env MYSQL_PASSWORD)
4. Continue through remaining steps
5. Create admin account
6. Complete installation

### Step 5: Post-Installation Security

```bash
# Disable setup directory
docker compose exec web chmod 000 /var/www/html/setup

# Or rename it
docker compose exec web mv /var/www/html/setup /var/www/html/setup.disabled

# Verify permissions
docker compose exec web ls -la /var/www/html/ | grep setup
# Expected: No read/write permissions on setup
```

### Step 6: Create Backup

```bash
# Backup database
docker compose exec db mysqldump -u osticket -p osticket > backup_initial.sql

# Verify backup
ls -lh backup_initial.sql

# Backup configuration
docker compose cp web:/var/www/html/upload/include/ost-config.php ./ost-config.php.backup

# Store safely
# Recommended: Store in version control (without passwords)
```

---

## ✅ Post-Deployment Verification

### Functionality Tests

```bash
# Test 1: Web access
curl -s http://localhost:8080 | grep -q "osTicket" && echo "✓ Web OK" || echo "✗ Web FAIL"

# Test 2: Database
docker compose exec web mysql -h db -u osticket -p -e "SELECT COUNT(*) FROM osticket.ost_config;" && echo "✓ DB OK" || echo "✗ DB FAIL"

# Test 3: PHP
docker compose exec web php -v | grep -q "8.1" && echo "✓ PHP OK" || echo "✗ PHP FAIL"

# Test 4: Extensions
docker compose exec web php -m | grep -E "mysqli|gd|imap|intl|zip" && echo "✓ Extensions OK" || echo "✗ Extensions FAIL"

# Test 5: Permissions
docker compose exec web test -w /var/www/html/upload/include && echo "✓ Permissions OK" || echo "✗ Permissions FAIL"
```

### Performance Checks

```bash
# Check memory usage
docker stats --no-stream

# Expected: 
# - Web: 50-150 MB
# - DB: 100-300 MB

# Check disk usage
docker system df

# Expected: Reasonable usage without massive waste
```

### Logs Analysis

```bash
# Check for errors in web
docker compose logs web | grep -i error | head -20

# Check for errors in database
docker compose logs db | grep -i error | head -20

# Check Apache access log
docker compose exec web tail -f /var/log/apache2/access.log

# Expected: Few or no ERROR lines
```

---

## 🔒 Security Hardening

### After Initial Deployment

```bash
# 1. Change admin password
# Login to osTicket web interface
# Go to: Admin Panel > Staff > [Admin] > Change Password

# 2. Disable unnecessary features
# Admin Panel > Settings > System

# 3. Configure email (optional)
# Admin Panel > Settings > Email

# 4. Setup backup schedule
# Create cron job or script:
docker compose exec db mysqldump -u osticket -p osticket > /backups/osticket_$(date +%Y%m%d_%H%M%S).sql
```

### Firewall Configuration (Linux)

```bash
# UFW (Uncomplicated Firewall)
sudo ufw allow 8080/tcp        # osTicket web
sudo ufw deny 3306             # Block direct DB access
sudo ufw enable

# Check rules
sudo ufw status

# For SSH access
sudo ufw allow 22/tcp
```

### SSL Certificate Setup (Production)

```bash
# Generate self-signed certificate (development)
docker compose exec web openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt -days 365 -nodes

# For production, use Let's Encrypt with nginx reverse proxy
```

---

## 📊 Monitoring & Maintenance

### Daily Tasks

```bash
# Check service health
docker compose ps

# Review error logs
docker compose logs web | grep ERROR
docker compose logs db | grep ERROR

# Monitor disk usage
du -sh /var/lib/docker/volumes/osticket*
```

### Weekly Tasks

```bash
# Backup database
docker compose exec db mysqldump -u osticket -p osticket > /backups/osticket_weekly_$(date +%Y%m%d).sql

# Check disk space
docker system df

# Review access logs
docker compose exec web tail -100 /var/log/apache2/access.log
```

### Monthly Tasks

```bash
# Clean up old backups (keep last 3 months)
find /backups -name "osticket_*.sql" -mtime +90 -delete

# Update system packages (rebuild image)
docker compose build --no-cache
docker compose up -d

# Test disaster recovery (restore from backup)
# In test environment only
```

---

## 🚨 Emergency Procedures

### Service Down

```bash
# 1. Check status
docker compose ps

# 2. Check logs
docker compose logs web
docker compose logs db

# 3. Restart services
docker compose restart

# 4. Force restart
docker compose down
docker compose up -d

# 5. Full rebuild (last resort)
docker compose down -v
docker compose build --no-cache
docker compose up -d
```

### Database Corruption

```bash
# 1. Stop web service to prevent more corruption
docker compose stop web

# 2. Try to backup current state
docker compose exec db mysqldump -u osticket -p osticket > backup_corrupted.sql

# 3. Restore from known good backup
docker compose exec db mysql -u osticket -p osticket < backup_known_good.sql

# 4. Restart
docker compose restart

# 5. Run repair (if needed)
docker compose exec db mysqlcheck -u osticket -p osticket --repair --all
```

### Disk Space Full

```bash
# 1. Check usage
docker system df

# 2. Clean old logs
docker compose exec web rm -f /var/log/apache2/*.log

# 3. Clean Docker data
docker system prune

# 4. Move database backup elsewhere
mkdir /mnt/backup
docker volume create --opt type=nfs --opt o=addr=192.168.1.100,vers=4,soft,timeo=180,bg,tcp,rw --opt device=:/export/docker osticket_backup

# 5. Expand storage (increase volume size if using cloud)
```

---

## 📞 Support & References

### Useful Commands Quick Reference

```bash
# Container management
docker compose up -d        # Start
docker compose stop         # Stop
docker compose restart      # Restart
docker compose down         # Stop and remove
docker compose ps           # List status

# Logs and debugging
docker compose logs -f      # Follow logs
docker compose logs web     # Specific service
docker compose exec web bash  # Enter shell

# Backup and restore
docker compose exec db mysqldump -u osticket -p osticket > backup.sql
docker compose exec db mysql -u osticket -p osticket < backup.sql

# Database access
docker compose exec db mysql -u root -p

# Health check
curl http://localhost:8080
docker compose exec web curl http://localhost
```

### Documentation

- [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md)
- [QUICK_START.md](QUICK_START.md)
- [osTicket Docs](https://docs.osticket.com)
- [Docker Docs](https://docs.docker.com)

### Getting Help

1. Check logs: `docker compose logs`
2. Review troubleshooting in INSTALLATION_GUIDE.md
3. Check osTicket forums: https://forum.osticket.com
4. Docker community: https://www.docker.com/community

---

**Last Updated: 2024**
**For osTicket v1.18.3 with Docker Compose**
