# osTicket SMTP Configuration Guides

## GMAIL SMTP Setup (Recommended for Testing)

### Prerequisites:
- Gmail account
- 2-Factor Authentication enabled (required for App Passwords)

### Step 1: Enable 2-Factor Authentication
1. Visit: https://myaccount.google.com/security
2. Under "How you sign in to Google", select "2-Step Verification"
3. Follow the setup wizard
4. Verify phone number with code

### Step 2: Generate App Password
1. After 2FA is enabled, visit: https://myaccount.google.com/apppasswords
2. Select:
   - App: "Mail"
   - Device: "Windows Computer" (or your device)
3. Click "Generate"
4. Copy the 16-character password (without spaces)
5. Keep this safe - you'll need it for osTicket

### Step 3: Configure osTicket
1. Login to osTicket Admin Panel
2. Navigate: **Admin Panel → Settings → Email Settings**
3. Configure:

```
Email Backend:          SMTP
SMTP Host:             smtp.gmail.com
SMTP Port:             587
SMTP Authentication:   ✓ (checked)
SMTP Username:         your-email@gmail.com
SMTP Password:         [16-char App Password from step 2]
Use TLS/SSL:           ✓ Yes (STARTTLS)
Email From Address:    your-email@gmail.com
Email From Name:       osTicket Support Team
```

4. Click "Send Test Email"
5. Check if you receive test email

### Step 4: Verify Configuration
```bash
# From host, run:
docker exec osticket_web swaks \
  -t your-email@gmail.com \
  -f your-email@gmail.com \
  -s smtp.gmail.com:587 \
  -au your-email@gmail.com \
  -ap "your-app-password" \
  --tls \
  -m "Test from osTicket Docker"
```

### Troubleshooting Gmail:

| Issue | Solution |
|-------|----------|
| "Invalid credentials" | Regenerate App Password, make sure using 16-char password |
| "Connection refused" | Check port 587 is reachable: `nc -zv smtp.gmail.com 587` |
| "TLS error" | Use port 587 (not 465), keep "Use TLS/SSL" checked |
| "No emails received" | Check inbox spam folder, verify From address |
| "2FA not enabled" | App Passwords won't work without 2FA |

---

## MICROSOFT 365 SMTP Setup

### Prerequisites:
- Microsoft 365 account (Business, Enterprise, or Premium)
- Domain verified in Microsoft 365 Admin Center
- Optional: Multi-Factor Authentication

### Step 1: Enable SMTP Authentication (If needed)
1. Login to Exchange Admin Center: https://admin.exchange.microsoft.com
2. Navigate: **Mail Flow → SMTP Relay**
3. Click "New SMTP relay"
4. Configure:
   - Relay through specific IP addresses
   - Or allow all IPs (less secure)
5. Save

Alternative: Contact Microsoft 365 support to enable SMTP AUTH on your mailbox.

### Step 2: Create App Password (If MFA enabled)
1. Visit: https://account.microsoft.com/security
2. Under "Security settings", select "App passwords"
3. Select "Mail" and "Other device"
4. Copy generated password
5. Use this password in osTicket

### Step 3: Configure osTicket
1. Login to osTicket Admin Panel
2. Navigate: **Admin Panel → Settings → Email Settings**
3. Configure:

```
Email Backend:          SMTP
SMTP Host:             smtp.office365.com
SMTP Port:             587
SMTP Authentication:   ✓ (checked)
SMTP Username:         your-email@company.com
SMTP Password:         [Your Office 365 password or App Password]
Use TLS/SSL:           ✓ Yes (STARTTLS)
Email From Address:    your-email@company.com
Email From Name:       osTicket Support Team
```

4. Click "Send Test Email"
5. Check your Inbox

### Step 4: Verify Configuration
```bash
# From host, run:
docker exec osticket_web swaks \
  -t your-email@company.com \
  -f your-email@company.com \
  -s smtp.office365.com:587 \
  -au your-email@company.com \
  -ap "your-password" \
  --tls \
  -m "Test from osTicket Docker"
```

### Microsoft 365 Connector (Advanced - Recommended for Production)

If you prefer not to use SMTP authentication, use Microsoft 365 Connector:

1. Install Microsoft Connector for osTicket (if available)
2. Or use Graph API integration
3. Setup OAuth2 authentication
4. Configure email sync through API

**Benefits:**
- More secure (no password storage)
- Built-in compliance
- Better email sync

**Drawbacks:**
- More complex setup
- May require development

---

## Custom SMTP Server Setup (Self-Hosted)

### Prerequisites:
- Access to your own SMTP server
- Server hostname/IP
- SMTP port (usually 25, 587, or 465)
- Authentication credentials (if required)

### Configuration Steps:

#### Scenario 1: No Authentication (Open Relay)
```
Email Backend:          SMTP
SMTP Host:             mail.yourdomain.com
SMTP Port:             25
SMTP Authentication:   ☐ (unchecked)
Use TLS/SSL:           ☐ (unchecked)
Email From Address:    support@yourdomain.com
Email From Name:       osTicket Support
```

#### Scenario 2: With Authentication (TLS)
```
Email Backend:          SMTP
SMTP Host:             mail.yourdomain.com
SMTP Port:             587
SMTP Authentication:   ✓ (checked)
SMTP Username:         support@yourdomain.com
SMTP Password:         [server password]
Use TLS/SSL:           ✓ Yes (STARTTLS)
Email From Address:    support@yourdomain.com
Email From Name:       osTicket Support
```

#### Scenario 3: With Authentication (SSL)
```
Email Backend:          SMTP
SMTP Host:             mail.yourdomain.com
SMTP Port:             465
SMTP Authentication:   ✓ (checked)
SMTP Username:         support@yourdomain.com
SMTP Password:         [server password]
Use TLS/SSL:           ✓ Yes (Implicit SSL)
Email From Address:    support@yourdomain.com
Email From Name:       osTicket Support
```

### Testing Custom SMTP:
```bash
# Test connectivity
docker exec osticket_web nc -zv mail.yourdomain.com 587

# Test with telnet
docker exec osticket_web bash -c "echo -e 'EHLO osticket\\nQUIT' | telnet mail.yourdomain.com 587"

# Test with swaks
docker exec osticket_web swaks \
  -t admin@yourdomain.com \
  -f support@yourdomain.com \
  -s mail.yourdomain.com:587 \
  -au support@yourdomain.com \
  -ap "password" \
  --tls \
  -m "Test email"
```

---

## GMAIL vs OFFICE365 vs CUSTOM COMPARISON

| Feature | Gmail | Office365 | Custom |
|---------|-------|-----------|--------|
| Setup Difficulty | Easy | Medium | Hard |
| Security | High (App Password) | High | Depends |
| Cost | Free | Paid | Variable |
| SMTP Host | smtp.gmail.com | smtp.office365.com | Your server |
| Port | 587 | 587 | 25/587/465 |
| Auth Required | Yes (2FA + App Pass) | Yes (Password or MFA) | Maybe |
| TLS Support | Yes | Yes | Maybe |
| Best For | Testing/Small | Enterprise | Large Scale |
| Reliability | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |

---

## EMAIL TROUBLESHOOTING PER PROVIDER

### Gmail Issues:

**"Invalid credentials (535)"**
- Solution: Regenerate App Password, ensure using 16-char version
- Don't use main Gmail password

**"TLS required (220)"**
- Solution: Use port 587, ensure "Use TLS/SSL" is checked

**"Connection refused (111)"**
- Solution: Verify port 587 accessible: `nc -zv smtp.gmail.com 587`

**"Connection timeout (110)"**
- Solution: Check Docker network, verify DNS resolution

### Office365 Issues:

**"Invalid credentials (535)"**
- Solution: Verify email format (user@company.com), check password
- If MFA enabled, use App Password

**"Service not available (421)"**
- Solution: Retry, Office365 may be temporarily unavailable

**"TLS handshake failed"**
- Solution: Ensure port 587, verify certificate with openssl

**"Domain not verified"**
- Solution: Verify domain in Microsoft 365 Admin Center

### Custom SMTP Issues:

**"Connection refused (111)"**
- Solution: Verify server IP/hostname, test connectivity from Docker container

**"Invalid credentials (535)"**
- Solution: Verify username/password, check authentication method

**"Timeout (110)"**
- Solution: Verify network access, check firewall rules on SMTP server

---

## GMAIL SECURITY NOTES

⚠️ **IMPORTANT:**
1. Never use your main Gmail password in osTicket
2. Always generate App Password for security
3. App Password is only for SMTP, not for web login
4. Can revoke App Password anytime in Google Account settings
5. 2FA must be enabled to generate App Password

### Revoking App Password:
1. Visit: https://myaccount.google.com/apppasswords
2. Select the app/device
3. Click "Delete"
4. Password immediately stops working

---

## OFFICE365 SECURITY NOTES

⚠️ **IMPORTANT:**
1. If MFA enabled, must use App Password (not main password)
2. Consider enabling SMTP authentication restrictions
3. Monitor SMTP authentication attempts in audit logs
4. Regular password rotation recommended
5. Consider using OAuth2 for production environments

### Checking SMTP Logs:
1. Exchange Admin Center → Mail Flow → Connectors
2. View authentication attempts
3. Monitor for suspicious activity

---

## TESTING AFTER CONFIGURATION

### Test 1: osTicket UI Test
```
1. Login to Admin Panel
2. Go to: Settings → Email Settings
3. Click: "Send Test Email"
4. Check your inbox for test email
5. Expected: Email within 30 seconds
```

### Test 2: Create Ticket Test
```
1. Go to customer portal (http://localhost:8080)
2. Create new ticket
3. Use your email as customer email
4. Check inbox for ticket confirmation
5. Expected: Email within 1 minute
```

### Test 3: Admin Reply Test
```
1. Login as admin
2. View ticket from test 2
3. Reply to ticket
4. Check inbox for reply notification
5. Expected: Email within 1 minute
```

### Test 4: Command Line Test
```bash
docker exec osticket_web swaks \
  -t test@gmail.com \
  -f your-smtp-email@gmail.com \
  -s smtp.gmail.com:587 \
  -au your-smtp-email@gmail.com \
  -ap "your-app-password" \
  --tls \
  -m "Command line test from osTicket Docker"
```

### Test 5: Database Test
```bash
docker exec osticket_db mysql -u osticket -posticket osticket -e \
  "SELECT COUNT(*) as sent FROM ost_email_log WHERE status='sent';"
```

---

## COMMON MISTAKES TO AVOID

❌ **Don't:**
- Use Gmail main password (use App Password instead)
- Forget to enable 2FA for Gmail (required for App Password)
- Use port 25 with TLS enabled (port should be 587/465)
- Leave SMTP authentication unchecked when server requires it
- Use incorrect email format (must be valid email address)
- Forget to save configuration after entering credentials

✅ **Do:**
- Use App Password for Gmail (not main password)
- Verify port 587 is reachable from Docker container
- Test with swaks command after configuration
- Check osTicket email queue (ost_mail_queue table)
- Enable debug logging if emails not sending
- Monitor osTicket system logs for errors
- Use password managers for storing SMTP passwords securely

---

## MONITORING & MAINTENANCE

### Regular Checks:
```bash
# Weekly: Check failed emails
docker exec osticket_db mysql -u osticket -posticket osticket -e \
  "SELECT COUNT(*) as failed FROM ost_email_log WHERE status='failed' AND created > DATE_SUB(NOW(), INTERVAL 7 DAY);"

# Monthly: Check credentials still valid
# Try sending test email from admin panel

# Quarterly: Review SMTP logs
docker exec osticket_db mysql -u osticket -posticket osticket -e \
  "SELECT status, COUNT(*) FROM ost_email_log WHERE created > DATE_SUB(NOW(), INTERVAL 90 DAY) GROUP BY status;"
```

### Alerting:
Consider setting up alerts for:
- Failed email count exceeding threshold
- SMTP authentication failures
- Queue size growing unexpectedly
- Certificate expiration (for Office365/Gmail)

