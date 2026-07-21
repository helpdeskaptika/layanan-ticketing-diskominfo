# osTicket v1.18.3 Email Troubleshooting Guide
## Docker Compose Setup - Email Outgoing Issues

---

## ROOT CAUSE ANALYSIS (Kemungkinan Besar → Kecil)

### 🔴 TOP 5 PENYEBAB PALING MUNGKIN:

1. **SMTP Authentication Disabled atau Credentials Salah (60% kemungkinan)**
   - osTicket SMTP authentication tidak diset dengan benar
   - Credentials salah atau expired
   - SMTP relay tidak dikonfigurasi

2. **Network Connectivity dari Docker ke SMTP Server (70% kemungkinan)**
   - Docker container tidak bisa resolve DNS SMTP server
   - Port SMTP blocked (25, 465, 587)
   - Firewall Docker/Host blocking outgoing connection

3. **osTicket SMTP Backend tidak dipilih (50% kemungkinan)**
   - Masih menggunakan PHP mail() function
   - SMTP configuration tidak disave dengan benar

4. **TLS/SSL Certificate Issues (40% kemungkinan)**
   - openssl extension tidak konfigurasi untuk SMTP
   - Certificate verification error
   - Wrong port untuk TLS (harus 465 atau 587)

5. **Email Queue Disabled atau Mail Cron tidak berjalan (35% kemungkinan)**
   - Email queue tidak enabled
   - Cron job untuk send email tidak running
   - Mail Queue status disabled

---

## PRIORITAS INVESTIGASI (Action Order)

### Phase 1: osTicket Configuration Check (5-10 menit)
```
1. Verifikasi SMTP Backend selection di Admin Panel
2. Cek Email Configuration di osTicket
3. Cek Email Queue status
4. Review System Logs
```

### Phase 2: Database Verification (5 menit)
```
5. Query email configuration di database
6. Cek email queue table
7. Cek failed emails
```

### Phase 3: Container Network & DNS (10 menit)
```
8. Test DNS resolution SMTP server
9. Test network connectivity ke SMTP port
10. Test TLS handshake
```

### Phase 4: osTicket Processing (5 menit)
```
11. Enable debug logging
12. Trigger email test
13. Review logs
```

---

## COMMANDS UNTUK INVESTIGASI DI DALAM CONTAINER

### 1️⃣ VERIFIKASI DNS SMTP SERVER
```bash
# Exec ke container
docker exec -it osticket_web bash

# Test DNS resolution
nslookup smtp.gmail.com
dig smtp.gmail.com
getent hosts smtp.gmail.com

# Alternative: ping SMTP server
ping -c 3 smtp.gmail.com

# Check Docker DNS configuration
cat /etc/resolv.conf
```

**Expected Output:**
```
Server:         127.0.0.11
Address:        127.0.0.11#53

Non-authoritative answer:
Name:   smtp.gmail.com
Address: 142.251.41.109
```

---

### 2️⃣ TEST KONEKTIVITAS SMTP PORT
```bash
# Gunakan netcat atau telnet
apt-get update && apt-get install -y netcat-openbsd telnet

# Test port 587 (TLS - STARTTLS)
nc -zv smtp.gmail.com 587

# Test port 465 (SSL - Implicit TLS)
nc -zv smtp.gmail.com 465

# Test port 25 (Plain)
nc -zv smtp.gmail.com 25

# Alternative dengan telnet
telnet smtp.gmail.com 587
```

**Expected Output untuk Port Terbuka:**
```
Connection to smtp.gmail.com 587 port [tcp/submission] succeeded!
```

---

### 3️⃣ TEST TLS HANDSHAKE DAN CERTIFICATE
```bash
# Install openssl dan tools lainnya
apt-get install -y openssl curl mailutils

# Test TLS dengan explicit verbose output
openssl s_client -connect smtp.gmail.com:465 -showcerts

# Test STARTTLS (port 587)
openssl s_client -connect smtp.gmail.com:587 -starttls smtp -showcerts

# Simpler: check certificate expiry
echo | openssl s_client -connect smtp.gmail.com:465 2>/dev/null | \
  openssl x509 -noout -dates
```

**Expected Output:**
```
notBefore=Jan 10 08:00:00 2024 GMT
notAfter=Apr 9 07:59:59 2024 GMT
```

---

### 4️⃣ TEST SMTP AUTHENTICATION
```bash
# Method 1: Using bash with nc (manual SMTP protocol)
{
  sleep 1
  echo "EHLO osticket"
  sleep 1
  echo "AUTH LOGIN"
  sleep 1
  # Email dalam base64
  echo "c3VwcG9ydEBleGFtcGxlLmNvbQ=="
  sleep 1
  # Password dalam base64
  echo "cGFzc3dvcmQxMjM="
  sleep 1
  echo "QUIT"
} | nc smtp.gmail.com 587

# Method 2: Using ssmtp untuk test SMTP
apt-get install -y ssmtp

# Buat temporary ssmtp config
cat > /tmp/ssmtp.conf << 'EOF'
root=your-email@gmail.com
mailhub=smtp.gmail.com:587
AuthUser=your-email@gmail.com
AuthPass=your-app-password
UseSTARTTLS=YES
EOF

# Send test email
echo "Subject: Test Email" | ssmtp -C /tmp/ssmtp.conf recipient@example.com

# Method 3: Using swaks (Swiss Army Knife for SMTP)
apt-get install -y swaks

swaks -t recipient@example.com \
      -f sender@gmail.com \
      -s smtp.gmail.com:587 \
      -au sender@gmail.com \
      -ap "your-app-password" \
      --tls \
      -m "Test email dari Docker container"
```

---

### 5️⃣ CEK MAIL QUEUE DI SISTEM
```bash
# Check sendmail queue
mailq

# Check postfix queue (jika menggunakan postfix)
postqueue -p

# List email files di queue
ls -la /var/spool/mail/
ls -la /var/mail/

# Check Apache access dan error log
tail -f /var/log/apache2/error.log
tail -f /var/log/apache2/access.log
```

---

### 6️⃣ CEK OSTICKET PHP MAIL CONFIGURATION
```bash
# Check PHP sendmail_path
php -i | grep sendmail_path

# Check PHP SMTP settings
php -i | grep -E "SMTP|sendmail"

# Verify osTicket include directory
ls -la /var/www/html/include/

# Check ost-config.php permissions
ls -la /var/www/html/include/ost-config.php
cat /var/www/html/include/ost-config.php
```

---

### 7️⃣ TEST EMAIL LANGSUNG DENGAN PHP
```bash
# SSH ke container
docker exec -it osticket_web bash

# Buat test script
cat > /tmp/test-email.php << 'EOF'
<?php
// Test 1: PHP mail()
echo "Test 1: PHP mail()\n";
$result = mail('recipient@example.com', 'Test Subject', 'Test Body', 'From: admin@osticket.local');
echo "Result: " . ($result ? "TRUE" : "FALSE") . "\n\n";

// Test 2: Check SMTP settings
echo "Test 2: SMTP Configuration\n";
echo "SMTP: " . ini_get('SMTP') . "\n";
echo "sendmail_path: " . ini_get('sendmail_path') . "\n";
echo "sendmail_from: " . ini_get('sendmail_from') . "\n\n";

// Test 3: phpMailer simulation
echo "Test 3: Attempting SMTP connection simulation\n";
$smtp = fsockopen('smtp.gmail.com', 587, $errno, $errstr, 10);
if ($smtp) {
    echo "SMTP Connection: SUCCESS\n";
    fclose($smtp);
} else {
    echo "SMTP Connection: FAILED - $errstr ($errno)\n";
}
?>
EOF

php /tmp/test-email.php
```

---

### 8️⃣ TAIL osTicket ERROR LOG
```bash
# Locate osTicket logs
find /var/www/html -name "*.log" -o -name "logs" -type d

# Check osTicket error logs
tail -f /var/www/html/include/plugins/*/logs/*.log 2>/dev/null

# Check PHP-FPM logs (jika ada)
tail -f /var/log/php-fpm.log 2>/dev/null

# Check syslog
tail -f /var/log/syslog
tail -f /var/log/messages
```

---

## SQL QUERIES UNTUK MARIADB

### 1️⃣ CEK EMAIL CONFIGURATION
```sql
-- Connect ke database
docker exec -it osticket_db mysql -u osticket -p -D osticket

-- Query konfigurasi email
SELECT * FROM ost_config WHERE name LIKE '%email%' OR name LIKE '%mail%' OR name LIKE '%smtp%';

-- Hasil akan menunjukkan:
-- - email_default
-- - alert_email_id
-- - default_alert_email
-- - email.smtp.*
```

**Expected Sample Output:**
```sql
+-----------+---------------------+--------------------------------------------------+
| name      | type                | value                                            |
+-----------+---------------------+--------------------------------------------------+
| email.smtp.host | string          | smtp.gmail.com                                   |
| email.smtp.port | int             | 587                                              |
| email.smtp.auth | bool            | 1                                                |
| email.smtp.user | string          | your-email@gmail.com                             |
| email.smtp.pass | string          | [encrypted]                                      |
| email.smtp.tls  | bool            | 1                                                |
+-----------+---------------------+--------------------------------------------------+
```

---

### 2️⃣ CEK EMAIL QUEUE
```sql
-- Lihat email queue
SELECT * FROM ost_mail_queue LIMIT 10;

-- Lihat count email dalam queue
SELECT COUNT(*) as total_queued FROM ost_mail_queue;

-- Lihat email yang paling baru ditambahkan
SELECT id, email_id, object_id, message, created FROM ost_mail_queue 
ORDER BY created DESC LIMIT 5;

-- Lihat detail queue per status
SELECT status, COUNT(*) as count FROM ost_mail_queue GROUP BY status;
```

---

### 3️⃣ CEK EMAIL YANG GAGAL
```sql
-- Lihat email logs/history
SELECT * FROM ost_email_log LIMIT 10;

-- Lihat email dengan error
SELECT * FROM ost_email_log 
WHERE status = 'failed' OR status = 'error'
ORDER BY created DESC LIMIT 10;

-- Lihat count email per status
SELECT status, COUNT(*) as count 
FROM ost_email_log 
GROUP BY status;

-- Lihat detail email gagal dengan full message
SELECT id, email, subject, status, message, created FROM ost_email_log
WHERE status != 'sent'
ORDER BY created DESC;
```

---

### 4️⃣ CEK EMAIL TEMPLATE & ALERT
```sql
-- Lihat alert settings
SELECT * FROM ost_config WHERE name LIKE 'alert%';

-- Lihat email templates
SELECT * FROM ost_email_template LIMIT 5;

-- Lihat recipient list
SELECT * FROM ost_recipient LIMIT 10;

-- Lihat email address yang terdaftar
SELECT id, name, address, status FROM ost_email;
```

---

### 5️⃣ CEK SYSTEM LOGS OSTICKET
```sql
-- Lihat system logs
SELECT * FROM ost_system_log LIMIT 20;

-- Lihat logs dengan error/warning
SELECT * FROM ost_system_log 
WHERE level IN ('error', 'warn')
ORDER BY created DESC LIMIT 20;

-- Filter email-related logs
SELECT * FROM ost_system_log 
WHERE msg LIKE '%email%' OR msg LIKE '%mail%' OR msg LIKE '%SMTP%'
ORDER BY created DESC LIMIT 20;

-- Lihat semua log kategori
SELECT DISTINCT category FROM ost_system_log;
```

---

### 6️⃣ CEK CRON JOB STATUS
```sql
-- Lihat cron jobs
SELECT * FROM ost_cron;

-- Lihat cron yang berkaitan dengan email
SELECT * FROM ost_cron WHERE func LIKE '%mail%' OR func LIKE '%email%';

-- Lihat execution history
SELECT * FROM ost_cron_event LIMIT 20;

-- Check kapan mail cron terakhir dijalankan
SELECT * FROM ost_cron_event 
WHERE cron_id IN (SELECT id FROM ost_cron WHERE func LIKE '%mail%')
ORDER BY exec_time DESC LIMIT 5;
```

---

## TROUBLESHOOTING CHECKLIST

### ✅ STEP-BY-STEP INVESTIGATION

#### Step 1: Verify osTicket SMTP Configuration (Admin Panel)
```
1. Login ke osTicket admin panel
2. Navigasi: Admin Panel → Settings → Email Settings
3. Check:
   - Email Backend: SMTP atau PHP Mail?
   - SMTP Host: smtp.gmail.com
   - SMTP Port: 587 (TLS) atau 465 (SSL)
   - SMTP Authentication: Enabled
   - SMTP Username: your-email@gmail.com
   - SMTP Password: Visible atau Hidden?
   - Use TLS/SSL: Checked?
   - Save
```

#### Step 2: Enable Debug Mode
```
Di osTicket 1.18.3, enable debug logging di:
Admin Panel → System Settings → System Error Reporting
- Set: "All Errors and Notices"
- Email Debug Mode: Enable (jika ada)

Atau edit ost-config.php:
define('OSTICKET_SYSTEM_DEBUG', true);
define('OSTICKET_DEBUG_AJAX', true);
```

#### Step 3: Run Database Queries
```bash
docker exec -it osticket_db mysql -u osticket -pPASSWORD osticket << 'EOF'
SELECT name, value FROM ost_config WHERE name LIKE '%email%' OR name LIKE '%smtp%';
SELECT COUNT(*) as queue_count FROM ost_mail_queue;
SELECT COUNT(*) as failed_count FROM ost_email_log WHERE status = 'failed';
EOF
```

#### Step 4: Test Connectivity dari Container
```bash
docker exec -it osticket_web bash

# Test DNS
nslookup smtp.gmail.com

# Test port connectivity
nc -zv smtp.gmail.com 587

# Test SMTP dengan telnet
echo -e "EHLO osticket\nQUIT" | telnet smtp.gmail.com 587
```

#### Step 5: Send Test Email
```
Admin Panel → Tools → Send Test Email
- Lihat apakah email diterima
- Jika tidak, lihat error message
```

#### Step 6: Check Logs
```bash
# Di container
docker exec -it osticket_web bash
tail -f /var/log/apache2/error.log

# Trigger email (buat ticket atau balas)
# Observe error log
```

---

## PERBAIKAN KONFIGURASI EMAIL

### 📧 GMAIL SMTP Configuration

#### Persiapan Gmail:
```
1. Enable 2-Factor Authentication di Gmail account
2. Generate App Password:
   - Visit: https://myaccount.google.com/apppasswords
   - Select: Mail → Windows Computer (atau device apapun)
   - Copy generated password
3. Jangan gunakan password Gmail utama
```

#### osTicket Admin Panel Configuration:
```
Email Backend: SMTP
SMTP Host: smtp.gmail.com
SMTP Port: 587 (dengan TLS)
SMTP Authentication: Enable
SMTP Username: your-email@gmail.com
SMTP Password: [App Password dari step 2]
Use TLS/SSL: Yes
Email From Address: your-email@gmail.com
Email From Name: osTicket Support
```

#### Alternative (Port 465 - SSL Implicit):
```
SMTP Port: 465
Use TLS/SSL: Yes (IMPLICIT)
```

---

### 🔐 MICROSOFT 365 SMTP Configuration

#### Persiapan Microsoft 365:
```
1. Verify domain di Microsoft 365 Admin Center
2. Enable SMTP AUTH:
   - Exchange Admin Center → Authentication Policies
   - Enable SMTP AUTH for mailbox
3. Create App Password (jika MFA enabled)
4. Atau gunakan Microsoft 365 Connector (recommended)
```

#### osTicket Admin Panel Configuration:
```
Email Backend: SMTP
SMTP Host: smtp.office365.com
SMTP Port: 587
SMTP Authentication: Enable
SMTP Username: your-email@company.com
SMTP Password: [Microsoft 365 password atau App Password]
Use TLS/SSL: Yes (STARTTLS)
Email From Address: your-email@company.com
Email From Name: osTicket Support
```

#### Testing Connection:
```bash
# Dari container
swaks -t test@example.com \
      -f your-email@company.com \
      -s smtp.office365.com:587 \
      -au your-email@company.com \
      -ap "your-password" \
      --tls \
      -m "Test from osTicket"
```

---

### 🏢 Custom SMTP Server (Self-hosted Postfix/Exim)

#### If No Authentication:
```
SMTP Host: mail.yourdomain.com
SMTP Port: 25 (atau 587)
SMTP Authentication: Disable
```

#### If With Authentication:
```
SMTP Host: mail.yourdomain.com
SMTP Port: 587 (TLS) atau 465 (SSL)
SMTP Authentication: Enable
SMTP Username: support@yourdomain.com
SMTP Password: [password]
Use TLS/SSL: Yes
```

#### Testing:
```bash
# Test dari container
nc -zv mail.yourdomain.com 587

# Telnet test
echo -e "EHLO osticket\nQUIT" | telnet mail.yourdomain.com 587
```

---

## ENABLE DEBUG LOGGING

### Metode 1: Via Admin Panel
```
1. Admin Panel → System Settings
2. System Error Reporting: Set to "All Errors and Notices"
3. Save
```

### Metode 2: Edit ost-config.php
```php
// Di /var/www/html/include/ost-config.php
define('OSTICKET_SYSTEM_DEBUG', true);
define('OSTICKET_DEBUG_AJAX', true);
```

### Metode 3: Enable Mail Debug di PHP
```php
// Buat file /tmp/mail-debug.php
<?php
// Set mail debug
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', '/var/log/php-mail-debug.log');

// Include osTicket
require_once('/var/www/html/include/bootstrap.php');

// Create test ticket
// Or trigger email action
?>
```

### Metode 4: Docker Compose Override (Log Everything)
```yaml
# docker-compose.override.yml
version: '3.9'
services:
  web:
    environment:
      - PHP_LOG_ERRORS=On
      - PHP_ERROR_REPORTING=E_ALL
      - PHP_LOG_ERRORS_MAX_LEN=0
      - PHP_MAIL_DEBUG=1
    volumes:
      - ./logs/php-mail:/var/log/php-mail
```

### Melihat Debug Logs:
```bash
# Real-time log
docker exec -it osticket_web tail -f /var/log/apache2/error.log

# PHP-FPM log
docker exec -it osticket_web tail -f /var/log/php-fpm.log

# syslog
docker exec -it osticket_web tail -f /var/log/syslog

# Mail log (jika ada)
docker exec -it osticket_web tail -f /var/log/mail.log
```

---

## ADVANCED DEBUGGING: STEP-BY-STEP

### Scenario 1: Email tidak masuk queue sama sekali
```
Root Cause: osTicket tidak recognize sebagai email backend yang perlu dikirim

Pengecekan:
1. SELECT * FROM ost_mail_queue; (harusnya ada entries baru)
2. Lihat osTicket UI: apakah ada error saat create/reply ticket?
3. Check ost_config: email backend sudah SMTP?
```

### Scenario 2: Email di queue tapi tidak terkirim
```
Root Cause: Email cron tidak berjalan atau authentication gagal

Pengecekan:
1. SELECT * FROM ost_cron_event WHERE cron_id = (SELECT id FROM ost_cron WHERE func LIKE '%mail%');
2. Kapan terakhir mail cron jalankan?
3. Test SMTP connection dari container
4. Check SMTP credentials di database dan osTicket config
```

### Scenario 3: Connection error ke SMTP server
```
Root Cause: Network isolation Docker, DNS tidak resolve, atau port blocked

Pengecekan:
1. nslookup smtp.gmail.com (dari container)
2. nc -zv smtp.gmail.com 587
3. openssl s_client -connect smtp.gmail.com:587 -starttls smtp
4. Check Docker network: docker network inspect osticket_network
```

### Scenario 4: TLS/SSL Certificate error
```
Root Cause: openssl version tidak compatible, atau certificate expired

Pengecekan:
1. echo | openssl s_client -connect smtp.gmail.com:465
2. Check expiry date
3. Verify openssl di container: openssl version
```

---

## QUICK FIX CHECKLIST

- [ ] Verify SMTP Backend selected di Admin Panel
- [ ] Test SMTP port connectivity: `nc -zv smtp.server 587`
- [ ] Test TLS handshake: `openssl s_client -connect smtp.server:587 -starttls smtp`
- [ ] Verify DNS resolution: `nslookup smtp.server`
- [ ] Check Docker network: `docker network ls && docker network inspect osticket_network`
- [ ] Verify credentials di osTicket config
- [ ] Check ost_mail_queue table: `SELECT COUNT(*) FROM ost_mail_queue;`
- [ ] Enable debug logging di osTicket
- [ ] Check email logs: `SELECT * FROM ost_email_log WHERE status='failed';`
- [ ] Test send email dari Admin Panel
- [ ] Check Apache error log: `tail -f /var/log/apache2/error.log`
- [ ] Verify SMTP cron: `SELECT * FROM ost_cron WHERE func LIKE '%mail%';`
- [ ] For Gmail: Use App Password, not main password
- [ ] For Office365: Use smtp.office365.com:587
- [ ] If custom SMTP: Test with telnet: `telnet mail.server 587`

---

## COMMON ISSUES & SOLUTIONS

| Issue | Cause | Solution |
|-------|-------|----------|
| Connection refused | Port blocked | Use correct port (587/465), test with nc |
| Connection timeout | DNS not resolving | Inside container: nslookup smtp.server |
| TLS error | Certificate issue | Check cert: openssl s_client |
| Auth failed | Wrong credentials | Regenerate Gmail App Password |
| No emails in queue | Backend not SMTP | Change Admin Panel → Email Settings → Backend |
| Queue stuck | Cron not running | Check cron_event table |
| Port 587 times out | Docker network issue | Check Docker network connectivity |
| Can't connect from Docker | DNS resolve fail | Update Docker DNS in compose file |

---

## DOCKER COMPOSE NETWORK VERIFICATION

```bash
# Check osTicket Docker network
docker network ls
docker network inspect osticket_network

# Expected: bridge driver dengan containers osticket_web dan osticket_db

# Test connectivity dalam network
docker exec osticket_web ping osticket_db
docker exec osticket_web nslookup osticket_db

# Test external SMTP
docker exec osticket_web ping 8.8.8.8
docker exec osticket_web nslookup google.com
```

---

## REFERENSI OSTICKET 1.18.3

- osTicket Docs: https://docs.osticket.com
- Email Configuration: https://docs.osticket.com/en/latest/Getting%20Started/Email.html
- Admin Settings: https://docs.osticket.com/en/latest/User%20Management/Departments%20and%20Access%20Control/Agents.html
- Database Schema: Check ost_email, ost_mail_queue, ost_email_log tables

---

## NEXT STEPS

1. Jalankan Step 1-3 dari Troubleshooting Checklist
2. Kirim hasil:
   - osTicket Email Configuration (screenshot)
   - Database query results
   - Error logs
3. Saya akan provide solusi spesifik

