# osTicket Email Troubleshooting - Action Plan
## Step-by-Step Investigation & Fix

---

## EXECUTIVE SUMMARY

**Problem:** osTicket emails not being sent to customers
**Symptoms:**
- ✓ Tickets created successfully
- ✓ Admin replies successful
- ✗ No customer notifications
- ✓ No UI errors
- ✓ All PHP extensions present

**Most Likely Causes (Probability):**
1. **SMTP not configured or disabled (70%)**
2. **SMTP authentication credentials wrong (60%)**
3. **Network connectivity from Docker to SMTP (50%)**
4. **Email queue disabled or cron not running (40%)**
5. **TLS/SSL certificate issues (30%)**

---

## PHASE 1: QUICK DIAGNOSTICS (5-10 Minutes)

### Action 1.1: Check osTicket Email Backend Selection
```
WHERE: osTicket Admin Panel
HOW:
1. Login as admin
2. Go: Admin Panel → Settings → Email Settings (or Email Configuration)
3. CHECK: Is "Email Backend" set to "SMTP"?
   - If set to "PHP Mail" → This is likely the problem!
   - Change to "SMTP" and Save

SCREENSHOT: Save this screen showing current settings
```

### Action 1.2: Check SMTP Configuration Exists
```
WHERE: osTicket Admin Panel
HOW:
1. In same Email Settings page
2. CHECK: Are these fields filled?
   - SMTP Host: [should be smtp.gmail.com or your server]
   - SMTP Port: [should be 587 or 465]
   - SMTP Username: [should be email address]
   - SMTP Password: [should be asterisks if set]
   - Use TLS/SSL: [should be checked]

IF ANY EMPTY → Fill in Gmail or Office365 credentials
→ See: SMTP_CONFIGURATION_GUIDES.md
```

### Action 1.3: Send Test Email
```
WHERE: osTicket Admin Panel → Email Settings
HOW:
1. Click "Send Test Email" button
2. Check your email inbox within 30 seconds
3. If test email received:
   → Configuration is probably OK
   → Problem is likely queue/cron related
4. If test email NOT received:
   → Configuration is probably wrong
   → Continue investigation

RESULT: Screenshot of test email response
```

---

## PHASE 2: VERIFY DOCKER CONNECTIVITY (10-15 Minutes)

### Action 2.1: Test DNS Resolution from Container
```bash
COMMAND: docker exec osticket_web nslookup smtp.gmail.com

EXPECTED OUTPUT:
Server:         127.0.0.11
Address:        127.0.0.11#53
Name:   smtp.gmail.com
Address: 142.251.41.109

ISSUES:
- "No response from X.X.X.X" → Docker DNS problem
- "NXDOMAIN" → DNS not resolving in container
- No address → Docker can't reach external DNS
```

### Action 2.2: Test Port Connectivity
```bash
COMMAND: docker exec osticket_web nc -zv smtp.gmail.com 587

EXPECTED OUTPUT:
Connection to smtp.gmail.com 587 port [tcp/submission] succeeded!

ISSUES:
- "Connection refused" → Port not open
- "Connection timeout" → Firewall blocking
- "No such file" → Install netcat: 
  docker exec osticket_web apt-get install -y netcat-openbsd
```

### Action 2.3: Test TLS Handshake
```bash
COMMAND: docker exec osticket_web bash -c \
  "echo | openssl s_client -connect smtp.gmail.com:587 -starttls smtp 2>/dev/null | head -5"

EXPECTED OUTPUT:
Should show connection and certificate info

ISSUES:
- "Connection refused" → Network problem
- "TLS protocol error" → Certificate issue
- Hangs → Try with timeout: nc -zv smtp.gmail.com 587
```

---

## PHASE 3: DATABASE VERIFICATION (5 Minutes)

### Action 3.1: Check Email Configuration in Database
```bash
COMMAND:
docker exec osticket_db mysql -u osticket -posticket osticket << 'EOF'
SELECT name, value FROM ost_config WHERE name LIKE '%smtp%';
EOF

EXPECTED OUTPUT:
Should see rows like:
- email.smtp.host: smtp.gmail.com
- email.smtp.port: 587
- email.smtp.auth: 1
- email.smtp.user: your-email@gmail.com
- email.smtp.pass: [encrypted]

ISSUES:
- Empty result → SMTP not configured in database
- Wrong host/port → Update in Admin Panel
```

### Action 3.2: Check Email Queue
```bash
COMMAND:
docker exec osticket_db mysql -u osticket -posticket osticket << 'EOF'
SELECT COUNT(*) as queue_count FROM ost_mail_queue;
SELECT COUNT(*) as failed FROM ost_email_log WHERE status='failed';
EOF

EXPECTED OUTPUT:
- queue_count: Should be 0 or low number (< 10)
- failed: Should be 0

ISSUES:
- queue_count: HIGH (100+) → Emails stuck, not being sent
- failed: HIGH (100+) → Many failed attempts
```

### Action 3.3: Check Cron Job Status
```bash
COMMAND:
docker exec osticket_db mysql -u osticket -posticket osticket << 'EOF'
SELECT * FROM ost_cron WHERE func LIKE '%mail%';
EOF

EXPECTED OUTPUT:
Should show entry for mail cron with active=1

ISSUES:
- No result → Mail cron not registered
- active=0 → Mail cron disabled
```

---

## PHASE 4: ENABLE DEBUG LOGGING (5 Minutes)

### Action 4.1: Enable osTicket Debug Mode
```
WHERE: osTicket Admin Panel
HOW:
1. Go: Admin Panel → System Settings
2. Find: "System Error Reporting"
3. Change to: "All Errors and Notices"
4. Save

ALSO (if available):
1. Go: Admin Panel → Email Settings
2. Check: "Enable Email Debug" (if option exists)
3. Save
```

### Action 4.2: Check Error Logs
```bash
COMMAND: docker exec osticket_web tail -100 /var/log/apache2/error.log

LOOK FOR:
- PHP errors related to mail/SMTP
- Connection errors to SMTP server
- Authentication failures

REPORT: Copy any relevant error messages
```

---

## PHASE 5: TRIGGER AND OBSERVE (10-15 Minutes)

### Action 5.1: Trigger Test Email Send
```
WHERE: osTicket Admin Panel
HOW:
1. Go: Settings → Email Settings
2. Click: "Send Test Email" button
3. IMMEDIATELY check error log:
   docker exec osticket_web tail -f /var/log/apache2/error.log
4. Watch for errors as test email is attempted
5. Check inbox within 30 seconds

CAPTURE: Error messages if email fails
```

### Action 5.2: Create Test Ticket
```
WHERE: osTicket Customer Portal
HOW:
1. Go to: http://localhost:8080 (or your osTicket URL)
2. Click: "Open a new ticket"
3. Fill form:
   - Name: Test User
   - Email: your-email@gmail.com
   - Department: Support
   - Subject: Test Email
   - Message: Testing email notifications
4. Submit ticket
5. Check inbox within 1 minute for customer confirmation

CAPTURE:
- Screenshot of ticket created in admin
- Check if confirmation email received
```

### Action 5.3: Admin Reply and Observe
```
WHERE: osTicket Admin Panel
HOW:
1. Login as admin
2. Go to: Support → Tickets → Find test ticket from 5.2
3. Click ticket to open
4. Scroll down to "Reply"
5. Type: "This is a test reply to check email notifications"
6. Click: "Post Reply"
7. Check inbox within 1 minute for update notification

CAPTURE:
- Screenshot of reply posted
- Check if customer received email update
- Check error logs for any errors
```

---

## PHASE 6: COMPREHENSIVE DIAGNOSIS (Optional, if previous steps inconclusive)

### Action 6.1: Run Full Diagnostic Script
```bash
# Create diagnostic script
COMMAND: chmod +x diagnose-email.sh && ./diagnose-email.sh

RESULT:
Saves all diagnostic outputs to console
Review each section for errors or unexpected values
```

### Action 6.2: Run SQL Query Batch
```bash
COMMAND: docker exec osticket_db mysql -u osticket -posticket osticket < email-queries.sql

RESULT:
Comprehensive view of email configuration and history
Look for missing SMTP config or high failed count
```

### Action 6.3: Test SMTP Directly with swaks
```bash
# Install swaks if needed
docker exec osticket_web apt-get install -y swaks

# Test Gmail
COMMAND:
docker exec osticket_web swaks \
  -t your-email@gmail.com \
  -f your-email@gmail.com \
  -s smtp.gmail.com:587 \
  -au your-email@gmail.com \
  -ap "your-app-password" \
  --tls \
  -m "Test from Docker osTicket"

EXPECTED: Email arrives within 10 seconds
```

---

## PHASE 7: IMPLEMENTATION OF FIX

### If Problem is: SMTP Backend Not Selected
```
FIX:
1. Admin Panel → Settings → Email Settings
2. Change "Email Backend" from "PHP Mail" to "SMTP"
3. Enter SMTP configuration:
   Host: smtp.gmail.com
   Port: 587
   Auth: Checked
   Username: your-email@gmail.com
   Password: [App Password from Gmail]
   TLS: Checked
4. Click "Send Test Email"
5. Save
6. Create test ticket to verify

EXPECTED: Test email arrives within 30 seconds
```

### If Problem is: SMTP Credentials Wrong
```
FIX:
1. Go to Gmail/Office365/your SMTP provider
2. Verify credentials:
   - Email address correct? (must be full address)
   - Password correct? (for Gmail, use App Password, not main password)
   - For Gmail: Must have 2FA enabled
3. Update in osTicket Admin Panel
4. Test with "Send Test Email"
5. If still fails, check email logs:
   docker exec osticket_db mysql -u osticket -posticket osticket -e \
   "SELECT * FROM ost_email_log WHERE status='failed' LIMIT 5;"

EXPECTED: Connection succeeds, email arrives
```

### If Problem is: Network/Port Not Reachable
```
FIX:
1. Verify Docker network is working:
   docker exec osticket_web ping osticket_db
   docker exec osticket_web nslookup smtp.gmail.com

2. If DNS fails, update docker-compose.yml:
   networks:
     osticket_network:
       driver: bridge
       driver_opts:
         com.docker.network.driver.mtu: 1450

3. Rebuild:
   docker-compose down
   docker-compose up -d

4. Test again:
   docker exec osticket_web nc -zv smtp.gmail.com 587

EXPECTED: Connection to port 587 succeeds
```

### If Problem is: Email Queue Disabled or Stuck
```
FIX:
1. Check queue status:
   docker exec osticket_db mysql -u osticket -posticket osticket -e \
   "SELECT * FROM ost_mail_queue LIMIT 10;"

2. Check cron status:
   docker exec osticket_db mysql -u osticket -posticket osticket -e \
   "SELECT * FROM ost_cron WHERE func LIKE '%mail%';"

3. Enable cron if disabled:
   docker exec osticket_db mysql -u osticket -posticket osticket -e \
   "UPDATE ost_cron SET active=1 WHERE func LIKE '%mail%';"

4. Clear failed queue (if stuck):
   docker exec osticket_db mysql -u osticket -posticket osticket -e \
   "DELETE FROM ost_mail_queue WHERE status='failed' AND created < DATE_SUB(NOW(), INTERVAL 1 DAY);"

5. Trigger new test ticket

EXPECTED: Emails process and send within 1-2 minutes
```

---

## TROUBLESHOOTING TREE

```
START: Are emails being sent?
│
├─ YES → Configuration is working
│  └─ Go to: Email Queue Analysis
│
└─ NO → Email not configured or failing
   │
   ├─ [1] Test osTicket "Send Test Email"
   │  ├─ Works → Problem is with ticket creation email trigger
   │  │  └─ Check: Admin Panel → Automation → Rules
   │  │  └─ Check: Email templates are assigned
   │  │  └─ Check: Department has alert email set
   │  │
   │  └─ Fails → Problem is with SMTP configuration
   │     │
   │     ├─ [2] Check SMTP credentials
   │     │  ├─ Wrong → Update credentials
   │     │  └─ Correct → Continue
   │     │
   │     ├─ [3] Test Docker connectivity
   │     │  ├─ DNS fails → Docker network issue
   │     │  ├─ Port blocked → Firewall issue
   │     │  └─ Works → Continue
   │     │
   │     └─ [4] Test SMTP directly
   │        ├─ Works → osTicket configuration issue
   │        │  └─ Check: Admin Panel Email Settings
   │        │  └─ Check: Database ost_config for correct values
   │        │
   │        └─ Fails → External SMTP server issue
   │           └─ Check: SMTP provider status
   │           └─ Check: Firewall/Network blocking
   │           └─ Check: Certificate/TLS version compatibility
```

---

## CHECKPOINT CHECKLIST

- [ ] **Phase 1:** Email backend = SMTP
- [ ] **Phase 1:** SMTP host/port/credentials filled in
- [ ] **Phase 1:** Test email sent successfully
- [ ] **Phase 2:** DNS resolution works (nslookup smtp.gmail.com)
- [ ] **Phase 2:** Port 587 or 465 reachable (nc -zv)
- [ ] **Phase 2:** TLS handshake successful (openssl s_client)
- [ ] **Phase 3:** Database shows SMTP config (SELECT ... ost_config)
- [ ] **Phase 3:** Email queue not stuck (< 10 items)
- [ ] **Phase 3:** Failed count low (< 5)
- [ ] **Phase 3:** Mail cron active = 1
- [ ] **Phase 4:** Debug logging enabled
- [ ] **Phase 5:** Test email received
- [ ] **Phase 5:** Test ticket received by customer
- [ ] **Phase 5:** Admin reply received by customer
- [ ] **Phase 6:** swaks test successful (if run)
- [ ] **Phase 7:** Applied fix for identified issue
- [ ] **Final:** New test ticket triggers customer email

---

## EXPECTED TIMELINE

| Phase | Time | Status |
|-------|------|--------|
| 1. Quick Diagnostics | 5-10 min | Read UI settings |
| 2. Docker Connectivity | 10-15 min | Run commands |
| 3. Database Check | 5 min | Query DB |
| 4. Debug Logging | 5 min | Enable + check logs |
| 5. Trigger & Observe | 10-15 min | Test + screenshot |
| 6. Comprehensive Diagnosis | 15-30 min | (Optional) Run scripts |
| 7. Implement Fix | 10-20 min | Apply changes + test |
| **TOTAL** | **60-95 minutes** | **Full resolution** |

---

## NEXT STEPS

### If Phase 1-3 Complete:
1. Document all findings
2. Note which phase identified the issue
3. Go to Phase 7 for fix implementation
4. Re-test after each fix

### If Phase 5 Shows Everything Working:
1. osTicket email configuration is correct
2. Problem may be automation rule related
3. Check: Admin Panel → Automation → Rules
4. Check: Email templates and alerts assigned to departments

### If Phase 6-7 Needed:
1. Run full diagnostic script
2. Compare output with troubleshooting guide
3. Implement suggested fixes
4. Re-test after each change

### Documentation:
1. Save this action plan with your findings
2. Document which fix resolved the issue
3. For future reference, note the exact steps that worked
4. Consider creating a runbook for your specific environment

