#!/bin/bash
# osTicket Email Troubleshooting - Quick Commands
# Run each command one by one and report results

echo "================================"
echo "osTicket v1.18.3 Email Diagnosis"
echo "================================"
echo ""

# Enter container
CONTAINER="osticket_web"
DB_CONTAINER="osticket_db"

echo "[1] DOCKER CONTAINER STATUS"
echo "================================"
docker ps | grep osticket
echo ""

echo "[2] TEST DNS RESOLUTION SMTP GMAIL"
echo "================================"
docker exec $CONTAINER nslookup smtp.gmail.com 2>&1 | head -10
echo ""

echo "[3] TEST PORT CONNECTIVITY SMTP.GMAIL.COM:587"
echo "================================"
docker exec $CONTAINER nc -zv smtp.gmail.com 587 2>&1
echo ""

echo "[4] TEST PORT CONNECTIVITY SMTP.GMAIL.COM:465"
echo "================================"
docker exec $CONTAINER nc -zv smtp.gmail.com 465 2>&1
echo ""

echo "[5] CHECK PHP SENDMAIL CONFIGURATION"
echo "================================"
docker exec $CONTAINER php -i | grep -E "sendmail_path|SMTP|sendmail_from"
echo ""

echo "[6] VERIFY OSTICKET FILES"
echo "================================"
docker exec $CONTAINER ls -la /var/www/html/include/ost-config.php
echo ""

echo "[7] CHECK APACHE ERROR LOG (Last 20 lines)"
echo "================================"
docker exec $CONTAINER tail -20 /var/log/apache2/error.log
echo ""

echo "[8] DATABASE - EMAIL CONFIGURATION"
echo "================================"
docker exec $DB_CONTAINER mysql -u osticket -posticket osticket -e \
  "SELECT name, value FROM ost_config WHERE name LIKE '%email%' OR name LIKE '%smtp%' LIMIT 20;"
echo ""

echo "[9] DATABASE - MAIL QUEUE COUNT"
echo "================================"
docker exec $DB_CONTAINER mysql -u osticket -posticket osticket -e \
  "SELECT COUNT(*) as queue_count FROM ost_mail_queue;"
echo ""

echo "[10] DATABASE - FAILED EMAILS"
echo "================================"
docker exec $DB_CONTAINER mysql -u osticket -posticket osticket -e \
  "SELECT id, email, subject, status, created FROM ost_email_log WHERE status='failed' LIMIT 10;"
echo ""

echo "[11] DATABASE - CRON STATUS"
echo "================================"
docker exec $DB_CONTAINER mysql -u osticket -posticket osticket -e \
  "SELECT * FROM ost_cron WHERE func LIKE '%mail%';"
echo ""

echo "[12] DATABASE - CRON LAST EXECUTION"
echo "================================"
docker exec $DB_CONTAINER mysql -u osticket -posticket osticket -e \
  "SELECT * FROM ost_cron_event LIMIT 10 ORDER BY exec_time DESC;"
echo ""

echo "================================"
echo "Diagnosis Complete!"
echo "================================"
echo ""
echo "Next steps:"
echo "1. Review all outputs above"
echo "2. Check if SMTP configuration exists in database output [8]"
echo "3. Check if port 587 and 465 are reachable [3-4]"
echo "4. Check queue and failed emails [9-10]"
echo "5. Review email troubleshooting guide: OSTICKET_EMAIL_TROUBLESHOOTING.md"
