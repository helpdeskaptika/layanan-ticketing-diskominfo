-- osTicket Email Debugging SQL Queries
-- Run these queries one by one using:
-- docker exec -it osticket_db mysql -u osticket -p osticket < email-queries.sql

-- ========================================
-- [1] EMAIL CONFIGURATION STATUS
-- ========================================
SELECT "========== EMAIL CONFIG ==========" as '';
SELECT name, value FROM ost_config 
WHERE name LIKE '%email%' OR name LIKE '%smtp%' OR name LIKE '%mail%'
ORDER BY name;

-- ========================================
-- [2] DEFAULT EMAIL ADDRESS
-- ========================================
SELECT "========== DEFAULT EMAIL ==========" as '';
SELECT id, name, address, created FROM ost_email LIMIT 10;

-- ========================================
-- [3] ALERT EMAIL SETTINGS
-- ========================================
SELECT "========== ALERT EMAIL SETTINGS ==========" as '';
SELECT * FROM ost_config WHERE name LIKE '%alert%email%';

-- ========================================
-- [4] MAIL QUEUE STATUS - TOTAL COUNT
-- ========================================
SELECT "========== MAIL QUEUE STATUS ==========" as '';
SELECT 
  COUNT(*) as total_queued,
  SUM(CASE WHEN status='pending' THEN 1 ELSE 0 END) as pending,
  SUM(CASE WHEN status='failed' THEN 1 ELSE 0 END) as failed,
  SUM(CASE WHEN status='sent' THEN 1 ELSE 0 END) as sent
FROM ost_mail_queue;

-- ========================================
-- [5] MAIL QUEUE - RECENT ENTRIES
-- ========================================
SELECT "========== RECENT QUEUE ENTRIES ==========" as '';
SELECT 
  id, 
  email_id, 
  object_id, 
  status, 
  created,
  LEFT(message, 100) as message_preview
FROM ost_mail_queue 
ORDER BY created DESC 
LIMIT 20;

-- ========================================
-- [6] EMAIL LOG - STATUS SUMMARY
-- ========================================
SELECT "========== EMAIL LOG SUMMARY ==========" as '';
SELECT 
  status,
  COUNT(*) as count,
  MAX(created) as last_attempt
FROM ost_email_log
GROUP BY status;

-- ========================================
-- [7] FAILED EMAILS - DETAIL
-- ========================================
SELECT "========== FAILED EMAILS DETAIL ==========" as '';
SELECT 
  id,
  email,
  subject,
  status,
  created,
  message
FROM ost_email_log
WHERE status IN ('failed', 'error', 'bounced')
ORDER BY created DESC
LIMIT 50;

-- ========================================
-- [8] SMTP CONFIGURATION - DETAILED
-- ========================================
SELECT "========== SMTP CONFIGURATION ==========" as '';
SELECT 
  name,
  value
FROM ost_config
WHERE name IN (
  'email.smtp.host',
  'email.smtp.port', 
  'email.smtp.auth',
  'email.smtp.tls',
  'email.smtp.user',
  'email.smtp.pass',
  'email.smtp.debug'
)
ORDER BY name;

-- ========================================
-- [9] EMAIL TEMPLATE COUNT
-- ========================================
SELECT "========== EMAIL TEMPLATES ==========" as '';
SELECT 
  id,
  name,
  created
FROM ost_email_template
LIMIT 20;

-- ========================================
-- [10] CRON JOBS - EMAIL RELATED
-- ========================================
SELECT "========== CRON JOBS ==========" as '';
SELECT 
  id,
  func,
  name,
  active,
  interval
FROM ost_cron
WHERE func LIKE '%mail%' OR func LIKE '%email%';

-- ========================================
-- [11] CRON EXECUTION HISTORY - EMAIL
-- ========================================
SELECT "========== CRON EXECUTION HISTORY ==========" as '';
SELECT 
  c.func,
  c.name,
  e.exec_time,
  e.runtime,
  e.attempts
FROM ost_cron_event e
LEFT JOIN ost_cron c ON e.cron_id = c.id
WHERE c.func LIKE '%mail%' OR c.func LIKE '%email%'
ORDER BY e.exec_time DESC
LIMIT 50;

-- ========================================
-- [12] SYSTEM LOGS - EMAIL ERRORS
-- ========================================
SELECT "========== SYSTEM LOGS (EMAIL) ==========" as '';
SELECT 
  id,
  created,
  level,
  category,
  msg
FROM ost_system_log
WHERE msg LIKE '%mail%' OR msg LIKE '%email%' OR msg LIKE '%SMTP%'
ORDER BY created DESC
LIMIT 50;

-- ========================================
-- [13] TICKET DATA - RECENT
-- ========================================
SELECT "========== RECENT TICKETS ==========" as '';
SELECT 
  t.ticket_id,
  t.number,
  t.status,
  t.created,
  c.name as customer_name,
  c.email as customer_email
FROM ost_ticket t
LEFT JOIN ost_user_contact c ON t.user_id = c.user_id
ORDER BY t.created DESC
LIMIT 10;

-- ========================================
-- [14] MESSAGE - RECENT
-- ========================================
SELECT "========== RECENT MESSAGES ==========" as '';
SELECT 
  id,
  thread_id,
  created,
  user_id,
  LEFT(body, 100) as body_preview
FROM ost_ticket_message
ORDER BY created DESC
LIMIT 20;

-- ========================================
-- [15] RECIPIENT TABLE
-- ========================================
SELECT "========== RECIPIENT LIST ==========" as '';
SELECT 
  id,
  email,
  status,
  created
FROM ost_recipient
LIMIT 20;

-- ========================================
-- QUICK DIAGNOSTIC SUMMARY
-- ========================================
SELECT "========== DIAGNOSTIC SUMMARY ==========" as '';
SELECT
  'Total Queued' as check_item,
  COUNT(*) as status
FROM ost_mail_queue
UNION ALL
SELECT
  'Failed Emails',
  COUNT(*)
FROM ost_email_log
WHERE status = 'failed'
UNION ALL
SELECT
  'Sent Emails',
  COUNT(*)
FROM ost_email_log
WHERE status = 'sent'
UNION ALL
SELECT
  'SMTP Backend Selected',
  IF(COUNT(*) > 0, 'YES', 'NO')
FROM ost_config
WHERE name = 'email.smtp.host' AND value IS NOT NULL AND value != ''
UNION ALL
SELECT
  'Mail Cron Active',
  IF(active = 1, 'YES', 'NO')
FROM ost_cron
WHERE func LIKE '%mail%'
LIMIT 10;
