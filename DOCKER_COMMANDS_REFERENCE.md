# osTicket Email Troubleshooting - Docker Commands Reference

## QUICK ACCESS COMMANDS

### Enter Container
```bash
docker exec -it osticket_web bash
docker exec -it osticket_db bash
```

---

## CONTAINER DIAGNOSTICS

### Check Container Status
```bash
docker ps | grep osticket
docker logs osticket_web
docker logs osticket_db
```

### Check Docker Network
```bash
docker network ls
docker network inspect osticket_network
```

---

## DNS & NETWORK TESTS

### From Host Machine
```bash
# Verify containers can reach SMTP server
docker exec osticket_web nslookup smtp.gmail.com
docker exec osticket_web ping -c 3 smtp.gmail.com
```

### Test SMTP Port Connectivity
```bash
# Port 587 (TLS/STARTTLS)
docker exec osticket_web nc -zv smtp.gmail.com 587

# Port 465 (SSL/Implicit)
docker exec osticket_web nc -zv smtp.gmail.com 465

# Port 25 (Plain)
docker exec osticket_web nc -zv smtp.gmail.com 25
```

---

## PHP & APACHE CHECKS

### PHP Configuration
```bash
# Check sendmail path
docker exec osticket_web php -i | grep sendmail_path

# Check SMTP settings
docker exec osticket_web php -i | grep -E "SMTP|sendmail"

# Check PHP version
docker exec osticket_web php --version

# Check loaded extensions
docker exec osticket_web php -m | grep -E "curl|openssl|sockets"
```

### Apache Configuration
```bash
# Check Apache version
docker exec osticket_web apache2 -v

# Check enabled modules
docker exec osticket_web a2query -m | grep -E "rewrite|headers"

# View Apache error log (real-time)
docker exec osticket_web tail -f /var/log/apache2/error.log

# View Apache access log
docker exec osticket_web tail -f /var/log/apache2/access.log

# View Apache error log (last 50 lines)
docker exec osticket_web tail -50 /var/log/apache2/error.log
```

---

## SMTP CONNECTION TESTS

### Install Tools (if needed)
```bash
docker exec osticket_web bash -c "apt-get update && apt-get install -y telnet nc openssl mailutils curl"
```

### Test with netcat
```bash
# Check if port is reachable
docker exec osticket_web nc -zv smtp.gmail.com 587
docker exec osticket_web nc -zv smtp.gmail.com 465
```

### Test with telnet
```bash
# Interactive telnet test
docker exec -it osticket_web telnet smtp.gmail.com 587

# Non-interactive telnet test
docker exec osticket_web bash -c "echo -e 'EHLO osticket\\nQUIT' | telnet smtp.gmail.com 587"
```

### Test TLS/SSL Certificate
```bash
# Check certificate details (port 465 - SSL)
docker exec osticket_web openssl s_client -connect smtp.gmail.com:465 -showcerts

# Check certificate details (port 587 - STARTTLS)
docker exec osticket_web openssl s_client -connect smtp.gmail.com:587 -starttls smtp -showcerts

# Check certificate expiry
docker exec osticket_web bash -c "echo | openssl s_client -connect smtp.gmail.com:465 2>/dev/null | openssl x509 -noout -dates"
```

### Test SMTP with ssmtp
```bash
# Install ssmtp
docker exec osticket_web apt-get install -y ssmtp

# Create test config
docker exec osticket_web bash -c "cat > /tmp/test-ssmtp.conf << 'EOF'
root=your-email@gmail.com
mailhub=smtp.gmail.com:587
AuthUser=your-email@gmail.com
AuthPass=your-app-password
UseSTARTTLS=YES
EOF"

# Send test email
docker exec osticket_web bash -c "echo 'Test Body' | ssmtp -C /tmp/test-ssmtp.conf recipient@example.com"
```

### Test SMTP with swaks (Best Option)
```bash
# Install swaks
docker exec osticket_web apt-get install -y swaks

# Test Gmail SMTP
docker exec osticket_web swaks \
  -t recipient@example.com \
  -f your-email@gmail.com \
  -s smtp.gmail.com:587 \
  -au your-email@gmail.com \
  -ap "your-app-password" \
  --tls \
  -m "Test email from Docker"

# Test Office365 SMTP
docker exec osticket_web swaks \
  -t recipient@example.com \
  -f your-email@company.com \
  -s smtp.office365.com:587 \
  -au your-email@company.com \
  -ap "your-password" \
  --tls \
  -m "Test email from Docker"

# Test custom SMTP
docker exec osticket_web swaks \
  -t recipient@example.com \
  -f support@yourdomain.com \
  -s mail.yourdomain.com:587 \
  -au support@yourdomain.com \
  -ap "password" \
  --tls \
  -m "Test email from Docker"
```

---

## PHP MAIL TESTING

### Create and run PHP test script
```bash
docker exec osticket_web bash -c "cat > /tmp/test-mail.php << 'EOF'
<?php
echo \"PHP Sendmail Path: \" . ini_get('sendmail_path') . \"\\n\";
echo \"PHP SMTP: \" . ini_get('SMTP') . \"\\n\";
echo \"Testing mail() function...\\n\";

// Test basic mail
\$result = mail('test@example.com', 'Test Subject', 'Test Body', 'From: admin@osticket.local');
echo \"mail() result: \" . (\$result ? \"TRUE\" : \"FALSE\") . \"\\n\";

// Test SMTP connection
\$smtp = @fsockopen('smtp.gmail.com', 587, \$errno, \$errstr, 10);
if (\$smtp) {
    echo \"Direct SMTP Connection: SUCCESS\\n\";
    fclose(\$smtp);
} else {
    echo \"Direct SMTP Connection: FAILED (\\$errstr - \\$errno)\\n\";
}
?>
EOF

php /tmp/test-mail.php"
```

---

## DATABASE QUERIES (Direct)

### Login to MariaDB
```bash
docker exec -it osticket_db mysql -u osticket -p osticket
```

### Quick Diagnostic Query
```bash
docker exec osticket_db mysql -u osticket -posticket osticket << 'EOF'
-- Email configuration
SELECT name, value FROM ost_config WHERE name LIKE '%smtp%' LIMIT 10;

-- Queue status
SELECT COUNT(*) as queue_count FROM ost_mail_queue;

-- Failed emails
SELECT COUNT(*) as failed FROM ost_email_log WHERE status='failed';
EOF
```

### Run SQL file
```bash
docker exec osticket_db mysql -u osticket -posticket osticket < email-queries.sql
```

---

## OSTICKET CONFIGURATION FILES

### View ost-config.php
```bash
docker exec osticket_web cat /var/www/html/include/ost-config.php
```

### Check file permissions
```bash
docker exec osticket_web ls -la /var/www/html/include/ost-config.php
```

### Edit config file (inside container)
```bash
docker exec -it osticket_web vi /var/www/html/include/ost-config.php
```

---

## OSTICKET DIRECTORY & FILES

### List osTicket structure
```bash
docker exec osticket_web ls -la /var/www/html/

docker exec osticket_web find /var/www/html -name "*.php" -type f | head -20
```

### Check index.php exists
```bash
docker exec osticket_web test -f /var/www/html/index.php && echo "index.php exists" || echo "index.php MISSING"
```

### Check setup directory
```bash
docker exec osticket_web ls -la /var/www/html/setup/
```

---

## LOGS & DEBUGGING

### osTicket Include Directory
```bash
docker exec osticket_web find /var/www/html/include -name "*.log" 2>/dev/null
```

### Mail Queue Logs
```bash
docker exec osticket_web test -d /var/log/mail && ls -la /var/log/mail/ || echo "No mail log dir"
```

### System Logs
```bash
docker exec osticket_web tail -f /var/log/syslog
docker exec osticket_web tail -f /var/log/messages
```

### PHP Error Log
```bash
docker exec osticket_web tail -f /var/log/php.log 2>/dev/null || echo "No PHP log"
```

---

## MEMORY & RESOURCE USAGE

### Check container resource usage
```bash
docker stats osticket_web --no-stream
docker stats osticket_db --no-stream
```

### Check disk usage
```bash
docker exec osticket_web df -h /var/www/html
docker exec osticket_db du -sh /var/lib/mysql
```

---

## RESTART & TROUBLESHOOT

### Restart single container
```bash
docker restart osticket_web
docker restart osticket_db
```

### Restart all containers
```bash
docker-compose restart
```

### Rebuild and restart
```bash
docker-compose down
docker-compose up -d
```

### View compose logs
```bash
docker-compose logs -f osticket_web
docker-compose logs -f osticket_db
```

---

## COPY FILES IN/OUT

### Copy file from container to host
```bash
docker cp osticket_web:/var/log/apache2/error.log ./error.log
docker cp osticket_web:/var/www/html/include/ost-config.php ./ost-config-backup.php
```

### Copy file from host to container
```bash
docker cp ./config-update.php osticket_web:/var/www/html/include/
```

---

## EXECUTE CUSTOM COMMANDS

### Run multiple commands
```bash
docker exec osticket_web bash -c "apt-get update && apt-get install -y package_name"
```

### Run with pipes
```bash
docker exec osticket_web bash -c "ps aux | grep apache"
docker exec osticket_web bash -c "find /var/www -name '*.php' | wc -l"
```

---

## BACKUP & DIAGNOSTICS

### Create backup of database
```bash
docker exec osticket_db mysqldump -u osticket -posticket osticket > osticket-backup.sql
```

### Create tar of entire web root
```bash
docker exec osticket_web tar -czf /tmp/osticket-backup.tar.gz /var/www/html
docker cp osticket_web:/tmp/osticket-backup.tar.gz ./osticket-backup.tar.gz
```

### Generate diagnostic dump
```bash
docker exec osticket_web bash -c "echo '===== PHP INFO =====' && php -i && echo '===== COMPOSER =====' && php -m" > diagnostic.log
```

---

## QUICK TROUBLESHOOTING WORKFLOW

### 1. Check containers running
```bash
docker ps | grep osticket
```

### 2. Check logs for errors
```bash
docker-compose logs osticket_web | tail -50
docker-compose logs osticket_db | tail -50
```

### 3. Test basic connectivity
```bash
docker exec osticket_web ping osticket_db
docker exec osticket_web nslookup smtp.gmail.com
```

### 4. Test SMTP port
```bash
docker exec osticket_web nc -zv smtp.gmail.com 587
```

### 5. Query database
```bash
docker exec osticket_db mysql -u osticket -posticket osticket -e "SELECT COUNT(*) FROM ost_mail_queue;"
```

### 6. Check osTicket config
```bash
docker exec osticket_web grep -i smtp /var/www/html/include/ost-config.php
```

### 7. Run PHP test
```bash
docker exec osticket_web php -i | grep -E "sendmail|SMTP"
```

