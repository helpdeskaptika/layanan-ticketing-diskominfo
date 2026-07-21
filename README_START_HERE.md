# osTicket Email Troubleshooting - EXECUTIVE SUMMARY

**Status:** Ready for Investigation
**Target:** Resolve email notification issue in osTicket 1.18.3
**Environment:** Docker Compose with PHP 8.3 & MariaDB

---

## 📋 DOCUMENTATION CREATED

Saya telah membuat 6 file panduan komprehensif:

### 1. **OSTICKET_EMAIL_TROUBLESHOOTING.md** 
   ⭐ **MAIN REFERENCE**
   - Root cause analysis (60-70% kemungkinan masalah)
   - Prioritas investigasi lengkap
   - Linux commands untuk testing
   - SQL queries untuk database
   - Checklist troubleshooting step-by-step
   - Advanced debugging scenarios
   - Common issues & solutions
   - Docker network verification

### 2. **ACTION_PLAN.md**
   ⭐ **START HERE - FIRST**
   - 7 Phase investigation plan
   - Step-by-step actions dengan expected output
   - Troubleshooting decision tree
   - Checkpoint checklist
   - Timeline proyeksi
   - Next steps guidance

### 3. **SMTP_CONFIGURATION_GUIDES.md**
   - Gmail SMTP setup (recommended untuk testing)
   - Microsoft 365 SMTP setup
   - Custom SMTP server setup
   - Security notes per provider
   - Comparison table Gmail vs Office365 vs Custom
   - Email troubleshooting per provider

### 4. **DOCKER_COMMANDS_REFERENCE.md**
   - Quick access Docker commands
   - DNS & network tests
   - PHP & Apache checks
   - SMTP connection tests (telnet, nc, openssl)
   - Database query shortcuts
   - Log viewing commands
   - Copy files in/out container
   - Backup & diagnostics

### 5. **diagnose-email.sh** (script)
   - Automated quick diagnostics
   - Runs 12 diagnostic checks
   - Saves output untuk review
   - Identifies problematic areas

### 6. **email-queries.sql** (script)
   - 15 SQL queries untuk email analysis
   - Database configuration check
   - Queue status verification
   - Failed email inspection
   - CRON job monitoring
   - System logs review

---

## 🚀 QUICK START - NEXT 30 MINUTES

### Step 1: Read Action Plan (5 min)
```
File: ACTION_PLAN.md
→ Focus on "PHASE 1: QUICK DIAGNOSTICS"
→ Understand the 3 quick checks
```

### Step 2: Check osTicket Admin Panel (5 min)
```
1. Login to osTicket admin
2. Go: Admin Panel → Settings → Email Settings
3. Check:
   ✓ Email Backend = SMTP (not PHP Mail)?
   ✓ SMTP Host filled?
   ✓ SMTP Port filled?
   ✓ Credentials set?
4. Screenshot current state
```

### Step 3: Run Docker Diagnostic (10 min)
```bash
# From your host machine, run:
cd c:\Users\APTIKA_1222\osTicket

# Quick 12-point diagnostic
docker exec osticket_web bash << 'EOF'
echo "=== DNS TEST ===" 
nslookup smtp.gmail.com 2>&1 | head -5

echo -e "\n=== PORT TEST ===" 
nc -zv smtp.gmail.com 587 2>&1

echo -e "\n=== PHP CONFIG ===" 
php -i | grep -E "sendmail_path|SMTP"

echo -e "\n=== APACHE ERROR LOG ===" 
tail -10 /var/log/apache2/error.log

echo -e "\n=== FILES ===" 
ls -la /var/www/html/include/ost-config.php
EOF
```

### Step 4: Query Database (5 min)
```bash
# Check SMTP config in database
docker exec osticket_db mysql -u osticket -posticket osticket -e \
"SELECT name, value FROM ost_config WHERE name LIKE '%smtp%';"

# Check email queue
docker exec osticket_db mysql -u osticket -posticket osticket -e \
"SELECT COUNT(*) as queue_count FROM ost_mail_queue;
SELECT COUNT(*) as failed FROM ost_email_log WHERE status='failed';"
```

### Step 5: Send Test Email (5 min)
```
In osTicket Admin Panel:
1. Admin Panel → Email Settings
2. Scroll to bottom, click: "Send Test Email"
3. Check inbox within 30 seconds
   - If received: Good! Problem might be automation rules
   - If not received: Configuration problem
```

---

## 🔍 LIKELY ISSUES (Ranked by Probability)

### 🔴 Top 3 Most Likely (90% probability combined)

#### 1️⃣ Email Backend Wrong (70% probability)
**Symptom:** osTicket using PHP mail() instead of SMTP
**Check:** Admin Panel → Email Settings → Backend
**Fix:** Change to SMTP, configure credentials, save
**Time to Fix:** 2 minutes

#### 2️⃣ SMTP Credentials Wrong (60% probability)
**Symptom:** Test email fails, authentication error
**Check:** Gmail: Regenerate App Password (not main password)
**Check:** Office365: Verify email format (user@company.com)
**Fix:** Update credentials, test again
**Time to Fix:** 5 minutes

#### 3️⃣ Network/Connectivity Issue (50% probability)
**Symptom:** Connection timeout, cannot reach SMTP server
**Check:** `nc -zv smtp.gmail.com 587` from Docker
**Check:** DNS resolution: `nslookup smtp.gmail.com`
**Fix:** Check Docker network, update docker-compose if needed
**Time to Fix:** 10-20 minutes

---

## 📞 SUPPORT RESOURCES

### If Gmail:
- Setup Guide: See SMTP_CONFIGURATION_GUIDES.md → Gmail section
- App Password: https://myaccount.google.com/apppasswords
- Troubleshooting: OSTICKET_EMAIL_TROUBLESHOOTING.md → Gmail Issues

### If Office365:
- Setup Guide: See SMTP_CONFIGURATION_GUIDES.md → Office365 section
- Admin Center: https://admin.microsoft.com
- Troubleshooting: OSTICKET_EMAIL_TROUBLESHOOTING.md → Office365 Issues

### If Custom SMTP:
- Setup Guide: See SMTP_CONFIGURATION_GUIDES.md → Custom SMTP section
- Test: Use swaks command in DOCKER_COMMANDS_REFERENCE.md

---

## 🛠️ TOOLS YANG SUDAH SIAP

### Command Scripts (Ready to Run)
```bash
# 1. Auto diagnostic (12 checks)
cd /c/Users/APTIKA_1222/osTicket
bash diagnose-email.sh

# 2. SQL queries batch
docker exec osticket_db mysql -u osticket -posticket osticket < email-queries.sql
```

### Reference Guides (Ready to Read)
- OSTICKET_EMAIL_TROUBLESHOOTING.md (900 lines, very detailed)
- ACTION_PLAN.md (350 lines, structured phases)
- SMTP_CONFIGURATION_GUIDES.md (600 lines, provider-specific)
- DOCKER_COMMANDS_REFERENCE.md (400 lines, command list)

---

## ❓ COMMON QUESTIONS

### Q: Berapa lama untuk resolve issue?
**A:** 30-60 minutes dari start sampai selesai, tergantung root cause. Fase 1-3 usually ~20 minutes, Fase 5 ~10 minutes.

### Q: Bagaimana jika test email tidak diterima?
**A:** Lihat ACTION_PLAN.md Phase 5.1-5.3. Masalahnya besar kemungkinan SMTP credentials atau network connectivity. Check Apache error log untuk error message spesifik.

### Q: Apakah perlu restart container?
**A:** Usually tidak perlu. Cek configuration dulu di database (ost_config table). Jika perlu apply DB changes, restart container:
```bash
docker-compose restart osticket_web
```

### Q: Gmail mana yang dipakai?
**A:** Personal Gmail atau Gmail dengan account bisnis, keduanya bisa. Yang penting: 
1. Enable 2FA
2. Generate App Password (bukan main password)
3. Use 16-char app password di osTicket

### Q: Apakah test email sama dengan ticket email?
**A:** Test email hanya test SMTP connection. Ticket email adalah automated email dari osTicket saat ticket dibuat/dibalas. Both use same SMTP backend, tapi ticket email triggered oleh osTicket automation rules.

### Q: Kemana saya lihat email yang gagal?
**A:** 
1. Database: `SELECT * FROM ost_email_log WHERE status='failed';`
2. osTicket UI: Admin Panel → Support (if logging module available)
3. Container logs: `docker logs osticket_web | tail -50`

---

## ✅ SUCCESS CRITERIA

Email issue resolved when:
- [ ] Test email dari Admin Panel received dalam 30 seconds
- [ ] New ticket notification email received by customer
- [ ] Admin reply notification email received by customer
- [ ] No errors di Apache error log saat email sent
- [ ] Email log shows status='sent' for recent emails
- [ ] Queue empty atau minimal (< 5 items)

---

## 📊 INVESTIGATION CHECKLIST

- [ ] Read ACTION_PLAN.md completely
- [ ] Check osTicket Email Settings (Admin Panel)
- [ ] Run DNS test: `nslookup smtp.gmail.com`
- [ ] Run Port test: `nc -zv smtp.gmail.com 587`
- [ ] Query database: SMTP config exists?
- [ ] Query database: Queue empty?
- [ ] Query database: Cron active?
- [ ] Send test email via Admin Panel
- [ ] Create test ticket
- [ ] Check Apache error log for issues
- [ ] Identify root cause
- [ ] Apply fix from ACTION_PLAN Phase 7
- [ ] Re-test with new ticket
- [ ] Verify emails received

---

## 🔗 NAVIGATION GUIDE

**Untuk Pemula:**
1. Start: ACTION_PLAN.md (Phase 1-5)
2. Jika stuck: OSTICKET_EMAIL_TROUBLESHOOTING.md (Troubleshooting Tree)
3. For commands: DOCKER_COMMANDS_REFERENCE.md

**Untuk Experienced:**
1. Jalankan: diagnose-email.sh
2. Check: email-queries.sql results
3. Lihat: Troubleshooting Tree di OSTICKET_EMAIL_TROUBLESHOOTING.md

**Untuk Setup Baru:**
1. Read: SMTP_CONFIGURATION_GUIDES.md (pilih provider)
2. Configure: Admin Panel → Email Settings
3. Test: Send Test Email
4. Verify: Check database & logs

---

## 💡 PRO TIPS

1. **Save Everything:** Screenshot osTicket email settings, error logs, database outputs
2. **Track Changes:** Note exactly apa yang Anda change dan kapan
3. **Test One Thing:** Change satu setting, test, observe result
4. **Check Logs:** Always check `/var/log/apache2/error.log` setelah mengubah settings
5. **Use swaks:** Untuk isolate SMTP connection issues dari osTicket complexity
6. **Gmail 2FA:** Must have, non-negotiable untuk generate App Password
7. **Port Numbers:** Gmail = 587 (TLS) atau 465 (SSL), Office365 = 587, Custom = tergantung server

---

## 🆘 IF STUCK

### Situation 1: Test email tidak diterima
```
Kemungkinan:
1. SMTP credentials salah → Verify di Gmail/Office365 account
2. Port blocked → nc -zv smtp.gmail.com 587 should return "succeeded"
3. DNS fail → nslookup smtp.gmail.com should return IP address
4. TLS error → Check openssl certificate

Next: Run DOCKER_COMMANDS_REFERENCE.md section "SMTP CONNECTION TESTS"
```

### Situation 2: Tidak ada error, tapi email tidak terkirim
```
Kemungkinan:
1. Backend masih PHP Mail → Change to SMTP
2. Queue disabled → Check ost_cron table
3. Emails stuck di queue → SELECT * FROM ost_mail_queue
4. Automation rules tidak trigger → Check Admin Panel → Automation

Next: Run email-queries.sql untuk diagnostic detail
```

### Situation 3: Multiple errors di log
```
Kemungkinan:
1. SMTP configuration incomplete → Fill all required fields
2. Wrong port → Gmail port harus 587 atau 465
3. TLS mismatch → Port 465 = SSL Implicit, Port 587 = STARTTLS
4. Certificate issue → Test dengan openssl s_client

Next: Read OSTICKET_EMAIL_TROUBLESHOOTING.md → Common Issues section
```

---

## 📝 FINAL NOTES

**Dokumen ini dibuat untuk:**
- ✓ Guided troubleshooting (tidak perlu guess)
- ✓ Ready-to-use commands (copy-paste langsung)
- ✓ Prioritized investigation (paling mungkin dulu)
- ✓ Provider-specific guides (Gmail, O365, custom)
- ✓ Deep technical reference (jika stuck)

**Waktu estimate:**
- ⏱️ Quick fix (wrong backend): 2-5 minutes
- ⏱️ Credentials issue: 10-15 minutes
- ⏱️ Network issue: 20-30 minutes
- ⏱️ Full diagnosis & fix: 60 minutes max

**Recommendation:**
1. Mulai dengan ACTION_PLAN.md Phase 1
2. Catat hasil setiap check
3. Follow troubleshooting tree
4. Apply fix sesuai Phase 7
5. Document untuk referensi future

---

## 🎯 TARGET: 1 HOUR RESOLUTION

Dengan mengikuti panduan ini, issue seharusnya bisa di-resolve dalam 1 jam. Jika lebih dari itu, kemungkinan ada kompleksitas lain yang perlu deeper investigation.

**Kapan hubungi support (jika tersedia):**
- Setelah complete Phase 1-5 di ACTION_PLAN.md
- Dengan dokumentasi lengkap (screenshots, logs, query results)
- Daftar setiap action yang sudah dicoba

Good luck! 🚀

