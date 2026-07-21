/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.18-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: osticket
-- ------------------------------------------------------
-- Server version	10.11.18-MariaDB-ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ost__search`
--

DROP TABLE IF EXISTS `ost__search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost__search` (
  `object_type` varchar(8) NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `title` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  PRIMARY KEY (`object_type`,`object_id`),
  FULLTEXT KEY `search` (`title`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost__search`
--

LOCK TABLES `ost__search` WRITE;
/*!40000 ALTER TABLE `ost__search` DISABLE KEYS */;
INSERT INTO `ost__search` VALUES
('H',1,'osTicket Installed!','Thank you for choosing osTicket. Please make sure you join the osTicket forums and our mailing list to stay up to date on the latest news, security alerts and updates. The osTicket forums are also a great place to get assistance, guidance, tips, and help from other osTicket users. In addition to the forums, the osTicket Docs provides a useful collection of educational materials, documentation, and notes from the community. We welcome your contributions to the osTicket community. If you are looking for a greater level of support, we provide professional services and commercial support with guaranteed response times, and access to the core development team. We can also help customize osTicket or even add new features to the system to meet your unique needs. If the idea of managing and upgrading this osTicket installation is daunting, you can try osTicket as a hosted service at https://supportsystem.com/ -- no installation required and we can import your data! With SupportSystem\'s turnkey infrastructure, you get osTicket at its best, leaving you free to focus on your customers without the burden of making sure the application is stable, maintained, and secure. Cheers, - osTicket Team - https://osticket.com/ PS. Don\'t just make customers happy, make happy customers!'),
('H',2,'','Coba'),
('H',3,'','Cek'),
('O',1,'osTicket',''),
('T',1,'171173 osTicket Installed!',''),
('T',2,'602175 Coba','Coba'),
('U',1,'osTicket Team','feedback@osticket.com'),
('U',2,'lkks dompu','081399332689 lkksdompu@gmail.com\nlkksdompu@gmail.com');
/*!40000 ALTER TABLE `ost__search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_api_key`
--

DROP TABLE IF EXISTS `ost_api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_api_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) NOT NULL DEFAULT 1,
  `ipaddr` varchar(64) NOT NULL,
  `apikey` varchar(255) NOT NULL,
  `can_create_tickets` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `can_exec_cron` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apikey` (`apikey`),
  KEY `ipaddr` (`ipaddr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_api_key`
--

LOCK TABLES `ost_api_key` WRITE;
/*!40000 ALTER TABLE `ost_api_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_attachment`
--

DROP TABLE IF EXISTS `ost_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `type` char(1) NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inline` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `lang` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file-type` (`object_id`,`file_id`,`type`),
  UNIQUE KEY `file_object` (`file_id`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_attachment`
--

LOCK TABLES `ost_attachment` WRITE;
/*!40000 ALTER TABLE `ost_attachment` DISABLE KEYS */;
INSERT INTO `ost_attachment` VALUES
(1,1,'C',2,NULL,0,NULL),
(2,8,'T',1,NULL,1,NULL),
(3,9,'T',1,NULL,1,NULL),
(4,10,'T',1,NULL,1,NULL),
(5,11,'T',1,NULL,1,NULL),
(6,12,'T',1,NULL,1,NULL),
(7,13,'T',1,NULL,1,NULL),
(8,14,'T',1,NULL,1,NULL),
(9,16,'T',1,NULL,1,NULL),
(10,17,'T',1,NULL,1,NULL),
(11,18,'T',1,NULL,1,NULL),
(12,19,'T',1,NULL,1,NULL);
/*!40000 ALTER TABLE `ost_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_canned_response`
--

DROP TABLE IF EXISTS `ost_canned_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_canned_response` (
  `canned_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `isenabled` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `title` varchar(255) NOT NULL DEFAULT '',
  `response` text NOT NULL,
  `lang` varchar(16) NOT NULL DEFAULT 'en_US',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`canned_id`),
  UNIQUE KEY `title` (`title`),
  KEY `dept_id` (`dept_id`),
  KEY `active` (`isenabled`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_canned_response`
--

LOCK TABLES `ost_canned_response` WRITE;
/*!40000 ALTER TABLE `ost_canned_response` DISABLE KEYS */;
INSERT INTO `ost_canned_response` VALUES
(1,0,1,'What is osTicket (sample)?','osTicket is a widely-used open source support ticket system, an\nattractive alternative to higher-cost and complex customer support\nsystems - simple, lightweight, reliable, open source, web-based and easy\nto setup and use.','en_US',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(2,0,1,'Sample (with variables)','Hi %{ticket.name.first},\n<br>\n<br>\nYour ticket #%{ticket.number} created on %{ticket.create_date} is in\n%{ticket.dept.name} department.','en_US',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36');
/*!40000 ALTER TABLE `ost_canned_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_config`
--

DROP TABLE IF EXISTS `ost_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `namespace` varchar(64) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  `updated` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `namespace` (`namespace`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_config`
--

LOCK TABLES `ost_config` WRITE;
/*!40000 ALTER TABLE `ost_config` DISABLE KEYS */;
INSERT INTO `ost_config` VALUES
(1,'core','admin_email','helpdesk@dompukab.go.id','2026-06-11 03:06:38'),
(2,'core','helpdesk_url','http://localhost:8080/','2026-06-11 03:06:38'),
(3,'core','helpdesk_title','Helpdesk','2026-06-11 03:06:38'),
(4,'core','schema_signature','5fb92bef17f3b603659e024c01cc7a59','2026-06-11 03:06:38'),
(5,'schedule.1','configuration','{\"holidays\":[4]}','2026-06-11 03:06:34'),
(6,'core','time_format','hh:mm a','2026-06-11 03:06:34'),
(7,'core','date_format','MM/dd/y','2026-06-11 03:06:34'),
(8,'core','datetime_format','MM/dd/y h:mm a','2026-06-11 03:06:34'),
(9,'core','daydatetime_format','EEE, MMM d y h:mm a','2026-06-11 03:06:34'),
(10,'core','default_priority_id','2','2026-06-11 03:06:34'),
(11,'core','enable_daylight_saving','','2026-06-11 03:06:34'),
(12,'core','reply_separator','-- reply above this line --','2026-06-11 03:06:34'),
(13,'core','isonline','1','2026-06-11 03:06:34'),
(14,'core','staff_ip_binding','','2026-06-11 03:06:34'),
(15,'core','staff_max_logins','4','2026-06-11 03:06:34'),
(16,'core','staff_login_timeout','2','2026-06-11 03:06:34'),
(17,'core','staff_session_timeout','30','2026-06-11 03:06:34'),
(18,'core','passwd_reset_period','','2026-06-11 03:06:34'),
(19,'core','client_max_logins','4','2026-06-11 03:06:34'),
(20,'core','client_login_timeout','2','2026-06-11 03:06:34'),
(21,'core','client_session_timeout','30','2026-06-11 03:06:34'),
(22,'core','max_page_size','25','2026-06-11 03:06:34'),
(23,'core','max_open_tickets','','2026-06-11 03:06:34'),
(24,'core','autolock_minutes','3','2026-06-11 03:06:34'),
(25,'core','default_smtp_id','','2026-06-11 03:06:34'),
(26,'core','use_email_priority','','2026-06-11 03:06:34'),
(27,'core','enable_kb','','2026-06-11 03:06:34'),
(28,'core','enable_premade','1','2026-06-11 03:06:34'),
(29,'core','enable_captcha','','2026-06-11 03:06:34'),
(30,'core','enable_auto_cron','','2026-06-11 03:06:34'),
(31,'core','enable_mail_polling','','2026-06-11 03:06:34'),
(32,'core','send_sys_errors','1','2026-06-11 03:06:34'),
(33,'core','send_sql_errors','1','2026-06-11 03:06:34'),
(34,'core','send_login_errors','1','2026-06-11 03:06:34'),
(35,'core','save_email_headers','1','2026-06-11 03:06:34'),
(36,'core','strip_quoted_reply','1','2026-06-11 03:06:34'),
(37,'core','ticket_autoresponder','','2026-06-11 03:06:34'),
(38,'core','message_autoresponder','','2026-06-11 03:06:34'),
(39,'core','ticket_notice_active','1','2026-06-11 03:06:34'),
(40,'core','ticket_alert_active','1','2026-06-11 03:06:34'),
(41,'core','ticket_alert_admin','1','2026-06-11 03:06:34'),
(42,'core','ticket_alert_dept_manager','1','2026-06-11 03:06:34'),
(43,'core','ticket_alert_dept_members','','2026-06-11 03:06:34'),
(44,'core','message_alert_active','1','2026-06-11 03:06:34'),
(45,'core','message_alert_laststaff','1','2026-06-11 03:06:34'),
(46,'core','message_alert_assigned','1','2026-06-11 03:06:34'),
(47,'core','message_alert_dept_manager','','2026-06-11 03:06:34'),
(48,'core','note_alert_active','','2026-06-11 03:06:34'),
(49,'core','note_alert_laststaff','1','2026-06-11 03:06:34'),
(50,'core','note_alert_assigned','1','2026-06-11 03:06:34'),
(51,'core','note_alert_dept_manager','','2026-06-11 03:06:34'),
(52,'core','transfer_alert_active','','2026-06-11 03:06:34'),
(53,'core','transfer_alert_assigned','','2026-06-11 03:06:34'),
(54,'core','transfer_alert_dept_manager','1','2026-06-11 03:06:34'),
(55,'core','transfer_alert_dept_members','','2026-06-11 03:06:34'),
(56,'core','overdue_alert_active','1','2026-06-11 03:06:34'),
(57,'core','overdue_alert_assigned','1','2026-06-11 03:06:34'),
(58,'core','overdue_alert_dept_manager','1','2026-06-11 03:06:34'),
(59,'core','overdue_alert_dept_members','','2026-06-11 03:06:34'),
(60,'core','assigned_alert_active','1','2026-06-11 03:06:34'),
(61,'core','assigned_alert_staff','1','2026-06-11 03:06:34'),
(62,'core','assigned_alert_team_lead','','2026-06-11 03:06:34'),
(63,'core','assigned_alert_team_members','','2026-06-11 03:06:34'),
(64,'core','auto_claim_tickets','1','2026-06-11 03:06:34'),
(65,'core','auto_refer_closed','1','2026-06-11 03:06:34'),
(66,'core','collaborator_ticket_visibility','1','2026-06-11 03:06:34'),
(67,'core','require_topic_to_close','','2026-06-11 03:06:34'),
(68,'core','show_related_tickets','1','2026-06-11 03:06:34'),
(69,'core','show_assigned_tickets','1','2026-06-11 03:06:34'),
(70,'core','show_answered_tickets','','2026-06-11 03:06:34'),
(71,'core','hide_staff_name','','2026-06-11 03:06:34'),
(72,'core','disable_agent_collabs','','2026-06-11 03:06:34'),
(73,'core','overlimit_notice_active','','2026-06-11 03:06:34'),
(74,'core','email_attachments','1','2026-06-11 03:06:34'),
(75,'core','ticket_number_format','######','2026-06-11 03:06:34'),
(76,'core','ticket_sequence_id','','2026-06-11 03:06:34'),
(77,'core','queue_bucket_counts','','2026-06-11 03:06:34'),
(78,'core','allow_external_images','','2026-06-11 03:06:34'),
(79,'core','task_number_format','#','2026-06-11 03:06:34'),
(80,'core','task_sequence_id','2','2026-06-11 03:06:34'),
(81,'core','log_level','2','2026-06-11 03:06:34'),
(82,'core','log_graceperiod','12','2026-06-11 03:06:34'),
(83,'core','client_registration','public','2026-06-11 03:06:34'),
(84,'core','default_ticket_queue','1','2026-06-11 03:06:34'),
(85,'core','embedded_domain_whitelist','youtube.com, dailymotion.com, vimeo.com, player.vimeo.com, web.microsoftstream.com','2026-06-11 03:06:34'),
(86,'core','max_file_size','33554432','2026-06-11 03:06:34'),
(87,'core','landing_page_id','1','2026-06-11 03:06:34'),
(88,'core','thank-you_page_id','2','2026-06-11 03:06:34'),
(89,'core','offline_page_id','3','2026-06-11 03:06:34'),
(90,'core','system_language','en_US','2026-06-11 03:06:36'),
(91,'mysqlsearch','reindex','0','2026-06-11 03:11:31'),
(92,'core','default_email_id','1','2026-06-11 03:06:38'),
(93,'core','alert_email_id','2','2026-06-11 03:06:38'),
(94,'core','default_dept_id','1','2026-06-11 03:06:38'),
(95,'core','default_sla_id','1','2026-06-11 03:06:38'),
(96,'core','schedule_id','1','2026-06-11 03:06:38'),
(97,'core','default_template_id','1','2026-06-11 03:06:38'),
(98,'core','default_timezone','Asia/Shanghai','2026-06-11 03:06:38');
/*!40000 ALTER TABLE `ost_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_content`
--

DROP TABLE IF EXISTS `ost_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `type` varchar(32) NOT NULL DEFAULT 'other',
  `name` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_content`
--

LOCK TABLES `ost_content` WRITE;
/*!40000 ALTER TABLE `ost_content` DISABLE KEYS */;
INSERT INTO `ost_content` VALUES
(1,1,'landing','Landing','<h1>Welcome to the Support Center</h1> <p> In order to streamline support requests and better serve you, we utilize a support ticket system. Every support request is assigned a unique ticket number which you can use to track the progress and responses online. For your reference we provide complete archives and history of all your support requests. A valid email address is required to submit a ticket. </p>','The Landing Page refers to the content of the Customer Portal\'s initial view. The template modifies the content seen above the two links <strong>Open a New Ticket</strong> and <strong>Check Ticket Status</strong>.','2026-06-11 10:06:34','2026-06-11 10:06:34'),
(2,1,'thank-you','Thank You','<div>%{ticket.name},\n<br>\n<br>\nThank you for contacting us.\n<br>\n<br>\nA support ticket request has been created and a representative will be\ngetting back to you shortly if necessary.</p>\n<br>\n<br>\nSupport Team\n</div>','This template defines the content displayed on the Thank-You page after a\nClient submits a new ticket in the Client Portal.','2026-06-11 10:06:34','2026-06-11 10:06:34'),
(3,1,'offline','Offline','<div><h1>\n<span style=\"font-size: medium\">Support Ticket System Offline</span>\n</h1>\n<p>Thank you for your interest in contacting us.</p>\n<p>Our helpdesk is offline at the moment, please check back at a later\ntime.</p>\n</div>','The Offline Page appears in the Customer Portal when the Help Desk is offline.','2026-06-11 10:06:34','2026-06-11 10:06:34'),
(4,1,'registration-staff','Welcome to osTicket','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> We\'ve created an account for you at our help desk at %{url}.<br /> <br /> Please follow the link below to confirm your account and gain access to your tickets.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System<br /> %{company.name}</em> </div>','This template defines the initial email (optional) sent to Agents when an account is created on their behalf.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(5,1,'pwreset-staff','osTicket Staff Password Reset','<h3><strong>Hi %{staff.name.first},</strong></h3> <div> A password reset request has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> If you feel that this has been done in error, delete and disregard this email. Your account is still secure and no one has been given access to it. It is not locked and your password has not been reset. Someone could have mistakenly entered your email address.<br /> <br /> Follow the link below to login to the help desk and change your password.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width: 126px\" /> </div>','This template defines the email sent to Staff who select the <strong>Forgot My Password</strong> link on the Staff Control Panel Log In page.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(6,1,'banner-staff','Authentication Required','','This is the initial message and banner shown on the Staff Log In page. The first input field refers to the red-formatted text that appears at the top. The latter textarea is for the banner content which should serve as a disclaimer.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(7,1,'registration-client','Welcome to %{company.name}','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> We\'ve created an account for you at our help desk at %{url}.<br /> <br /> Please follow the link below to confirm your account and gain access to your tickets.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System <br /> %{company.name}</em> </div>','This template defines the email sent to Clients when their account has been created in the Client Portal or by an Agent on their behalf. This email serves as an email address verification. Please use %{link} somewhere in the body.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(8,1,'pwreset-client','%{company.name} Help Desk Access','<h3><strong>Hi %{user.name.first},</strong></h3> <div> A password reset request has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> If you feel that this has been done in error, delete and disregard this email. Your account is still secure and no one has been given access to it. It is not locked and your password has not been reset. Someone could have mistakenly entered your email address.<br /> <br /> Follow the link below to login to the help desk and change your password.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System <br /> %{company.name}</em> </div>','This template defines the email sent to Clients who select the <strong>Forgot My Password</strong> link on the Client Log In page.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(9,1,'banner-client','Sign in to %{company.name}','To better serve you, we encourage our Clients to register for an account.','This composes the header on the Client Log In page. It can be useful to inform your Clients about your log in and registration policies.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(10,1,'registration-confirm','Account registration','<div><strong>Thanks for registering for an account.</strong><br/> <br /> We\'ve just sent you an email to the address you entered. Please follow the link in the email to confirm your account and gain access to your tickets. </div>','This templates defines the page shown to Clients after completing the registration form. The template should mention that the system is sending them an email confirmation link and what is the next step in the registration process.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(11,1,'registration-thanks','Account Confirmed!','<div> <strong>Thanks for registering for an account.</strong><br /> <br /> You\'ve confirmed your email address and successfully activated your account. You may proceed to open a new ticket or manage existing tickets.<br /> <br /> <em>Your friendly support center</em><br /> %{company.name} </div>','This template defines the content displayed after Clients successfully register by confirming their account. This page should inform the user that registration is complete and that the Client can now submit a ticket or access existing tickets.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(12,1,'access-link','Ticket [#%{ticket.number}] Access Link','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> An access link request for ticket #%{ticket.number} has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> Follow the link below to check the status of the ticket #%{ticket.number}.<br /> <br /> <a href=\"%{recipient.ticket_link}\">%{recipient.ticket_link}</a><br /> <br /> If you <strong>did not</strong> make the request, please delete and disregard this email. Your account is still secure and no one has been given access to the ticket. Someone could have mistakenly entered your email address.<br /> <br /> --<br /> %{company.name} </div>','This template defines the notification for Clients that an access link was sent to their email. The ticket number and email address trigger the access link.','2026-06-11 10:06:35','2026-06-11 10:06:35'),
(13,1,'email2fa-staff','osTicket Two Factor Authentication','<h3><strong>Hi %{staff.name.first},</strong></h3> <div> You have just logged into for the helpdesk at %{url}.<br /> <br /> Use the verification code below to finish logging into the helpdesk.<br /> <br /> %{otp}<br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width: 126px\" /> </div>','This template defines the email sent to Staff who use Email for Two Factor Authentication','2026-06-11 10:06:35','2026-06-11 10:06:35');
/*!40000 ALTER TABLE `ost_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_department`
--

DROP TABLE IF EXISTS `ost_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_department` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `tpl_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sla_id` int(10) unsigned NOT NULL DEFAULT 0,
  `schedule_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email_id` int(10) unsigned NOT NULL DEFAULT 0,
  `autoresp_email_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manager_id` int(10) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `group_membership` tinyint(1) NOT NULL DEFAULT 0,
  `ticket_auto_response` tinyint(1) NOT NULL DEFAULT 1,
  `message_auto_response` tinyint(1) NOT NULL DEFAULT 0,
  `path` varchar(128) NOT NULL DEFAULT '/',
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`pid`),
  KEY `manager_id` (`manager_id`),
  KEY `autoresp_email_id` (`autoresp_email_id`),
  KEY `tpl_id` (`tpl_id`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_department`
--

LOCK TABLES `ost_department` WRITE;
/*!40000 ALTER TABLE `ost_department` DISABLE KEYS */;
INSERT INTO `ost_department` VALUES
(1,NULL,0,0,0,0,0,0,4,'Support','Support Department',1,1,1,1,'/1/','2026-06-11 10:06:32','2026-06-11 10:06:32'),
(2,NULL,0,1,0,0,0,0,4,'Sales','Sales and Customer Retention',1,1,1,1,'/2/','2026-06-11 10:06:32','2026-06-11 10:06:32'),
(3,NULL,0,0,0,0,0,0,4,'Maintenance','Maintenance Department',1,0,1,1,'/3/','2026-06-11 10:06:32','2026-06-11 10:06:32');
/*!40000 ALTER TABLE `ost_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_draft`
--

DROP TABLE IF EXISTS `ost_draft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_draft` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) unsigned NOT NULL,
  `namespace` varchar(32) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `extra` text DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `namespace` (`namespace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_draft`
--

LOCK TABLES `ost_draft` WRITE;
/*!40000 ALTER TABLE `ost_draft` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_draft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email`
--

DROP TABLE IF EXISTS `ost_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_email` (
  `email_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `noautoresp` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `priority_id` int(11) unsigned NOT NULL DEFAULT 2,
  `dept_id` int(11) unsigned NOT NULL DEFAULT 0,
  `topic_id` int(11) unsigned NOT NULL DEFAULT 0,
  `email` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `email` (`email`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email`
--

LOCK TABLES `ost_email` WRITE;
/*!40000 ALTER TABLE `ost_email` DISABLE KEYS */;
INSERT INTO `ost_email` VALUES
(1,0,2,1,0,'helpdesk1@dompukab.go.id','Support',NULL,'2026-06-11 10:06:38','2026-06-11 10:06:38'),
(2,0,2,1,0,'alerts@dompukab.go.id','osTicket Alerts',NULL,'2026-06-11 10:06:38','2026-06-11 10:06:38'),
(3,0,2,1,0,'noreply@dompukab.go.id','',NULL,'2026-06-11 10:06:38','2026-06-11 10:06:38');
/*!40000 ALTER TABLE `ost_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_account`
--

DROP TABLE IF EXISTS `ost_email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_email_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(11) unsigned NOT NULL,
  `type` enum('mailbox','smtp') NOT NULL DEFAULT 'mailbox',
  `auth_bk` varchar(128) NOT NULL,
  `auth_id` varchar(16) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `host` varchar(128) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL,
  `folder` varchar(255) DEFAULT NULL,
  `protocol` enum('IMAP','POP','SMTP','OTHER') NOT NULL DEFAULT 'OTHER',
  `encryption` enum('NONE','AUTO','SSL') NOT NULL DEFAULT 'AUTO',
  `fetchfreq` tinyint(3) unsigned NOT NULL DEFAULT 5,
  `fetchmax` tinyint(4) unsigned DEFAULT 30,
  `postfetch` enum('archive','delete','nothing') NOT NULL DEFAULT 'nothing',
  `archivefolder` varchar(255) DEFAULT NULL,
  `allow_spoofing` tinyint(1) unsigned DEFAULT 0,
  `num_errors` int(11) unsigned NOT NULL DEFAULT 0,
  `last_error_msg` tinytext DEFAULT NULL,
  `last_error` datetime DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_account`
--

LOCK TABLES `ost_email_account` WRITE;
/*!40000 ALTER TABLE `ost_email_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_email_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_template`
--

DROP TABLE IF EXISTS `ost_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_email_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tpl_id` int(11) unsigned NOT NULL,
  `code_name` varchar(32) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_lookup` (`tpl_id`,`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template`
--

LOCK TABLES `ost_email_template` WRITE;
/*!40000 ALTER TABLE `ost_email_template` DISABLE KEYS */;
INSERT INTO `ost_email_template` VALUES
(1,1,'ticket.autoresp','Support Ticket Opened [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> <p>A request for support has been created and assigned #%{ticket.number}. A representative will follow-up with you as soon as possible. You can <a href=\"%%7Brecipient.ticket_link%7D\">view this ticket\'s progress online</a>. </p> <br /> <div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team, <br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div>',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(2,1,'ticket.autoreply','Re: %{ticket.subject} [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> A request for support has been created and assigned ticket <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> with the following automatic reply <br /> <br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /> <br /> %{response} <br /> <br /> <div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>We hope this response has sufficiently answered your questions. If you wish to provide additional comments or information, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div>',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(3,1,'message.autoresp','Message Confirmation','<h3><strong>Dear %{recipient.name.first},</strong></h3> Your reply to support request <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> has been noted <br /> <br /> <div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>You can view the support request progress <a href=\"%%7Brecipient.ticket_link%7D\">online here</a></em> </div>',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(4,1,'ticket.notice','%{ticket.subject} [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> Our customer care team has created a ticket, <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> on your behalf, with the following details and summary: <br /> <br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /> <br /> %{message} <br /> <br /> %{response} <br /> <br /> If need be, a representative will follow-up with you as soon as possible. You can also <a href=\"%%7Brecipient.ticket_link%7D\">view this ticket\'s progress online</a>. <br /> <br /> <div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div>',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(5,1,'ticket.overlimit','Open Tickets Limit Reached','<h3><strong>Dear %{ticket.name.first},</strong></h3> You have reached the maximum number of open tickets allowed. To be able to open another ticket, one of your pending tickets must be closed. To update or add comments to an open ticket simply <a href=\"%%7Burl%7D/tickets.php?e=%%7Bticket.email%7D\">login to our helpdesk</a>. <br /> <br /> Thank you,<br /> Support Ticket System',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(6,1,'ticket.reply','Re: %{ticket.subject} [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> %{response} <br /> <br /> <div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>We hope this response has sufficiently answered your questions. If not, please do not send another email. Instead, reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">login to your account</a> for a complete archive of all your support requests and responses.</em></div>',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(7,1,'ticket.activity.notice','Re: %{ticket.subject} [#%{ticket.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> <div><em>%{poster.name}</em> just logged a message to a ticket in which you participate. </div> <br /> %{message} <br /> <br /> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>You\'re getting this email because you are a collaborator on ticket <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">#%{ticket.number}</a>. To participate, simply reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">click here</a> for a complete archive of the ticket thread.</em> </div>',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(8,1,'ticket.alert','New Ticket Alert','<h2>Hi %{recipient.name},</h2> New ticket #%{ticket.number} created <br /> <br /> <table><tbody><tr><td><strong>From</strong>: </td> <td>%{ticket.name} &lt;%{ticket.email}&gt; </td> </tr> <tr><td><strong>Department</strong>: </td> <td>%{ticket.dept.name} </td> </tr> </tbody> </table> <br /> %{message} <br /> <br /> <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"https://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2026-06-11 10:06:36','2026-06-11 10:06:36'),
(9,1,'message.alert','New Message Alert','<h3><strong>Hi %{recipient.name},</strong></h3> New message appended to ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /> <br /> <table><tbody><tr><td><strong>From</strong>: </td> <td>%{poster.name} &lt;%{ticket.email}&gt; </td> </tr> <tr><td><strong>Department</strong>: </td> <td>%{ticket.dept.name} </td> </tr> </tbody> </table> <br /> %{message} <br /> <br /> <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(10,1,'note.alert','New Internal Activity Alert','<h3><strong>Hi %{recipient.name},</strong></h3> An agent has logged activity on ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /> <br /> <table><tbody><tr><td><strong>From</strong>: </td> <td>%{note.poster} </td> </tr> <tr><td><strong>Title</strong>: </td> <td>%{note.title} </td> </tr> </tbody> </table> <br /> %{note.message} <br /> <br /> <hr /> To view/respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system <br /> <br /> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(11,1,'assigned.alert','Ticket Assigned to you','<h3><strong>Hi %{assignee.name.first},</strong></h3> Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been assigned to you by %{assigner.name.short} <br /> <br /> <table><tbody><tr><td><strong>From</strong>: </td> <td>%{ticket.name} &lt;%{ticket.email}&gt; </td> </tr> <tr><td><strong>Subject</strong>: </td> <td>%{ticket.subject} </td> </tr> </tbody> </table> <br /> %{comments} <br /> <br /> <hr /> <div>To view/respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(12,1,'transfer.alert','Ticket #%{ticket.number} transfer - %{ticket.dept.name}','<h3>Hi %{recipient.name},</h3> Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been transferred to the %{ticket.dept.name} department by <strong>%{staff.name.short}</strong> <br /> <br /> <blockquote>%{comments} </blockquote> <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"https://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(13,1,'ticket.overdue','Stale Ticket Alert','<h3><strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> is seriously overdue. <br /> <br /> We should all work hard to guarantee that all tickets are being addressed in a timely manner. <br /> <br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" />',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(14,1,'task.alert','New Task Alert','<h2>Hi %{recipient.name},</h2> New task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> created <br /> <br /> <table><tbody><tr><td><strong>Department</strong>: </td> <td>%{task.dept.name} </td> </tr> </tbody> </table> <br /> %{task.description} <br /> <br /> <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"https://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(15,1,'task.activity.notice','Re: %{task.title} [#%{task.number}]','<h3><strong>Dear %{recipient.name.first},</strong></h3> <div><em>%{poster.name}</em> just logged a message to a task in which you participate. </div> <br /> %{message} <br /> <br /> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>You\'re getting this email because you are a collaborator on task #%{task.number}. To participate, simply reply to this email.</em> </div>',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(16,1,'task.activity.alert','Task Activity [#%{task.number}] - %{activity.title}','<h3><strong>Hi %{recipient.name},</strong></h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> updated: %{activity.description} <br /> <br /> %{message} <br /> <br /> <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(17,1,'task.assignment.alert','Task Assigned to you','<h3><strong>Hi %{assignee.name.first},</strong></h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> has been assigned to you by %{assigner.name.short} <br /> <br /> %{comments} <br /> <br /> <hr /> <div>To view/respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" />',NULL,'2026-06-11 10:06:37','2026-06-11 10:06:37'),
(18,1,'task.transfer.alert','Task #%{task.number} transfer - %{task.dept.name}','<h3>Hi %{recipient.name},</h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> has been transferred to the %{task.dept.name} department by <strong>%{staff.name.short}</strong> <br /> <br /> <blockquote>%{comments} </blockquote> <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /> <a href=\"https://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a>',NULL,'2026-06-11 10:06:38','2026-06-11 10:06:38'),
(19,1,'task.overdue.alert','Stale Task Alert','<h3><strong>Hi %{recipient.name}</strong>,</h3> A task, <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> is seriously overdue. <br /> <br /> We should all work hard to guarantee that all tasks are being addressed in a timely manner. <br /> <br /> Signed,<br /> %{task.dept.manager.name} <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system. You\'re receiving this notice because the task is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" />',NULL,'2026-06-11 10:06:38','2026-06-11 10:06:38');
/*!40000 ALTER TABLE `ost_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_template_group`
--

DROP TABLE IF EXISTS `ost_email_template_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_email_template_group` (
  `tpl_id` int(11) NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT '',
  `lang` varchar(16) NOT NULL DEFAULT 'en_US',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` timestamp NOT NULL,
  PRIMARY KEY (`tpl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template_group`
--

LOCK TABLES `ost_email_template_group` WRITE;
/*!40000 ALTER TABLE `ost_email_template_group` DISABLE KEYS */;
INSERT INTO `ost_email_template_group` VALUES
(1,1,'osTicket Default Template (HTML)','en_US','Default osTicket templates','2026-06-11 10:06:36','2026-06-11 03:06:36');
/*!40000 ALTER TABLE `ost_email_template_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_event`
--

DROP TABLE IF EXISTS `ost_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_event`
--

LOCK TABLES `ost_event` WRITE;
/*!40000 ALTER TABLE `ost_event` DISABLE KEYS */;
INSERT INTO `ost_event` VALUES
(1,'created',NULL),
(2,'closed',NULL),
(3,'reopened',NULL),
(4,'assigned',NULL),
(5,'released',NULL),
(6,'transferred',NULL),
(7,'referred',NULL),
(8,'overdue',NULL),
(9,'edited',NULL),
(10,'viewed',NULL),
(11,'error',NULL),
(12,'collab',NULL),
(13,'resent',NULL),
(14,'deleted',NULL),
(15,'merged',NULL),
(16,'unlinked',NULL),
(17,'linked',NULL),
(18,'login',NULL),
(19,'logout',NULL),
(20,'message',NULL),
(21,'note',NULL);
/*!40000 ALTER TABLE `ost_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq`
--

DROP TABLE IF EXISTS `ost_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_faq` (
  `faq_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ispublished` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `keywords` tinytext DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`faq_id`),
  UNIQUE KEY `question` (`question`),
  KEY `category_id` (`category_id`),
  KEY `ispublished` (`ispublished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq`
--

LOCK TABLES `ost_faq` WRITE;
/*!40000 ALTER TABLE `ost_faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq_category`
--

DROP TABLE IF EXISTS `ost_faq_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_faq_category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_pid` int(10) unsigned DEFAULT NULL,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` varchar(125) DEFAULT NULL,
  `description` text NOT NULL,
  `notes` tinytext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq_category`
--

LOCK TABLES `ost_faq_category` WRITE;
/*!40000 ALTER TABLE `ost_faq_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq_topic`
--

DROP TABLE IF EXISTS `ost_faq_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_faq_topic` (
  `faq_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`faq_id`,`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq_topic`
--

LOCK TABLES `ost_faq_topic` WRITE;
/*!40000 ALTER TABLE `ost_faq_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_file`
--

DROP TABLE IF EXISTS `ost_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ft` char(1) NOT NULL DEFAULT 'T',
  `bk` char(1) NOT NULL DEFAULT 'D',
  `type` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `size` bigint(20) unsigned NOT NULL DEFAULT 0,
  `key` varchar(86) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `signature` varchar(86) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `attrs` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ft` (`ft`),
  KEY `key` (`key`),
  KEY `signature` (`signature`),
  KEY `type` (`type`),
  KEY `created` (`created`),
  KEY `size` (`size`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file`
--

LOCK TABLES `ost_file` WRITE;
/*!40000 ALTER TABLE `ost_file` DISABLE KEYS */;
INSERT INTO `ost_file` VALUES
(1,'T','D','image/png',9452,'b56944cb4722cc5cda9d1e23a3ea7fbc','gjMyblHhAxCQvzLfPBW3EjMUY1AmQQmz','powered-by-osticket.png',NULL,'2026-06-11 10:06:33'),
(2,'T','D','text/plain',24,'uPrTjMWtx86n3ccfeGGNagoRoTDtol7o','MWtx86n3ccfeGGNafaacpitTxmJ4h3Ls','osTicket.txt',NULL,'2026-06-11 10:06:36');
/*!40000 ALTER TABLE `ost_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_file_chunk`
--

DROP TABLE IF EXISTS `ost_file_chunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_file_chunk` (
  `file_id` int(11) NOT NULL,
  `chunk_id` int(11) NOT NULL,
  `filedata` longblob NOT NULL,
  PRIMARY KEY (`file_id`,`chunk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file_chunk`
--

LOCK TABLES `ost_file_chunk` WRITE;
/*!40000 ALTER TABLE `ost_file_chunk` DISABLE KEYS */;
INSERT INTO `ost_file_chunk` VALUES
(1,0,0x89504E470D0A1A0A0000000D49484452000000DA0000002808060000009847E4C900000A43694343504943432070726F66696C65000078DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A8811628ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB803925110000001974455874536F6674776172650041646F626520496D616765526561647971C9653C0000032869545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B633964223F3E203C783A786D706D65746120786D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F726520352E362D633031342037392E3135363739372C20323031342F30382F32302D30393A35333A30322020202020202020223E203C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E7323223E203C7264663A4465736372697074696F6E207264663A61626F75743D222220786D6C6E733A786D703D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220786D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F2220786D6C6E733A73745265663D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F73547970652F5265736F75726365526566232220786D703A43726561746F72546F6F6C3D2241646F62652050686F746F73686F70204343203230313420284D6163696E746F7368292220786D704D4D3A496E7374616E636549443D22786D702E6969643A36453243393544454136373331314534424443444446393146414639344441352220786D704D4D3A446F63756D656E7449443D22786D702E6469643A3645324339354446413637333131453442444344444639314641463934444135223E203C786D704D4D3A4465726976656446726F6D2073745265663A696E7374616E636549443D22786D702E6969643A4346413734453446413637313131453442444344444639314641463934444135222073745265663A646F63756D656E7449443D22786D702E6469643A4346413734453530413637313131453442444344444639314641463934444135222F3E203C2F7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C2F783A786D706D6574613E203C3F787061636B657420656E643D2272223F3E8BFEF6CA0000170B4944415478DAEC5D099C53D5D53F2F7B32C9646680617118905D3637D0CFAD282AA82D0AF6F3B3B62EF52BD6D685BA206EB54A15C1ADF6538B52B4D53A564454A42C0565D132A86C82A0AC82EC8B0233CCC24C9297F7DD9BFC6F73E64E92C90C5071CCF9FD0E249397F7EEBBF7FCCFF99F73EFBB31860F1F4E593936A4DA74D2D8EEEF53B17F2F51C4FD5D6B7E4BA19385EE177A9BD0ED8D3E832534DFA4D2351EBAFAAD3CB2D92CB219CD636C6D59F3CECA11920B849E27F4C742AF68F4B7A342F34C5AB8DE4D3F9B12A4B0005D7301991447D63EBED7E2125A283457A85D680D22D2BE26463405995D8DFEB63F4A4B44241BFA463E5902642D7D518A5A59A065E5BB29AD849E2A7480D0D384B617EA05E024BB89080D093D287495D0E94267093D90C1B9EDF85F82B4A2D19451006DC65617ED2BB3538F76618A449B57C76781F6FD908E42AF14FABF42BB65F89DDE42AF12BA4CE848A10BD21C9B23741803F3BB42C709FD6D4657921015003B74C8205F8ED9EC4096CDD19ABF7884DE2E74210CBF5B13CE2123E05CA1F7E37CC9E45788921C3AF703D80D47B3A049B3B739E989D21C2ACA8D36CB81C802ADF94A6BA15385FE41E87147C04E1E018DBC00399DA49B4542EF4D13B97E2D343FED999D16D57EE3A0498B7DD426B779E56559EAD8FCE504A16F0AED7584CF7B2E72BBBD426B01B8D6691C763F8A97FA1F4C471BB71DB4D194B51E6A17C8022D2BDF1D9151E695A30032253EE47C99CAEF285ECD1C9B92DF0AEA58E88FC672B3E654D2CF52C7E62D922AF6FF96AE2DE3D152A1CB8556B1BFCB4249CB3A47CA54CC23FEC93569FE1A0F4522061946F31D946C443BE65C5FE470BEFD736ACA64F19193F5427F227487D00E427F29F432E477DFC4EFCF8ABBF76094E6ADF4D0A4955E9AB6D14D6E41218DE63CAC59CB3E86BC9E11A592EDA79019F60AAB6B74F54DE64A7725F9BB9C3C2EFF0FDDC2C342BF04555C47F142493F11E7A6935D00CC6FC6D0F4E55E07FDF4A502BA654690262EF791D76191C76135EFB1CD9AF7B123D2A36F3E14A4903D4C5EABD1FE5D468E9EDADF4A854E04008347B9F9E385BE56871AFAA22171232119C50E96DBE9C036173D58EAA7399B5C541532C8EFB2A87BAB08990263D1E68DB32CD08E297A61086BB36CB4FA4031F5CFDF127B9DA104845EA3FD4D4694A1145F62D5E62837FD39A1A312AD11912B274AABD67B68F1976EEA901FA1055B5CF468690EB5F34763343127271EB14DEBFB31B68EB3CF3E3B6BE1C7904C9BBF8CDEDCDD8BFAB7D824DC7CC67EF02C8A97DD95940178DF20B66C10DAE22834572ED31A416AD58808C2729DE2E37372C914579DB5C94D0B05D00C579472DD227AB5689EAB3EB211ED3B99A75994E7AA8A17452C8F30DE8C5CBE5C31EF62EF1F12BA04AFE522E12784BE91C178CBFCEA75D04C59CCC8A37839DF29B412F95E5B009B50F45856E70C820E4E58E1A5CDBB9D542822598FB689758BDF57906581760C8ADD885255D843353541F2D84399D04759363F91BDFF40E8ABDA316B8456537C82399DC849EE0758CAE8A3C42A907244CA2280F64CA18384CE8E013D2A401834E9AB3D4ECA775A146A19891539BE2570C9F6CA2561EDF17E8FD079420F6581969598F8EDB5B4A2A20D95ECEC4BC33B7F4854EB6FE82B8329BE1E51C95F11C5B874A1D4EB1489196349EC559EC8B142229456DAAAC856673E4CCA761457A653E2319B7CF258BBB6EE70D1B0C979B4EDA09D5A78A37252AD1DC527B723A0B029FD0BC5579A48AA5B20D48DF6CA08BAB109DD2823F23D4207328AFB43A1DBB240CB4A4C2C11481C24CBDDB528F11B149F074E29329AA9B027170FBF9BE498AE1AB5D42F2ACFF027725A9F4B44DCFB561E9D2828DFD567098C1DB2C59B107B80C650935D6159C720B96ADF8A3D42B39D0A22347E6E80566E7752F7B691588E46F155FF72517315CE904A64E4DC041A7ABEF437147F22E079A13765A963568E8A14B8AAE9FDBDDDE8E4E00EEA259442FE5460CB038553F24FD03B5D4E4E79B15819DE7A37E2B61E731CB4D17DF302F4E4877E6A2FA8DFAC0D6EAA0E1BB4B7D246C37AD7D0C80B2A880EC46696DB89E6B48C3529D7DC459EE8A1454B7CF4D66A0F15B73415C808F91C01340D492EF2C2969478B6CDDBC42E8C6AC0361B88A8474A8E475FF786D39891055A7A31601C4E78E3508AE33C38A6065EFEC82418369376D40468555911F50AEC8D47B6E4F36A72DEAC2F5EEF448EA58BA461DD539AA3DB9A496DC2B74C9C951B1AFB5E20669D9D5ACB0286413336BA636B0F0F08A0E57B2C1A39A052DCB14057B55125A0B05AE464F3B7D718E3576DF6866F9E9627724B8A1DC74AF68AF65530C33759DEA7447E26172AAF07D8F2D1FF9587317EFFE985263D50483A09EFC76581D6B0C8817E01B98F7CD46434C59F3AE6D287E2EB0ADBE3987B8ED4C5A30254C7B92B68B22CF38B88D6397777AACD7AE4FC5800AFBF04FDD2E5062D874B80CC4E2F52DBF0CDCFCCCC0DDD332D488581682B9F61150B70796D762BD2CA67C9A7A537B7F24523F3B63AE9EA92022AB9F28004DB12EA5A3B78F906D7CE817715C92A89AF4B71A83857E05180CC0580C8B63C04F07B589E269DD2A39478505452CF3B50C49120FC239C979B9AB225C2B727ED19C8482FBC648196A22641F179A90EF83F999517A0B2E54C6AC8870B36E1903D22B2391CA174391A5FA8BB32491E24DBF500E94BED2CDA2D22D96801B2179EF9672EDDFE76B0B038DFBCC9618B3DA8D99E5D4D562A17442D7AB263303A7FF27A3779DFC9A347CFAF282F793DBF7CD2A75E5BB9D3BAB66361E41671813ED1BA516A8BD0C729BE624497AFD96B79839F4A40E3FDD66398E5A44B96B7A1A0A36C657F16680D4B84D1C50329A8E341786E19FD761F8D46380D934AB69D4277772A25476C5ECD96CC8B2AF944FB4C56DCFE86AA20972951D378C0E631D74E1054F1376FE69DD12EDF7CCE65A753A256EC3E5E84D1C8FCE807422F911A8ED2BDC707CD715345DEF6C53E3B2DDEEE143431FA74AFF6A111A66944C5E7938D3855947D271FD11922F44F42CF107A9D9623F19CCDC5DE77A2F8960B76383BB984EC1F49BA463EC83A18D4B91011B312E3B080E24F103444E5E5B3729782D606E18CC653DD6DF22EA6F814462125A638E48A9B49AC827922FABA9386A78BE18465DB2A1C48E04E45C366A3027435C5E74B1623C1AE4C929B0C42E2E7C54517C13311E3D936500895A0CBFD248A1156373203F6E33B1EDCE81E50221931FAC393C8B9A0F9E0F2C40CA115DAB91E83D4055C7913A8D520E42816AA72FF22AA57B23E139D9583AADD7A16FA53F17D1B8B14EA7C3F419FC8364EA3F88A0C79CE8B700E3948AB9200A2AD8A1EC436C2310C8B361FCAA750D41E075A7D69CD220FA78DB2523706C512259206DE4FDEE8C48DFBEDD18B1F6B4355216A2F403631E0B27A09CA27F3895B847EA5E577D7A3FA375600715FAE2BF67DEA986F5E651834221436B6898EBDC2A80FF47384FE1DB6F421C5D75C72E2CA6B9E4A4E02AD54F29724409351F74EAABFAE53C9F9A0A5E9E6CC241B795A285F16F53AEB7BE9C0E4130757012C94A40DB7012F8310B975B9041A73D60E7886E7D1B07168E80FD817E682E7ABD02E9FDE7D099E8A8B1CEC6728BE625B1AD673F04C37E3FC5246A1E42BAF251FA128C1DF47C33822F03412A47281EA29DA3556C218168236498FD91946F50D3AEF200658523E39B1DA513B4729DAB412EFEFA6F813C05E96D34CC8B052C6238BCCD32E637F1B05E02FC2A0F5C0352F64D4497A6639B92CE79BE6087D4F672B3E7B38BE06B2BE7871EF2AEAEEC06BB9825EDF5A6035A2CA72B975C0DC751EFABACAA016BEE81D22924990CD455B7507548B5CB50AD1718CC8DF66E5BA2DE90CCFB5E2CDBA2F49342538B47B30C63722572B6BA01FAB01BC54858C47615FE9641302433AB6F6A80632D9C6E1B8DF7600DD59ECF3B5C82DBBA3DF7BC0B6FA30C79F4EEC3656FDF1C2E0FB2131FD9A798817019A020040814C469979E8401F3AF63A78E6103AAC2F2B459FC3AE752E5E0710663D300809B25718C85622628510A64BD01935AC3347A0ED8468741E0CB823C02BC1F5193E3F0BF7E0C7BD3D82F698308E7D309ECE1974A0C9BCD710B4750DFE5688B6CA39AC298C6674D1BC7E3BBC9E579F395874C874C68A23290A364578FD3972A2F3E138B8BC1FEB5F4B80CC1FA5671704E80E919715E644FB8A9CEC06AC9ABF2B09C8B8BC0A1B90ECE15AADF4FE759AEF2D40DF47F0DD4CCAF2A9A2DD4D1AC8C2601FD2F15E4EF10D825E461008A5C8AB09C7DDC8DECF60202314B8CE624CE54644DA7E9478D68E40379F84D31F053AC9DBFE216CF23119C06C1A979527FE394070298B6203E1010650624EE65550AEF371ACE2ACF701040BF1FE7480E838189D92229627AA0D5C2621C2AA05B2B7E3264F4747D78262DE0B6E1D66605D0BCA3012E7E8064E3D1C6D3F9112CF6BF5C2EBDB1958EF46243F1714B5B1320614FC62500A15B106C1D89570B6309819EB7BF5124541196F68BF8C7CAEEA64F9591EEBB7452CC7716A51659830D7ED5460D2CB4B7C3462662E15E444C9668BF5878CDA6FB3E89E4ED444F87FC381AAD2FD3D6C2C75D98131B95CA3A48D957614DF558B8BBCEE50B09A77C042AE475FFB293117A700BB034E9F6FA9B00481A196A51043D8E712C47FC6E726D281FBD8E79781CD3C0150717EFF36AAAEB29D636D5A989EC0E6623EC609945C04A35586F104A302FF82272018F879F83E21DCB646BEE447B42C0705CD47E408B2CA4D4F16C966200FCA017551E7EC0BC0D5E0FD6E78AAA9888AAA48F019724C173CDC348A3F662FE517A07152A683EA124ACABF078DC9A41225650522A389C8328E1D73211CD6A78C21A81CAF27F37ECBEB700D234A65110FE5B92B523D759DCBFA6D03A35E4ABE821155927CA8B2CA46EF6F709343BCF60BFA28685F6F16493399CC5D0E70754234FB2BAE712EA2D6431897028DB6495BD9494D9B6754116D288BFC0446F287469C672F22EA5896B7AE41FFF05D99AF003323B0A82949CE3507E3AD72D801ACC063D3A87DCAAAE347DAFB8540A90340511BBE7C00BAC2450128884E919EE57794D8CCA5150CFE7544CE4B0096FE68D42AE459AA43A5112E8331DBE0557258343C9E79A2C5CC903BB2C8F95F42BF40874431707E166D78DE56CBDEAF03E8BB6708B4355A65F22B78D0E3E048B602CC27C3500D44E9BEAC9FEB806C77AD9FFA04F6500719CDCC64F978EC3E5D68F716FCAD428BB09BD50F47BCBED447AFADF052B7C2887CC8D260FD9CE98F51EC8113EA0276F011A2DBD3A0C00F42BF86432C45EEB688524FF8672A03B5F72F36F2FB39A070AA382103C4AD8CE613EC94AFA07122425A0C3435781D4832C5A2072D473AA09949383325A9BED524F1827C998B1B615919DB190015013C1EDCB4A45ABD19C857B39BD80F301BEC26AAD1E6CF61546ECDE055B9D8C3A2D35A749A9D1213A6657008AA1AD8D4690E2345BF998C46A836CE06FDE90C2ADB07ED5C0BE7F36F17BEAD26482709903DD06336B96D2210C4B636A85710E9C61CDC4A561451530F712AEAB2A862A793A62CF3519BA0A99E64B6B17BCE34D2F07B72B2B11C08CA7521C6B21FE8D71046A16EA3A62DE8B592CC17963761AEED4CADB89183EA376940E37B509E4CE996AE252490C206281DD0F42771FBB063B6800214C31B77609E946040F90C8835180809B40B1065F6C0B0D4E31A97B2C8F239C01566D5A3A19A975625F508AEAFA2939D4D2896C3ABFA71CE61F0FAEA7307BEDF17F75180E8A8775ECB0C9377D20A1C525A30C7B28B45CD4FE0746E60C587C5E897B86559063DDE6D2E15F9F7922706325FAAFD434E60C6AE8A2821966BC7FB4DD0C48DFB1D34759D9BBA251EBC3429B18F48A65B1CF8D02F11AA3B191B01F5FD107D5C8CFE389B152AE458FC8CD4063D4D77680D1A740AD1135C2722DC0AC684EC5A7E1B4D33B513812D39D938DA523889A41F0E67865F4075574E7FC0E634BAB2EA939ACFB99B356235CBF3545E520C63530F10560268A762E03E62002318E48FD8353AA12CFB77CC6354A7A8506D619DD70FF9A2FABC27A620FE0F45096530C35815D48E42498B46785C791DBE95C055ECF522AD38A1728E1FE3F55BFC8445DE723A217F0B051D358864494196C768ED275A345774B0B681B6AF67CE3413E986B2F676E43CC751FD5D882DF4FF5C140706E2D8412812351560116D0E2CAF09E79A8CC2899256A81AFA5864AFD12AA6E750628EF53CA61742252BFB23632E562AA0E911ED14508E1994982C56D59979283A8C00B04623227C4675378699C1AA6C2B0028BF96B4EFC580F462F3149FB282CC6078DA975052FD1237D59D150F2A29F92E5E5528E85C8ECE9C8AF73B0186B6E884AB50D0990083790305971E1AC01B0299EAC7F1E8FC001C886ACB1BEC3899A7FD1AC704D01F1FF393DEDD7901D9648551E665A99FAE1E0C5AF309C6454FC0B7FDDB68C206752988D0D0EEB5B468BB33B6210E9B5B5355C427A8E15F8C198871FC1BA2F5C7282EFD94524F0EAF42D1621CF2BA579B18D1B668EFAFD48B470DC84E14ABD6C0299ECEEEE90E7C56A61546FC68FFC126445DEEF4EA453413206B8F12797F366877E2F517A03DDFE0C43F44A9BD279BB3B99575FC622DE1547310FB984795B29479AD7988AC07603897A20CDF1DC73C850A612B56C20D68F73209F31F11789AAB31D7D1964D41BC817997296CDE6B24B8FCB3AC1C1D4891C3799937FC1CFD740DA2956ACB48F4012F362DD34AC075263C7D22A251C4956E407BB36AF04B1AB52E60112D4EB1420605DA86E99AD3AB687FB54D2F5E95829D5CDF80111531765302C32F474A509421BD360F23A2BDA339B611193A4362FDB10BF6F080E6181E44C48D52DD5FCC398DF886430D8BFE53555D5345343BBCF218D0421FAA6FAF22A228F907F8F7507829278CE503CCB570CAB20F03D409DE9DD39C7B01885012EF340509FEE5302C17403A15D14C958D7F815C6A13D55FF0F96718F930388230EE63068B2221DCEB2C783737AEF11A0A149DF09D64FB227E8168E083E793E7BA19F9DE7E50953949B8FD2C4653E7D43B6B6D4046323F0A25FB357A7C3AFAB83568D044EDDB43D87447C254455493E57D2DFECB717A1CE77B0AA5FB6949EEB31051BF330CFE23E6CC6474FE2DC621D91C4457440CD223772365261CB09A1AF1C0514E44FB7781950C80DD946AED71B2A2D47B70A4A318061E076B9B08A7A3162BDC8F7B180F675A0BC7AB72D0A56C0CABC122FC6C8E6D246CDB702449123F8031BB603CC9F8CB3A2493EA07EC4269E6629642939D635D9ACEDD806B38718DB0768D43946492579315E87855DE0F27B91F799EBFC0A118ACA0F05192E90E2E07883D6F0419858133B581568598202596FE7C46F5D73D8A56CA072BAD9E18248B45275E391B4FF5374BED01CF4CF51C83E8BDB25A1B850E19E4C8ABB349CE3478F88761B0CFC24195E13ECEC4679DD08FB7B3B3BE00605F0B631C073A1AC1980D46B42844E49D7E184033D1B73329B1BE533AB8DF205F3F08F0B580935CA84D29E8B4EE1938D67E782F03C6EFC1C64621D5506EE97F702F07D8BDE502D8250C685B70DD8B5865732CDABEC491A20A6965904CD311981FC9440EF7814A4B4B728FD675944198294AC0772202F664B4B1FEF2A5785EB618CCE257C8FB0A700FD310C9E624B9C60044F728A22D8B5D069D5D14A2D33A86686BB99DE76984FC6433FEBF15AA8FF12BF0EE3BD8DF556EFE340A4BC9B650280350C768FDEBD70A3B5E061EBBC6B2942C075D7C9E018458BECBABB105547709569EC6DE760004BC10750BAABF8FE0BE9E625328C114D5D9965A3F3D0C6718607892DAD1A135C04D59391A92835C53816C33A8653A59096AE6426EA976A14A3597730306FB7AD27F9D53D0C62E27D4D2259B6A68CC9C80005A3D5FF01AA2F3A598F66801606F06655B9AE2BACB29F123F132A76907B0EC039D9F4DC937D7998E625618F7F515AB844E4074F253FD5F195D8AEBFD08FF7766154875CD994865A6E37F0B6DD0E9FFDB486B06205AB544DBBDF8EE2728989D838AB91F4E541EBB15E77C5F3BE722B4EB564A4C8DC99469BEF1F2CB2FF742688CA0911BB3B838E222A9C62FE12177C2FB7F9AECC0EBCA4635E5FC7654212B51C1AD2F4193464F0FD298D21CEA10349B439F1A70306A43950A4ACC2736B8A3519A7ED40B377644332FD84235A8AAD540DB5A2070C9E3CBFE5F800100B3E0AF98735D4AFD0000000049454E44AE426082),
(2,0,0x43616E6E6564204174746163686D656E747320526F636B21);
/*!40000 ALTER TABLE `ost_file_chunk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter`
--

DROP TABLE IF EXISTS `ost_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_filter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `execorder` int(10) unsigned NOT NULL DEFAULT 99,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `flags` int(10) unsigned DEFAULT 0,
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `match_all_rules` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `stop_onmatch` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `target` enum('Any','Web','Email','API') NOT NULL DEFAULT 'Any',
  `email_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target` (`target`),
  KEY `email_id` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter`
--

LOCK TABLES `ost_filter` WRITE;
/*!40000 ALTER TABLE `ost_filter` DISABLE KEYS */;
INSERT INTO `ost_filter` VALUES
(1,99,1,0,0,0,0,'Email',0,'SYSTEM BAN LIST','Internal list for email banning. Do not remove','2026-06-11 10:06:33','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter_action`
--

DROP TABLE IF EXISTS `ost_filter_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_filter_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int(10) unsigned NOT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT 0,
  `type` varchar(24) NOT NULL,
  `configuration` text DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_id` (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter_action`
--

LOCK TABLES `ost_filter_action` WRITE;
/*!40000 ALTER TABLE `ost_filter_action` DISABLE KEYS */;
INSERT INTO `ost_filter_action` VALUES
(1,1,1,'reject','[]','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_filter_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter_rule`
--

DROP TABLE IF EXISTS `ost_filter_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_filter_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int(10) unsigned NOT NULL DEFAULT 0,
  `what` varchar(32) NOT NULL,
  `how` enum('equal','not_equal','contains','dn_contain','starts','ends','match','not_match') NOT NULL,
  `val` varchar(255) NOT NULL,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `notes` tinytext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filter` (`filter_id`,`what`,`how`,`val`),
  KEY `filter_id` (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter_rule`
--

LOCK TABLES `ost_filter_rule` WRITE;
/*!40000 ALTER TABLE `ost_filter_rule` DISABLE KEYS */;
INSERT INTO `ost_filter_rule` VALUES
(1,1,'email','equal','test@example.com',1,'','0000-00-00 00:00:00','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_filter_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form`
--

DROP TABLE IF EXISTS `ost_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT 'G',
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  `title` varchar(255) NOT NULL,
  `instructions` varchar(512) DEFAULT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form`
--

LOCK TABLES `ost_form` WRITE;
/*!40000 ALTER TABLE `ost_form` DISABLE KEYS */;
INSERT INTO `ost_form` VALUES
(1,NULL,'U',1,'Contact Information',NULL,'',NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(2,NULL,'T',1,'Ticket Details','Please Describe Your Issue','','This form will be attached to every ticket, regardless of its source.\nYou can add any fields to this form and they will be available to all\ntickets, and will be searchable with advanced search and filterable.','2026-06-11 10:06:32','2026-06-11 10:06:32'),
(3,NULL,'C',1,'Company Information','Details available in email templates','',NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(4,NULL,'O',1,'Organization Information','Details on user organization','',NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(5,NULL,'A',1,'Task Details','Please Describe The Issue','','This form is used to create a task.','2026-06-11 10:06:33','2026-06-11 10:06:33'),
(6,NULL,'L1',0,'Ticket Status Properties','Properties that can be set on a ticket status.','',NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_entry`
--

DROP TABLE IF EXISTS `ost_form_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_form_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `object_id` int(11) unsigned DEFAULT NULL,
  `object_type` char(1) NOT NULL DEFAULT 'T',
  `sort` int(11) unsigned NOT NULL DEFAULT 1,
  `extra` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_lookup` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry`
--

LOCK TABLES `ost_form_entry` WRITE;
/*!40000 ALTER TABLE `ost_form_entry` DISABLE KEYS */;
INSERT INTO `ost_form_entry` VALUES
(1,4,1,'O',1,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(2,3,NULL,'C',1,NULL,'2026-06-11 10:06:38','2026-06-11 10:06:38'),
(3,1,1,'U',1,NULL,'2026-06-11 10:06:39','2026-06-11 10:06:39'),
(4,2,1,'T',0,'{\"disable\":[]}','2026-06-11 10:06:39','2026-06-11 10:06:39'),
(5,1,2,'U',1,NULL,'2026-06-11 10:10:05','2026-06-11 10:10:05'),
(6,2,2,'T',0,'{\"disable\":[]}','2026-06-11 10:10:05','2026-06-11 10:10:05');
/*!40000 ALTER TABLE `ost_form_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_entry_values`
--

DROP TABLE IF EXISTS `ost_form_entry_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_form_entry_values` (
  `entry_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `value` text DEFAULT NULL,
  `value_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`entry_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry_values`
--

LOCK TABLES `ost_form_entry_values` WRITE;
/*!40000 ALTER TABLE `ost_form_entry_values` DISABLE KEYS */;
INSERT INTO `ost_form_entry_values` VALUES
(2,23,'Helpdesk',NULL),
(2,24,NULL,NULL),
(2,25,NULL,NULL),
(2,26,NULL,NULL),
(4,20,'osTicket Installed!',NULL),
(5,3,'081399332689',NULL),
(5,4,NULL,NULL),
(6,20,'Coba',NULL),
(6,22,'Normal',2);
/*!40000 ALTER TABLE `ost_form_entry_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_field`
--

DROP TABLE IF EXISTS `ost_form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_form_field` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `flags` int(10) unsigned DEFAULT 1,
  `type` varchar(255) NOT NULL DEFAULT 'text',
  `label` varchar(255) NOT NULL,
  `name` varchar(64) NOT NULL,
  `configuration` text DEFAULT NULL,
  `sort` int(11) unsigned NOT NULL,
  `hint` varchar(512) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `form_id` (`form_id`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_field`
--

LOCK TABLES `ost_form_field` WRITE;
/*!40000 ALTER TABLE `ost_form_field` DISABLE KEYS */;
INSERT INTO `ost_form_field` VALUES
(1,1,489395,'text','Email Address','email','{\"size\":40,\"length\":64,\"validator\":\"email\"}',1,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(2,1,489395,'text','Full Name','name','{\"size\":40,\"length\":64}',2,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(3,1,13057,'phone','Phone Number','phone',NULL,3,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(4,1,12289,'memo','Internal Notes','notes','{\"rows\":4,\"cols\":40}',4,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(20,2,489265,'text','Issue Summary','subject','{\"size\":40,\"length\":50}',1,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(21,2,480547,'thread','Issue Details','message',NULL,2,'Details on the reason(s) for opening the ticket.','2026-06-11 10:06:32','2026-06-11 10:06:32'),
(22,2,274609,'priority','Priority Level','priority',NULL,3,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(23,3,291249,'text','Company Name','name','{\"size\":40,\"length\":64}',1,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(24,3,274705,'text','Website','website','{\"size\":40,\"length\":64}',2,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(25,3,274705,'phone','Phone Number','phone','{\"ext\":false}',3,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(26,3,12545,'memo','Address','address','{\"rows\":2,\"cols\":40,\"html\":false,\"length\":100}',4,NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32'),
(27,4,489395,'text','Name','name','{\"size\":40,\"length\":64}',1,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(28,4,13057,'memo','Address','address','{\"rows\":2,\"cols\":40,\"length\":100,\"html\":false}',2,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(29,4,13057,'phone','Phone','phone',NULL,3,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(30,4,13057,'text','Website','website','{\"size\":40,\"length\":0}',4,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(31,4,12289,'memo','Internal Notes','notes','{\"rows\":4,\"cols\":40}',5,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(32,5,487601,'text','Title','title','{\"size\":40,\"length\":50}',1,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(33,5,413939,'thread','Description','description',NULL,2,'Details on the reason(s) for creating the task.','2026-06-11 10:06:33','2026-06-11 10:06:33'),
(34,6,487665,'state','State','state','{\"prompt\":\"State of a ticket\"}',1,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33'),
(35,6,471073,'memo','Description','description','{\"rows\":\"2\",\"cols\":\"40\",\"html\":\"\",\"length\":\"100\"}',3,NULL,'2026-06-11 10:06:33','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_group`
--

DROP TABLE IF EXISTS `ost_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) unsigned NOT NULL,
  `flags` int(11) unsigned NOT NULL DEFAULT 1,
  `name` varchar(120) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_group`
--

LOCK TABLES `ost_group` WRITE;
/*!40000 ALTER TABLE `ost_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_help_topic`
--

DROP TABLE IF EXISTS `ost_help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_help_topic` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_pid` int(10) unsigned NOT NULL DEFAULT 0,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `noautoresp` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned DEFAULT 0,
  `status_id` int(10) unsigned NOT NULL DEFAULT 0,
  `priority_id` int(10) unsigned NOT NULL DEFAULT 0,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `team_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sla_id` int(10) unsigned NOT NULL DEFAULT 0,
  `page_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sequence_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sort` int(10) unsigned NOT NULL DEFAULT 0,
  `topic` varchar(128) NOT NULL DEFAULT '',
  `number_format` varchar(32) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`topic_id`),
  UNIQUE KEY `topic` (`topic`,`topic_pid`),
  KEY `topic_pid` (`topic_pid`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`,`team_id`),
  KEY `sla_id` (`sla_id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic`
--

LOCK TABLES `ost_help_topic` WRITE;
/*!40000 ALTER TABLE `ost_help_topic` DISABLE KEYS */;
INSERT INTO `ost_help_topic` VALUES
(1,0,1,0,2,0,2,0,0,0,0,0,0,1,'General Inquiry',NULL,'Questions about products or services','2026-06-11 10:06:33','2026-06-11 10:06:33'),
(2,0,1,0,2,0,1,0,0,0,0,0,0,0,'Feedback',NULL,'Tickets that primarily concern the sales and billing departments','2026-06-11 10:06:33','2026-06-11 10:06:33'),
(10,0,1,0,2,0,2,3,0,0,0,0,0,0,'Report a Problem',NULL,'Product, service, or equipment related issues','2026-06-11 10:06:33','2026-06-11 10:06:33'),
(11,10,1,0,2,0,3,0,0,0,1,0,0,1,'Access Issue',NULL,'Report an inability access a physical or virtual asset','2026-06-11 10:06:33','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_help_topic_form`
--

DROP TABLE IF EXISTS `ost_help_topic_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_help_topic_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL DEFAULT 0,
  `form_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sort` int(10) unsigned NOT NULL DEFAULT 1,
  `extra` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `topic-form` (`topic_id`,`form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic_form`
--

LOCK TABLES `ost_help_topic_form` WRITE;
/*!40000 ALTER TABLE `ost_help_topic_form` DISABLE KEYS */;
INSERT INTO `ost_help_topic_form` VALUES
(1,1,2,1,'{\"disable\":[]}'),
(2,2,2,1,'{\"disable\":[]}'),
(3,10,2,1,'{\"disable\":[]}'),
(4,11,2,1,'{\"disable\":[]}');
/*!40000 ALTER TABLE `ost_help_topic_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_list`
--

DROP TABLE IF EXISTS `ost_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_plural` varchar(255) DEFAULT NULL,
  `sort_mode` enum('Alpha','-Alpha','SortCol') NOT NULL DEFAULT 'Alpha',
  `masks` int(11) unsigned NOT NULL DEFAULT 0,
  `type` varchar(16) DEFAULT NULL,
  `configuration` text NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_list`
--

LOCK TABLES `ost_list` WRITE;
/*!40000 ALTER TABLE `ost_list` DISABLE KEYS */;
INSERT INTO `ost_list` VALUES
(1,'Ticket Status','Ticket Statuses','SortCol',13,'ticket-status','{\"handler\":\"TicketStatusList\"}','Ticket statuses','2026-06-11 10:06:33','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_list_items`
--

DROP TABLE IF EXISTS `ost_list_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_list_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) DEFAULT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT 1,
  `value` varchar(255) NOT NULL,
  `extra` varchar(255) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 1,
  `properties` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `list_item_lookup` (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_list_items`
--

LOCK TABLES `ost_list_items` WRITE;
/*!40000 ALTER TABLE `ost_list_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_list_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_lock`
--

DROP TABLE IF EXISTS `ost_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_lock` (
  `lock_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `expire` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`lock_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_lock`
--

LOCK TABLES `ost_lock` WRITE;
/*!40000 ALTER TABLE `ost_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_note`
--

DROP TABLE IF EXISTS `ost_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_note` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `staff_id` int(11) unsigned NOT NULL DEFAULT 0,
  `ext_id` varchar(10) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` int(11) unsigned NOT NULL DEFAULT 0,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ext_id` (`ext_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_note`
--

LOCK TABLES `ost_note` WRITE;
/*!40000 ALTER TABLE `ost_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_organization`
--

DROP TABLE IF EXISTS `ost_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_organization` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `manager` varchar(16) NOT NULL DEFAULT '',
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `domain` varchar(256) NOT NULL DEFAULT '',
  `extra` text DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_organization`
--

LOCK TABLES `ost_organization` WRITE;
/*!40000 ALTER TABLE `ost_organization` DISABLE KEYS */;
INSERT INTO `ost_organization` VALUES
(1,'osTicket','',8,'',NULL,'2026-06-11 03:06:33',NULL);
/*!40000 ALTER TABLE `ost_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_organization__cdata`
--

DROP TABLE IF EXISTS `ost_organization__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_organization__cdata` (
  `org_id` int(11) unsigned NOT NULL,
  `name` mediumtext DEFAULT NULL,
  `address` mediumtext DEFAULT NULL,
  `phone` mediumtext DEFAULT NULL,
  `website` mediumtext DEFAULT NULL,
  `notes` mediumtext DEFAULT NULL,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_organization__cdata`
--

LOCK TABLES `ost_organization__cdata` WRITE;
/*!40000 ALTER TABLE `ost_organization__cdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_organization__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_plugin`
--

DROP TABLE IF EXISTS `ost_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `install_path` varchar(60) NOT NULL,
  `isphar` tinyint(1) NOT NULL DEFAULT 0,
  `isactive` tinyint(1) NOT NULL DEFAULT 0,
  `version` varchar(64) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `installed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `install_path` (`install_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_plugin`
--

LOCK TABLES `ost_plugin` WRITE;
/*!40000 ALTER TABLE `ost_plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_plugin_instance`
--

DROP TABLE IF EXISTS `ost_plugin_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_plugin_instance` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_id` int(11) unsigned NOT NULL,
  `flags` int(10) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_id` (`plugin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_plugin_instance`
--

LOCK TABLES `ost_plugin_instance` WRITE;
/*!40000 ALTER TABLE `ost_plugin_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_plugin_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue`
--

DROP TABLE IF EXISTS `ost_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT 0,
  `columns_id` int(11) unsigned DEFAULT NULL,
  `sort_id` int(11) unsigned DEFAULT NULL,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` int(11) unsigned NOT NULL DEFAULT 0,
  `title` varchar(60) DEFAULT NULL,
  `config` text DEFAULT NULL,
  `filter` varchar(64) DEFAULT NULL,
  `root` varchar(32) DEFAULT NULL,
  `path` varchar(80) NOT NULL DEFAULT '/',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue`
--

LOCK TABLES `ost_queue` WRITE;
/*!40000 ALTER TABLE `ost_queue` DISABLE KEYS */;
INSERT INTO `ost_queue` VALUES
(1,0,NULL,1,3,0,1,'Open','[[\"status__state\",\"includes\",{\"open\":\"Open\"}]]',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(2,1,NULL,4,43,0,1,'Open','{\"criteria\":[[\"isanswered\",\"nset\",null]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(3,1,NULL,4,43,0,2,'Answered','{\"criteria\":[[\"isanswered\",\"set\",null]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(4,1,NULL,4,43,0,3,'Overdue','{\"criteria\":[[\"isoverdue\",\"set\",null]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(5,0,NULL,3,3,0,3,'My Tickets','{\"criteria\":[[\"assignee\",\"includes\",{\"M\":\"Me\",\"T\":\"One of my teams\"}],[\"status__state\",\"includes\",{\"open\":\"Open\"}]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(6,5,NULL,NULL,43,0,1,'Assigned to Me','{\"criteria\":[[\"assignee\",\"includes\",{\"M\":\"Me\"}]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(7,5,NULL,NULL,43,0,2,'Assigned to Teams','{\"criteria\":[[\"assignee\",\"!includes\",{\"M\":\"Me\"}]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(8,0,NULL,5,3,0,4,'Closed','{\"criteria\":[[\"status__state\",\"includes\",{\"closed\":\"Closed\"}]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(9,8,NULL,5,43,0,1,'Today','{\"criteria\":[[\"closed\",\"period\",\"td\"]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(10,8,NULL,5,43,0,2,'Yesterday','{\"criteria\":[[\"closed\",\"period\",\"yd\"]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(11,8,NULL,5,43,0,3,'This Week','{\"criteria\":[[\"closed\",\"period\",\"tw\"]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(12,8,NULL,5,43,0,4,'This Month','{\"criteria\":[[\"closed\",\"period\",\"tm\"]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(13,8,NULL,6,43,0,5,'This Quarter','{\"criteria\":[[\"closed\",\"period\",\"tq\"]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00'),
(14,8,NULL,7,43,0,6,'This Year','{\"criteria\":[[\"closed\",\"period\",\"ty\"]],\"conditions\":[]}',NULL,'T','/','2026-06-11 10:06:34','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ost_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_column`
--

DROP TABLE IF EXISTS `ost_queue_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_column` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  `primary` varchar(64) NOT NULL DEFAULT '',
  `secondary` varchar(64) DEFAULT NULL,
  `filter` varchar(32) DEFAULT NULL,
  `truncate` varchar(16) DEFAULT NULL,
  `annotations` text DEFAULT NULL,
  `conditions` text DEFAULT NULL,
  `extra` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_column`
--

LOCK TABLES `ost_queue_column` WRITE;
/*!40000 ALTER TABLE `ost_queue_column` DISABLE KEYS */;
INSERT INTO `ost_queue_column` VALUES
(1,0,'Ticket #','number',NULL,'link:ticketP','wrap','[{\"c\":\"TicketSourceDecoration\",\"p\":\"b\"}]','[{\"crit\":[\"isanswered\",\"nset\",null],\"prop\":{\"font-weight\":\"bold\"}}]',NULL),
(2,0,'Date Created','created',NULL,'date:full','wrap','[]','[]',NULL),
(3,0,'Subject','cdata__subject',NULL,'link:ticket','ellipsis','[{\"c\":\"TicketThreadCount\",\"p\":\">\"},{\"c\":\"ThreadAttachmentCount\",\"p\":\"a\"},{\"c\":\"OverdueFlagDecoration\",\"p\":\"<\"},{\"c\":\"LockDecoration\",\"p\":\"<\"}]','[{\"crit\":[\"isanswered\",\"nset\",null],\"prop\":{\"font-weight\":\"bold\"}}]',NULL),
(4,0,'User Name','user__name',NULL,NULL,'wrap','[{\"c\":\"ThreadCollaboratorCount\",\"p\":\">\"}]','[]',NULL),
(5,0,'Priority','cdata__priority',NULL,NULL,'wrap','[]','[]',NULL),
(6,0,'Status','status__id',NULL,NULL,'wrap','[]','[]',NULL),
(7,0,'Close Date','closed',NULL,'date:full','wrap','[]','[]',NULL),
(8,0,'Assignee','assignee',NULL,NULL,'wrap','[]','[]',NULL),
(9,0,'Due Date','duedate','est_duedate','date:human','wrap','[]','[]',NULL),
(10,0,'Last Updated','lastupdate',NULL,'date:full','wrap','[]','[]',NULL),
(11,0,'Department','dept_id',NULL,NULL,'wrap','[]','[]',NULL),
(12,0,'Last Message','thread__lastmessage',NULL,'date:human','wrap','[]','[]',NULL),
(13,0,'Last Response','thread__lastresponse',NULL,'date:human','wrap','[]','[]',NULL),
(14,0,'Team','team_id',NULL,NULL,'wrap','[]','[]',NULL);
/*!40000 ALTER TABLE `ost_queue_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_columns`
--

DROP TABLE IF EXISTS `ost_queue_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_columns` (
  `queue_id` int(11) unsigned NOT NULL,
  `column_id` int(11) unsigned NOT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `bits` int(10) unsigned NOT NULL DEFAULT 0,
  `sort` int(10) unsigned NOT NULL DEFAULT 1,
  `heading` varchar(64) DEFAULT NULL,
  `width` int(10) unsigned NOT NULL DEFAULT 100,
  PRIMARY KEY (`queue_id`,`column_id`,`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_columns`
--

LOCK TABLES `ost_queue_columns` WRITE;
/*!40000 ALTER TABLE `ost_queue_columns` DISABLE KEYS */;
INSERT INTO `ost_queue_columns` VALUES
(1,1,0,1,1,'Ticket',100),
(1,3,0,1,3,'Subject',300),
(1,4,0,1,4,'From',185),
(1,5,0,1,5,'Priority',85),
(1,8,0,1,6,'Assigned To',160),
(1,10,0,1,2,'Last Updated',150),
(2,1,0,1,1,'Ticket',100),
(2,3,0,1,3,'Subject',300),
(2,4,0,1,4,'From',185),
(2,5,0,1,5,'Priority',85),
(2,8,0,1,6,'Assigned To',160),
(2,10,0,1,2,'Last Updated',150),
(3,1,0,1,1,'Ticket',100),
(3,3,0,1,3,'Subject',300),
(3,4,0,1,4,'From',185),
(3,5,0,1,5,'Priority',85),
(3,8,0,1,6,'Assigned To',160),
(3,10,0,1,2,'Last Updated',150),
(4,1,0,1,1,'Ticket',100),
(4,3,0,1,3,'Subject',300),
(4,4,0,1,4,'From',185),
(4,5,0,1,5,'Priority',85),
(4,8,0,1,6,'Assigned To',160),
(4,9,0,1,9,'Due Date',150),
(5,1,0,1,1,'Ticket',100),
(5,3,0,1,3,'Subject',300),
(5,4,0,1,4,'From',185),
(5,5,0,1,5,'Priority',85),
(5,10,0,1,2,'Last Update',150),
(5,11,0,1,6,'Department',160),
(6,1,0,1,1,'Ticket',100),
(6,3,0,1,3,'Subject',300),
(6,4,0,1,4,'From',185),
(6,5,0,1,5,'Priority',85),
(6,10,0,1,2,'Last Update',150),
(6,11,0,1,6,'Department',160),
(7,1,0,1,1,'Ticket',100),
(7,3,0,1,3,'Subject',300),
(7,4,0,1,4,'From',185),
(7,5,0,1,5,'Priority',85),
(7,10,0,1,2,'Last Update',150),
(7,14,0,1,6,'Team',160),
(8,1,0,1,1,'Ticket',100),
(8,3,0,1,3,'Subject',300),
(8,4,0,1,4,'From',185),
(8,7,0,1,2,'Date Closed',150),
(8,8,0,1,6,'Closed By',160),
(9,1,0,1,1,'Ticket',100),
(9,3,0,1,3,'Subject',300),
(9,4,0,1,4,'From',185),
(9,7,0,1,2,'Date Closed',150),
(9,8,0,1,6,'Closed By',160),
(10,1,0,1,1,'Ticket',100),
(10,3,0,1,3,'Subject',300),
(10,4,0,1,4,'From',185),
(10,7,0,1,2,'Date Closed',150),
(10,8,0,1,6,'Closed By',160),
(11,1,0,1,1,'Ticket',100),
(11,3,0,1,3,'Subject',300),
(11,4,0,1,4,'From',185),
(11,7,0,1,2,'Date Closed',150),
(11,8,0,1,6,'Closed By',160),
(12,1,0,1,1,'Ticket',100),
(12,3,0,1,3,'Subject',300),
(12,4,0,1,4,'From',185),
(12,7,0,1,2,'Date Closed',150),
(12,8,0,1,6,'Closed By',160),
(13,1,0,1,1,'Ticket',100),
(13,3,0,1,3,'Subject',300),
(13,4,0,1,4,'From',185),
(13,7,0,1,2,'Date Closed',150),
(13,8,0,1,6,'Closed By',160),
(14,1,0,1,1,'Ticket',100),
(14,3,0,1,3,'Subject',300),
(14,4,0,1,4,'From',185),
(14,7,0,1,2,'Date Closed',150),
(14,8,0,1,6,'Closed By',160);
/*!40000 ALTER TABLE `ost_queue_columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_config`
--

DROP TABLE IF EXISTS `ost_queue_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_config` (
  `queue_id` int(11) unsigned NOT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `setting` text DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`queue_id`,`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_config`
--

LOCK TABLES `ost_queue_config` WRITE;
/*!40000 ALTER TABLE `ost_queue_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_queue_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_export`
--

DROP TABLE IF EXISTS `ost_queue_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_export` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `queue_id` int(11) unsigned NOT NULL,
  `path` varchar(64) NOT NULL DEFAULT '',
  `heading` varchar(64) DEFAULT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `queue_id` (`queue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_export`
--

LOCK TABLES `ost_queue_export` WRITE;
/*!40000 ALTER TABLE `ost_queue_export` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_queue_export` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_sort`
--

DROP TABLE IF EXISTS `ost_queue_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_sort` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `root` varchar(32) DEFAULT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `columns` text DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_sort`
--

LOCK TABLES `ost_queue_sort` WRITE;
/*!40000 ALTER TABLE `ost_queue_sort` DISABLE KEYS */;
INSERT INTO `ost_queue_sort` VALUES
(1,NULL,'Priority + Most Recently Updated','[\"-cdata__priority\",\"-lastupdate\"]','2026-06-11 10:06:34'),
(2,NULL,'Priority + Most Recently Created','[\"-cdata__priority\",\"-created\"]','2026-06-11 10:06:34'),
(3,NULL,'Priority + Due Date','[\"-cdata__priority\",\"-est_duedate\"]','2026-06-11 10:06:34'),
(4,NULL,'Due Date','[\"-est_duedate\"]','2026-06-11 10:06:34'),
(5,NULL,'Closed Date','[\"-closed\"]','2026-06-11 10:06:34'),
(6,NULL,'Create Date','[\"-created\"]','2026-06-11 10:06:34'),
(7,NULL,'Update Date','[\"-lastupdate\"]','2026-06-11 10:06:34');
/*!40000 ALTER TABLE `ost_queue_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue_sorts`
--

DROP TABLE IF EXISTS `ost_queue_sorts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_queue_sorts` (
  `queue_id` int(11) unsigned NOT NULL,
  `sort_id` int(11) unsigned NOT NULL,
  `bits` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`queue_id`,`sort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue_sorts`
--

LOCK TABLES `ost_queue_sorts` WRITE;
/*!40000 ALTER TABLE `ost_queue_sorts` DISABLE KEYS */;
INSERT INTO `ost_queue_sorts` VALUES
(1,1,0,0),
(1,2,0,0),
(1,3,0,0),
(1,4,0,0),
(1,6,0,0),
(1,7,0,0),
(5,1,0,0),
(5,2,0,0),
(5,3,0,0),
(5,4,0,0),
(5,6,0,0),
(5,7,0,0),
(6,1,0,0),
(6,2,0,0),
(6,3,0,0),
(6,4,0,0),
(6,6,0,0),
(6,7,0,0),
(7,1,0,0),
(7,2,0,0),
(7,3,0,0),
(7,4,0,0),
(7,6,0,0),
(7,7,0,0),
(8,1,0,0),
(8,2,0,0),
(8,3,0,0),
(8,4,0,0),
(8,5,0,0),
(8,6,0,0),
(8,7,0,0),
(9,1,0,0),
(9,2,0,0),
(9,3,0,0),
(9,4,0,0),
(9,5,0,0),
(9,6,0,0),
(9,7,0,0),
(10,1,0,0),
(10,2,0,0),
(10,3,0,0),
(10,4,0,0),
(10,5,0,0),
(10,6,0,0),
(10,7,0,0),
(11,1,0,0),
(11,2,0,0),
(11,3,0,0),
(11,4,0,0),
(11,5,0,0),
(11,6,0,0),
(11,7,0,0),
(12,1,0,0),
(12,2,0,0),
(12,3,0,0),
(12,4,0,0),
(12,5,0,0),
(12,6,0,0),
(12,7,0,0),
(13,1,0,0),
(13,2,0,0),
(13,3,0,0),
(13,4,0,0),
(13,5,0,0),
(13,6,0,0),
(13,7,0,0),
(14,1,0,0),
(14,2,0,0),
(14,3,0,0),
(14,4,0,0),
(14,5,0,0),
(14,6,0,0),
(14,7,0,0);
/*!40000 ALTER TABLE `ost_queue_sorts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_role`
--

DROP TABLE IF EXISTS `ost_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(64) DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_role`
--

LOCK TABLES `ost_role` WRITE;
/*!40000 ALTER TABLE `ost_role` DISABLE KEYS */;
INSERT INTO `ost_role` VALUES
(1,1,'All Access','{\"ticket.assign\":1,\"ticket.close\":1,\"ticket.create\":1,\"ticket.delete\":1,\"ticket.edit\":1,\"thread.edit\":1,\"ticket.link\":1,\"ticket.markanswered\":1,\"ticket.merge\":1,\"ticket.reply\":1,\"ticket.refer\":1,\"ticket.release\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.close\":1,\"task.create\":1,\"task.delete\":1,\"task.edit\":1,\"task.reply\":1,\"task.transfer\":1,\"canned.manage\":1}','Role with unlimited access','2026-06-11 10:06:33','2026-06-11 10:06:33'),
(2,1,'Expanded Access','{\"ticket.assign\":1,\"ticket.close\":1,\"ticket.create\":1,\"ticket.edit\":1,\"ticket.link\":1,\"ticket.merge\":1,\"ticket.reply\":1,\"ticket.refer\":1,\"ticket.release\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.close\":1,\"task.create\":1,\"task.edit\":1,\"task.reply\":1,\"task.transfer\":1,\"canned.manage\":1}','Role with expanded access','2026-06-11 10:06:33','2026-06-11 10:06:33'),
(3,1,'Limited Access','{\"ticket.assign\":1,\"ticket.create\":1,\"ticket.link\":1,\"ticket.merge\":1,\"ticket.refer\":1,\"ticket.release\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.reply\":1,\"task.transfer\":1}','Role with limited access','2026-06-11 10:06:33','2026-06-11 10:06:33'),
(4,1,'View only',NULL,'Simple role with no permissions','2026-06-11 10:06:33','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_schedule`
--

DROP TABLE IF EXISTS `ost_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_schedule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_schedule`
--

LOCK TABLES `ost_schedule` WRITE;
/*!40000 ALTER TABLE `ost_schedule` DISABLE KEYS */;
INSERT INTO `ost_schedule` VALUES
(1,1,'Monday - Friday 8am - 5pm with U.S. Holidays',NULL,'','2026-06-11 10:06:34','2026-06-11 10:06:34'),
(2,1,'24/7',NULL,'','2026-06-11 10:06:34','2026-06-11 10:06:34'),
(3,1,'24/5',NULL,'','2026-06-11 10:06:34','2026-06-11 10:06:34'),
(4,0,'U.S. Holidays',NULL,'','2026-06-11 10:06:34','2026-06-11 10:06:34');
/*!40000 ALTER TABLE `ost_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_schedule_entry`
--

DROP TABLE IF EXISTS `ost_schedule_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_schedule_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `repeats` varchar(16) NOT NULL DEFAULT 'never',
  `starts_on` date DEFAULT NULL,
  `starts_at` time DEFAULT NULL,
  `ends_on` date DEFAULT NULL,
  `ends_at` time DEFAULT NULL,
  `stops_on` datetime DEFAULT NULL,
  `day` tinyint(4) DEFAULT NULL,
  `week` tinyint(4) DEFAULT NULL,
  `month` tinyint(4) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `schedule_id` (`schedule_id`),
  KEY `repeats` (`repeats`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_schedule_entry`
--

LOCK TABLES `ost_schedule_entry` WRITE;
/*!40000 ALTER TABLE `ost_schedule_entry` DISABLE KEYS */;
INSERT INTO `ost_schedule_entry` VALUES
(1,1,0,0,'Monday','weekly','2019-01-07','08:00:00','2019-01-07','17:00:00',NULL,1,NULL,NULL,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(2,1,0,0,'Tuesday','weekly','2019-01-08','08:00:00','2019-01-08','17:00:00',NULL,2,NULL,NULL,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(3,1,0,0,'Wednesday','weekly','2019-01-09','08:00:00','2019-01-09','17:00:00',NULL,3,NULL,NULL,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(4,1,0,0,'Thursday','weekly','2019-01-10','08:00:00','2019-01-10','17:00:00',NULL,4,NULL,NULL,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(5,1,0,0,'Friday','weekly','2019-01-11','08:00:00','2019-01-11','17:00:00',NULL,5,NULL,NULL,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(6,2,0,0,'Daily','daily','2019-01-01','00:00:00','2019-01-01','23:59:59',NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(7,3,0,0,'Weekdays','weekdays','2019-01-01','00:00:00','2019-01-01','23:59:59',NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(8,4,0,0,'New Year\'s Day','yearly','2019-01-01','00:00:00','2019-01-01','23:59:59',NULL,1,NULL,1,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(9,4,0,0,'MLK Day','yearly','2019-01-21','00:00:00','2019-01-21','23:59:59',NULL,1,3,1,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(10,4,0,0,'Memorial Day','yearly','2019-05-27','00:00:00','2019-05-27','23:59:59',NULL,1,-1,5,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(11,4,0,0,'Independence Day (4th of July)','yearly','2019-07-04','00:00:00','2019-07-04','23:59:59',NULL,4,NULL,7,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(12,4,0,0,'Labor Day','yearly','2019-09-02','00:00:00','2019-09-02','23:59:59',NULL,1,1,9,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(13,4,0,0,'Indigenous Peoples\' Day (Whodat Columbus)','yearly','2019-10-14','00:00:00','2019-10-14','23:59:59',NULL,1,2,10,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(14,4,0,0,'Veterans Day','yearly','2019-11-11','00:00:00','2019-11-11','23:59:59',NULL,11,NULL,11,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(15,4,0,0,'Thanksgiving Day','yearly','2019-11-28','00:00:00','2019-11-28','23:59:59',NULL,4,4,11,'0000-00-00 00:00:00','2026-06-11 10:06:34'),
(16,4,0,0,'Christmas Day','yearly','2019-11-25','00:00:00','2019-11-25','23:59:59',NULL,25,NULL,12,'0000-00-00 00:00:00','2026-06-11 10:06:34');
/*!40000 ALTER TABLE `ost_schedule_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_sequence`
--

DROP TABLE IF EXISTS `ost_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_sequence` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `flags` int(10) unsigned DEFAULT NULL,
  `next` bigint(20) unsigned NOT NULL DEFAULT 1,
  `increment` int(11) DEFAULT 1,
  `padding` char(1) DEFAULT '0',
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sequence`
--

LOCK TABLES `ost_sequence` WRITE;
/*!40000 ALTER TABLE `ost_sequence` DISABLE KEYS */;
INSERT INTO `ost_sequence` VALUES
(1,'General Tickets',1,1,1,'0','0000-00-00 00:00:00'),
(2,'Tasks Sequence',1,1,1,'0','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ost_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_session`
--

DROP TABLE IF EXISTS `ost_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_session` (
  `session_id` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `session_data` blob DEFAULT NULL,
  `session_expire` datetime DEFAULT NULL,
  `session_updated` datetime DEFAULT NULL,
  `user_id` varchar(16) NOT NULL DEFAULT '0' COMMENT 'osTicket staff/client ID',
  `user_ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `updated` (`session_updated`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_session`
--

LOCK TABLES `ost_session` WRITE;
/*!40000 ALTER TABLE `ost_session` DISABLE KEYS */;
INSERT INTO `ost_session` VALUES
('0045c4e5d0d35d73c17a036fc7730fe4',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2263313961343435373638313633303264363538376237393137646563303935373165386462613034223B733A343A2274696D65223B693A313738313635383836313B7D,'2026-06-18 08:14:21','2026-06-17 08:14:21','0','127.0.0.1','curl/8.14.1'),
('02c3f4a9f0e5c3fb5ccaf305bc424444',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239356136306235373333313837366432663330616363323465666163303637316464646333373466223B733A343A2274696D65223B693A313738313636303033323B7D,'2026-06-18 08:33:52','2026-06-17 08:33:52','0','127.0.0.1','curl/8.14.1'),
('03bd2fe8a703f7eddce261390f99d5e5',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239353138316332313061656366663637353361316365616566306431336564376430613636306433223B733A343A2274696D65223B693A313738313134373935333B7D,'2026-06-12 10:19:13','2026-06-11 10:19:13','0','127.0.0.1','curl/8.14.1'),
('03f00f076a8728b0503bad4435016f49',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265356436386139616564363262336332343731633231353363323462333838306230333661656363223B733A343A2274696D65223B693A313738313635373431373B7D,'2026-06-18 07:50:17','2026-06-17 07:50:17','0','127.0.0.1','curl/8.14.1'),
('0438138f4ef58770a72a5da415259eef',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233653438346138656666353561383961356461313062646261616237626531383861623463386635223B733A343A2274696D65223B693A313738313635373636333B7D,'2026-06-18 07:54:23','2026-06-17 07:54:23','0','127.0.0.1','curl/8.14.1'),
('071f6a5a822043055eda26f22b31bac9',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2236643263393831636335653737376431613833393163616630623737326565366465613564666134223B733A343A2274696D65223B693A313738313134373634343B7D,'2026-06-12 10:14:04','2026-06-11 10:14:04','0','127.0.0.1','curl/8.14.1'),
('07d7761984aeef42ff37ec28cd5266c4',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238653139343763636665633261323638623365353631313939643861356266343339623532363561223B733A343A2274696D65223B693A313738313134383037363B7D,'2026-06-12 10:21:16','2026-06-11 10:21:16','0','127.0.0.1','curl/8.14.1'),
('08296fb4eb22849616d25016bc5c6a13',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237623033616334356366333166623234613463613465656265663231656361326533373636323738223B733A343A2274696D65223B693A313738313635363237303B7D,'2026-06-18 07:31:10','2026-06-17 07:31:10','0','127.0.0.1','curl/8.14.1'),
('08a3f661ab535f48a733a18b37d42aae',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262313164363730633664323537323565323965633239313239303430326266306431393235383536223B733A343A2274696D65223B693A313738313635353638363B7D,'2026-06-18 07:21:26','2026-06-17 07:21:26','0','127.0.0.1','curl/8.14.1'),
('08e3cfe345fd347f7befcd6afe42c9d7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233616337343864373235346466333136643634356530313836353736663032303632613938353564223B733A343A2274696D65223B693A313738313635383234373B7D,'2026-06-18 08:04:07','2026-06-17 08:04:07','0','127.0.0.1','curl/8.14.1'),
('0ad9a3fdf6b7484efd0a9ee67cb74ba4',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239623334316332376637613232303663383639363830313633313535393135633134383263313938223B733A343A2274696D65223B693A313738313635393139383B7D,'2026-06-18 08:19:59','2026-06-17 08:19:59','0','127.0.0.1','curl/8.14.1'),
('0b42499dad757dbd842aaae3eb239cfa',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239626235353466336537396663343664303832393662626536346661333133343264373933373336223B733A343A2274696D65223B693A313738313635343432353B7D,'2026-06-18 07:00:25','2026-06-17 07:00:25','0','127.0.0.1','curl/8.14.1'),
('0bf7b8a5c41690db1acb2cf697d075a8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232396361343966306663393363316236353632653166646637353333623136623338313935656635223B733A343A2274696D65223B693A313738313635353434313B7D,'2026-06-18 07:17:21','2026-06-17 07:17:21','0','127.0.0.1','curl/8.14.1'),
('0ca8d4b8a799cafe4a957e0c6dcc985d',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235663736633966663739663661326431383434356561383865316439626432316235316264623564223B733A343A2274696D65223B693A313738313635373437383B7D,'2026-06-18 07:51:18','2026-06-17 07:51:18','0','127.0.0.1','curl/8.14.1'),
('10155b4b4ffdc52af85822576038a847',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264323439643363363332353662666566313431323861623431353163366266306564363131346230223B733A343A2274696D65223B693A313738313635383033313B7D,'2026-06-18 08:00:31','2026-06-17 08:00:31','0','127.0.0.1','curl/8.14.1'),
('12a6dad3bb043101c579c8de7841a661',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262613837336338343365623733613063663564346639356331306362373161613838616438663164223B733A343A2274696D65223B693A313738313636303036333B7D,'2026-06-18 08:34:23','2026-06-17 08:34:23','0','127.0.0.1','curl/8.14.1'),
('150393e0150a185f375c79beb8e20603',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265376466353264376537323438373463616363353333613064383763333663613230386531396166223B733A343A2274696D65223B693A313738313134373237363B7D,'2026-06-12 10:07:56','2026-06-11 10:07:56','0','127.0.0.1','curl/8.14.1'),
('1549a60f33c9ec89a38e6e6541930603',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230316163376434623362646461303635303561626432386166346535643530363038353935643932223B733A343A2274696D65223B693A313738313134383230303B7D,'2026-06-12 10:23:20','2026-06-11 10:23:20','0','127.0.0.1','curl/8.14.1'),
('15d445586efbc9d2303b41b858294971',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2263656337363830316565343533613636306131396234393161393361376431613862393432356333223B733A343A2274696D65223B693A313738313635363230393B7D,'2026-06-18 07:30:09','2026-06-17 07:30:09','0','127.0.0.1','curl/8.14.1'),
('1623905bbd70ef0814fc9cadaa261270',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262663831663163343736393164366630383933316635656661633236656364326338303530396436223B733A343A2274696D65223B693A313738313635373434383B7D,'2026-06-18 07:50:48','2026-06-17 07:50:48','0','127.0.0.1','curl/8.14.1'),
('1636fec8d9637d1134a3760089813485',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232343732313531323532666666306234636335333738386638663964616434366639393261623139223B733A343A2274696D65223B693A313738313635383932323B7D,'2026-06-18 08:15:22','2026-06-17 08:15:22','0','127.0.0.1','curl/8.14.1'),
('174a12afc74b3c529be1c6677ccce50b',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237623631643034326365616236626365633432393361323562613065653538306439323031373635223B733A343A2274696D65223B693A313738313636303135363B7D,'2026-06-18 08:35:56','2026-06-17 08:35:56','0','127.0.0.1','curl/8.14.1'),
('18418c9e07efd9f51d48ed64c332ac27',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231623765373333306533626235366537313431356662626132373766616332306230333337326465223B733A343A2274696D65223B693A313738313635383138363B7D,'2026-06-18 08:03:06','2026-06-17 08:03:06','0','127.0.0.1','curl/8.14.1'),
('185829c9f84f4ed3301f8790a27e0ba5',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239366362386264393035326364383566306461656266373135653531366163656634316132666161223B733A343A2274696D65223B693A313738313635363336323B7D,'2026-06-18 07:32:42','2026-06-17 07:32:42','0','127.0.0.1','curl/8.14.1'),
('193ade1c01b7f835c8e957065f802d64',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239346663353737326530663837643934303834383136323136636361643666333837643065653431223B733A343A2274696D65223B693A313738313635353331383B7D,'2026-06-18 07:15:18','2026-06-17 07:15:18','0','127.0.0.1','curl/8.14.1'),
('1ba79e394775704eac75f23f647395c2',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239623234613564626463616461643937306639396332323963336338613530386632383864633933223B733A343A2274696D65223B693A313738313635363339333B7D,'2026-06-18 07:33:13','2026-06-17 07:33:13','0','127.0.0.1','curl/8.14.1'),
('1bed4d45593c087ff199ec945b9cc4aa',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238393036633833303436636536343730653333623666653165663864623335373334383732613336223B733A343A2274696D65223B693A313738313134373535323B7D,'2026-06-12 10:12:32','2026-06-11 10:12:32','0','127.0.0.1','curl/8.14.1'),
('1d28c5fe6c2dc7a631f3953e0da786a8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231303738376139303531363466383766373335393333343635363662623232663836653761653739223B733A343A2274696D65223B693A313738313134383239333B7D,'2026-06-12 10:24:53','2026-06-11 10:24:53','0','127.0.0.1','curl/8.14.1'),
('1e72d737d81bab68f2cb959a11c19dcb',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231366331373039636365363635396561663133376537663538376262306334616635393235636237223B733A343A2274696D65223B693A313738313635363234303B7D,'2026-06-18 07:30:40','2026-06-17 07:30:40','0','127.0.0.1','curl/8.14.1'),
('1f03360468d373b5290fbc9b35255cac',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261663235313634323235316261373361313333623864396630333962376633316230363864633635223B733A343A2274696D65223B693A313738313635383634363B7D,'2026-06-18 08:10:46','2026-06-17 08:10:46','0','127.0.0.1','curl/8.14.1'),
('1f8fcbd9d8416c52521e2a1da5a754e3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230343431323761356639316436616165313635616133646461613266343839623462656136616264223B733A343A2274696D65223B693A313738313635363637303B7D,'2026-06-18 07:37:50','2026-06-17 07:37:50','0','127.0.0.1','curl/8.14.1'),
('1f9c01a80180b5a7d9d2400d65feb53a',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264336430616364383933646233646635363661623564313564613632623730356438356534326337223B733A343A2274696D65223B693A313738313635353337393B7D,'2026-06-18 07:16:19','2026-06-17 07:16:19','0','127.0.0.1','curl/8.14.1'),
('20f9789c4bd476956aabe775ee59f999',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238373364623037353338363535653338633538666562376639343335343432383933616662306631223B733A343A2274696D65223B693A313738313134373439313B7D,'2026-06-12 10:11:31','2026-06-11 10:11:31','0','127.0.0.1','curl/8.14.1'),
('23e191e8cd5d13bfd7342ac574c9abc0',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235633835373830656565326137383065353439343430366563636133326338396539313633323330223B733A343A2274696D65223B693A313738313635383433313B7D,'2026-06-18 08:07:12','2026-06-17 08:07:12','0','127.0.0.1','curl/8.14.1'),
('241933dacfa8292107bd19cc85b236ce',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262333564336338353366636263653266356662363039623133323563616334636539373332373333223B733A343A2274696D65223B693A313738313635343435363B7D,'2026-06-18 07:00:56','2026-06-17 07:00:56','0','127.0.0.1','curl/8.14.1'),
('244ef8c925c2182ec2b8ca700ca57f0c',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233316365626162346434393038323763323630643731376566353366653539306364663532656166223B733A343A2274696D65223B693A313738313635393437363B7D,'2026-06-18 08:24:36','2026-06-17 08:24:36','0','127.0.0.1','curl/8.14.1'),
('2486d53feee5cbf09a099f5d853be973',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235623936316662336638623561323032303065386461653061396437663162303530363662383232223B733A343A2274696D65223B693A313738313635343333333B7D,'2026-06-18 06:58:53','2026-06-17 06:58:53','0','127.0.0.1','curl/8.14.1'),
('24a6da4387dd9acef327f70221c84c1f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234653131343430636336623631643638396439646634386364666133303437383763616663306132223B733A343A2274696D65223B693A313738313134373631343B7D,'2026-06-12 10:13:34','2026-06-11 10:13:34','0','127.0.0.1','curl/8.14.1'),
('24ffea7538c60d1d87053f7fd6f7011b',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264613366623563646638653931643961343232326330643037383561343131663330616638643366223B733A343A2274696D65223B693A313738313635363931353B7D,'2026-06-18 07:41:55','2026-06-17 07:41:55','0','127.0.0.1','curl/8.14.1'),
('25c03b5209a8a2e92bb52e6767db0fa3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266656362626539343532396336326365386661616432623635616538663937623939663534633438223B733A343A2274696D65223B693A313738313635343534393B7D,'2026-06-18 07:02:29','2026-06-17 07:02:29','0','127.0.0.1','curl/8.14.1'),
('28e6a146de2754ec33cb0c9f2d9d9496',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264303264336630666239396534656333386661656231646665666637626538366236356236353231223B733A343A2274696D65223B693A313738313635373735353B7D,'2026-06-18 07:55:55','2026-06-17 07:55:55','0','127.0.0.1','curl/8.14.1'),
('29917a033e5a081d15b56ed7d7147d3e',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239356664613963353433313833653364613535396362393164323561643436393565316465353939223B733A343A2274696D65223B693A313738313635393633313B7D,'2026-06-18 08:27:11','2026-06-17 08:27:11','0','127.0.0.1','curl/8.14.1'),
('299879ee6a0aa75b49742c1c94c5cf8e',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2236626130386664666336346236366130366336343430316238616665393635343331363634633932223B733A343A2274696D65223B693A313738313134383031353B7D,'2026-06-12 10:20:15','2026-06-11 10:20:15','0','127.0.0.1','curl/8.14.1'),
('2c76d2bddefba4eedb2d88aeabf2a8d7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261326230353664656564653166656161313736316235623637613033666130613863336139643864223B733A343A2274696D65223B693A313738313635343631303B7D,'2026-06-18 07:03:30','2026-06-17 07:03:30','0','127.0.0.1','curl/8.14.1'),
('2f7867339f3dd3479d376c0ec48a6266',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262633061633066626566363035376666666633356262313661306265346162373163333939633164223B733A343A2274696D65223B693A313738313635383135353B7D,'2026-06-18 08:02:35','2026-06-17 08:02:35','0','127.0.0.1','curl/8.14.1'),
('301afea0bcd52c70e6507e129cd78dd0',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266623965323964323362353165373837393336346230646638393463353034313962323133316638223B733A343A2274696D65223B693A313738313635343736343B7D,'2026-06-18 07:06:04','2026-06-17 07:06:04','0','127.0.0.1','curl/8.14.1'),
('314750215526031d8d006bde9c45362c',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239316565373438343761376462663463636139643538333332643330616338646161643435333863223B733A343A2274696D65223B693A313738313635363739323B7D,'2026-06-18 07:39:52','2026-06-17 07:39:52','0','127.0.0.1','curl/8.14.1'),
('3208274be2cead3dca48a05dade878e1',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235356431666439626561383262396436343663306235636138343266353432346530393931336561223B733A343A2274696D65223B693A313738313635363330313B7D,'2026-06-18 07:31:41','2026-06-17 07:31:41','0','127.0.0.1','curl/8.14.1'),
('33577efe5a8ff2f3ee5210185cd55b36',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238306635323233663632393736373336353339626465326562336333653935346231336665343539223B733A343A2274696D65223B693A313738313635363936353B7D,'2026-06-18 07:42:45','2026-06-17 07:42:45','0','127.0.0.1','curl/8.14.1'),
('33b5cf6330ee41f6127a005221908a98',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231623662623566633466636239353831323761383739303533346332333432646435656233323264223B733A343A2274696D65223B693A313738313635383631353B7D,'2026-06-18 08:10:15','2026-06-17 08:10:15','0','127.0.0.1','curl/8.14.1'),
('344ec4a73ec3b3bc662fc41f0cac2b7d',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238336232383830656364356435636266633233646462353236353530326635626632363661326235223B733A343A2274696D65223B693A313738313635343931373B7D,'2026-06-18 07:08:37','2026-06-17 07:08:37','0','127.0.0.1','curl/8.14.1'),
('351330799d7a2154fc3d4ba44b23afcd',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234636338366238343661636337333032633464653730386435626531636531373533623130333862223B733A343A2274696D65223B693A313738313635353037303B7D,'2026-06-18 07:11:10','2026-06-17 07:11:10','0','127.0.0.1','curl/8.14.1'),
('35c11bc8bbab6e26d1a4ab04373a0b79',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238633863396638303939383536326563623634356162613531326365333635666338663532663261223B733A343A2274696D65223B693A313738313635343339353B7D,'2026-06-18 06:59:55','2026-06-17 06:59:55','0','127.0.0.1','curl/8.14.1'),
('365021874baf435a2a86c8e60d0cf1f9',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234343935303466336635626536323638363936633533656562646539316237393562633231666532223B733A343A2274696D65223B693A313738313134373339393B7D,'2026-06-12 10:09:59','2026-06-11 10:09:59','0','127.0.0.1','curl/8.14.1'),
('386861ebb6d0728915da7658c4d625e4',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2263363362616437306538366538383563396239653730613562306438396364366364336331306463223B733A343A2274696D65223B693A313738313635393630303B7D,'2026-06-18 08:26:40','2026-06-17 08:26:40','0','127.0.0.1','curl/8.14.1'),
('392c1ff738ce42cd3f5dc740233bcb77',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231303836366337663837366463343931613734653538393632663130313463653831303931626333223B733A343A2274696D65223B693A313738313134373538333B7D,'2026-06-12 10:13:03','2026-06-11 10:13:03','0','127.0.0.1','curl/8.14.1'),
('3a4fed740818099dac6508ff9d47671e',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238626266353038346439313537353761656530376234613037653732653565393262313465383836223B733A343A2274696D65223B693A313738313635393834373B7D,'2026-06-18 08:30:47','2026-06-17 08:30:47','0','127.0.0.1','curl/8.14.1'),
('3be61f99f550dd52b9ef1d74deb87876',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233356262653430343062336237353163613662316633356636343531333338636437333634616330223B733A343A2274696D65223B693A313738313635353834303B7D,'2026-06-18 07:24:00','2026-06-17 07:24:00','0','127.0.0.1','curl/8.14.1'),
('3d022799e17bfe019c38b572350afe84',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233373836323339386537643430316164643938646662643930303364646636366238623361393337223B733A343A2274696D65223B693A313738313134383130373B7D,'2026-06-12 10:21:47','2026-06-11 10:21:47','0','127.0.0.1','curl/8.14.1'),
('3e5901b379975ba03d1d057672013653',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232363766653363633532316263656337653032333033333165616138663563653064653762393930223B733A343A2274696D65223B693A313738313635393837383B7D,'2026-06-18 08:31:18','2026-06-17 08:31:18','0','127.0.0.1','curl/8.14.1'),
('3fd98fe76f20a5e5e342c0f0e7691815',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265356232386266316265313337663164663139326636653638663137363563616139326437353365223B733A343A2274696D65223B693A313738313635363630383B7D,'2026-06-18 07:36:48','2026-06-17 07:36:48','0','127.0.0.1','curl/8.14.1'),
('410b2893aae00f9283b171b22f57d9c3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232626239633862626566306161666363333439643236336333616563396666356539623930623336223B733A343A2274696D65223B693A313738313635353030393B7D,'2026-06-18 07:10:09','2026-06-17 07:10:09','0','127.0.0.1','curl/8.14.1'),
('434e1b6bf4b2e347076a97726359c7be',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261626132393066633032333533666435373565663739613938396639346264613838633462656331223B733A343A2274696D65223B693A313738313635393133373B7D,'2026-06-18 08:18:57','2026-06-17 08:18:57','0','127.0.0.1','curl/8.14.1'),
('43d4348535eca5fa3429f1a843a79a69',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237303632396366323465393739663463373763313261663265313865333230323565316439356363223B733A343A2274696D65223B693A313738313635353232353B7D,'2026-06-18 07:13:45','2026-06-17 07:13:45','0','127.0.0.1','curl/8.14.1'),
('45a25147962562fb7042691f448425ed',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230396261636466336165393261663035326332633464303933643462616561316165303765613634223B733A343A2274696D65223B693A313738313134373336393B7D,'2026-06-12 10:09:29','2026-06-11 10:09:29','0','127.0.0.1','curl/8.14.1'),
('46152ed6217b5fd4e1b82bc41938ffd3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231666665616563373138396337333861353235633766383032363636613937333463393161346163223B733A343A2274696D65223B693A313738313635363137383B7D,'2026-06-18 07:29:38','2026-06-17 07:29:38','0','127.0.0.1','curl/8.14.1'),
('461727bfe90b2f6a323c8a190cb0dcb7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235613734313935623732373437666530663036326637383234353838613434303665336562643236223B733A343A2274696D65223B693A313738313635363736323B7D,'2026-06-18 07:39:22','2026-06-17 07:39:22','0','127.0.0.1','curl/8.14.1'),
('46af59b6af1cb13a09917eb997f2e5bc',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231396231373231616537626662353362353863336665663563356462393135323832663961323539223B733A343A2274696D65223B693A313738313134373532313B7D,'2026-06-12 10:12:01','2026-06-11 10:12:01','0','127.0.0.1','curl/8.14.1'),
('46d29cade53bf7530bb6b6f03bc481cd',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232663030323561376133633830386563636361633133616239643537333137366230616236373362223B733A343A2274696D65223B693A313738313134373839313B7D,'2026-06-12 10:18:11','2026-06-11 10:18:11','0','127.0.0.1','curl/8.14.1'),
('47baf730c06d9134a4d83832595b6f31',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265663137393361336333643835323133383165643738636234653761373662323862316231663661223B733A343A2274696D65223B693A313738313636303334313B7D,'2026-06-18 08:39:01','2026-06-17 08:39:01','0','127.0.0.1','curl/8.14.1'),
('4889e007110dd3b3c4047d2f9dda0409',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239646132326464623533313261666533333265376664383638313932343163613431393466363432223B733A343A2274696D65223B693A313738313635363032353B7D,'2026-06-18 07:27:05','2026-06-17 07:27:05','0','127.0.0.1','curl/8.14.1'),
('498b09418ab0c3905c737922c49d1959',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230633134346462323863336133306163633831396462653563616530653938643465343734363537223B733A343A2274696D65223B693A313738313635343637323B7D,'2026-06-18 07:04:32','2026-06-17 07:04:32','0','127.0.0.1','curl/8.14.1'),
('4bb1c894f97d99e518bfd81b5779dfc1',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262653839656333633530643862356531313661626564376133646361656563333665396133356364223B733A343A2274696D65223B693A313738313635353539343B7D,'2026-06-18 07:19:54','2026-06-17 07:19:54','0','127.0.0.1','curl/8.14.1'),
('4c260e4cbce7301fbba0d34ff8750232',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264613637663931623537346631393663336233636166386136646530303330393732316330643164223B733A343A2274696D65223B693A313738313636303039343B7D,'2026-06-18 08:34:54','2026-06-17 08:34:54','0','127.0.0.1','curl/8.14.1'),
('4d88da61dab522cc0664bae5c1902688',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239363631376231353031323735643134373830363866616261626533616462626666613266346633223B733A343A2274696D65223B693A313738313635383938343B7D,'2026-06-18 08:16:24','2026-06-17 08:16:24','0','127.0.0.1','curl/8.14.1'),
('4db9558a06abd3554b8301641cf9aef8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238363336396566306538336437636439653234613337386462373935633265323462373139356530223B733A343A2274696D65223B693A313738313635393536393B7D,'2026-06-18 08:26:09','2026-06-17 08:26:09','0','127.0.0.1','curl/8.14.1'),
('4e4535c809ce7609884d383c4c220a02',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262333062633538643730636439383762343331623531333163623734663436386634643433626135223B733A343A2274696D65223B693A313738313635383538353B7D,'2026-06-18 08:09:45','2026-06-17 08:09:45','0','127.0.0.1','curl/8.14.1'),
('4e8df734769bf473c98d336f49cbf087',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234393362386333363238306466303565343163303166636466343732306135323965653937653563223B733A343A2274696D65223B693A313738313635353033393B7D,'2026-06-18 07:10:39','2026-06-17 07:10:39','0','127.0.0.1','curl/8.14.1'),
('505ac9780b5a4e5b8915fec1d67f3314',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237336565666462313131333634656661313332666265623439653333303737326664633535373331223B733A343A2274696D65223B693A313738313635393738353B7D,'2026-06-18 08:29:45','2026-06-17 08:29:45','0','127.0.0.1','curl/8.14.1'),
('50b350d64e636600e91d7bbb8b61dcae',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261343266346165346334373134363238373732336365316264626463643037366561363061323434223B733A343A2274696D65223B693A313738313635393636323B7D,'2026-06-18 08:27:42','2026-06-17 08:27:42','0','127.0.0.1','curl/8.14.1'),
('517e9864a4794475157e323d461b1a29',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2236653839313132313063393561643535333037373064633734646331316331646331336636323335223B733A343A2274696D65223B693A313738313635363038363B7D,'2026-06-18 07:28:06','2026-06-17 07:28:06','0','127.0.0.1','curl/8.14.1'),
('51d71821f95637dba2d23da85ff5528f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262383262626633616234356465373732303930643433656664383034363632643939333465343539223B733A343A2274696D65223B693A313738313134373736373B7D,'2026-06-12 10:16:08','2026-06-11 10:16:08','0','127.0.0.1','curl/8.14.1'),
('52a49d20d37e7d0cf09264c54297da87',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262306435633234663564656331623031303739653539336133613235346133386135343239643234223B733A343A2274696D65223B693A313738313635363832333B7D,'2026-06-18 07:40:23','2026-06-17 07:40:23','0','127.0.0.1','curl/8.14.1'),
('53ed4f534febab11df4db191dcf7fc0b',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266303233343236623136616139363036626136353064306261326439663533323438383965623962223B733A343A2274696D65223B693A313738313134383236323B7D,'2026-06-12 10:24:22','2026-06-11 10:24:22','0','127.0.0.1','curl/8.14.1'),
('5426ce8e78d463281534d65eb598d7b5',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261653764653234373932623130343938666233343631353430373639653766383638383363643264223B733A343A2274696D65223B693A313738313134383034353B7D,'2026-06-12 10:20:45','2026-06-11 10:20:45','0','127.0.0.1','curl/8.14.1'),
('55897c0839dd0564aa642b38b6f25e7e',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262383366353534636332336335643536323338613336353265626631616464396361623937653061223B733A343A2274696D65223B693A313738313635383736393B7D,'2026-06-18 08:12:49','2026-06-17 08:12:49','0','127.0.0.1','curl/8.14.1'),
('56a99c42063d77699494640643d852d7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232636530616365303636356631653730633432353961336131393238643962653232663065633030223B733A343A2274696D65223B693A313738313635383136393B7D5F617574687C613A313A7B733A343A2275736572223B4E3B7D,'2026-06-18 06:55:48','2026-06-17 08:02:49','0','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
('5957adfb5c2d527109561166780b203d',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235366166663937333937663261373430613631646535373265373136646134373730643732643562223B733A343A2274696D65223B693A313738313635393232393B7D,'2026-06-18 08:20:29','2026-06-17 08:20:29','0','127.0.0.1','curl/8.14.1'),
('596bc816cab563cacd852071f8f14ac4',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265636531393564663330303337633834346535313837343063333766363762616165396262313538223B733A343A2274696D65223B693A313738313635373837373B7D,'2026-06-18 07:57:57','2026-06-17 07:57:57','0','127.0.0.1','curl/8.14.1'),
('599cb7b019b099fbc7602e40d4911212',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231383162366338333439663031353863666262353938363336353632383933383436666532353864223B733A343A2274696D65223B693A313738313635383132343B7D,'2026-06-18 08:02:04','2026-06-17 08:02:04','0','127.0.0.1','curl/8.14.1'),
('5a1fb40522ee47d1b04778d7cc77f33e',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238373431653762363034336530666632663837663439343436333464383131336433376537633264223B733A343A2274696D65223B693A313738313134383133383B7D,'2026-06-12 10:22:18','2026-06-11 10:22:18','0','127.0.0.1','curl/8.14.1'),
('5c082c1e7130f99acd94e201658a9482',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2263373833383137613336643965636466666562323536303537626636653831643265646663313662223B733A343A2274696D65223B693A313738313635363333323B7D,'2026-06-18 07:32:12','2026-06-17 07:32:12','0','127.0.0.1','curl/8.14.1'),
('5c4d059d8aedabaf1ff1104d9b22afc8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233353565363530663033306263343739623138333538633637653166303830626566646639643165223B733A343A2274696D65223B693A313738313635363534373B7D,'2026-06-18 07:35:47','2026-06-17 07:35:47','0','127.0.0.1','curl/8.14.1'),
('5d264fde68bf38e757fa0b9ec6c8b9a7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235393735393933626538353762363237623531306363663435623730396332633030643236626131223B733A343A2274696D65223B693A313738313635353939343B7D,'2026-06-18 07:26:34','2026-06-17 07:26:34','0','127.0.0.1','curl/8.14.1'),
('5d7dd51a42bc68e3ba4d647ed71a3da0',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233323763396635336665343633303932636437306237653631393038653233626261353565356532223B733A343A2274696D65223B693A313738313635383839323B7D,'2026-06-18 08:14:52','2026-06-17 08:14:52','0','127.0.0.1','curl/8.14.1'),
('61a512fc86f317c54bc4d0204768656f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238353661653137356138383665663264333038333962643833396338633765346132356562333438223B733A343A2274696D65223B693A313738313636303132353B7D,'2026-06-18 08:35:25','2026-06-17 08:35:25','0','127.0.0.1','curl/8.14.1'),
('624e717945d574bd624ad318e024c9bc',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262316232646365316433323164396230316539346139663834613166636637363133393331386362223B733A343A2274696D65223B693A313738313635383739393B7D,'2026-06-18 08:13:19','2026-06-17 08:13:19','0','127.0.0.1','curl/8.14.1'),
('63e72dd362a274c62aec1f9db8ac535e',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237646365626262663638613834336231363539336631353164316162656435316539333234646631223B733A343A2274696D65223B693A313738313635353830393B7D,'2026-06-18 07:23:29','2026-06-17 07:23:29','0','127.0.0.1','curl/8.14.1'),
('64a114b92d6ac4af9153e35cb9269372',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232333233373865353634373332616233616161383336653537343432333165646439363036636166223B733A343A2274696D65223B693A313738313635373239353B7D,'2026-06-18 07:48:15','2026-06-17 07:48:15','0','127.0.0.1','curl/8.14.1'),
('64ab2f7f0082322e0d628b01276189e2',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265633065343435373133613838643438323334336632333932306439333362373861353066633236223B733A343A2274696D65223B693A313738313635363939363B7D,'2026-06-18 07:43:16','2026-06-17 07:43:16','0','127.0.0.1','curl/8.14.1'),
('65a14fa07886e3eec947d6a5e3165765',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239373939363230333139343561366633383932613135383232396661623463633163383364376166223B733A343A2274696D65223B693A313738313635343330323B7D,'2026-06-18 06:58:22','2026-06-17 06:58:22','0','127.0.0.1','curl/8.14.1'),
('660a5dffbe6aa3993cf7d13b0b46b370',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266386135656135626532653138326434313465393564633530336465356565363865396336353634223B733A343A2274696D65223B693A313738313635343531383B7D,'2026-06-18 07:01:58','2026-06-17 07:01:58','0','127.0.0.1','curl/8.14.1'),
('67f071cf357caedc3001133d82efc751',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262353865383161333866323136363632353863343566386137363036616366303232373139306564223B733A343A2274696D65223B693A313738313635353536333B7D,'2026-06-18 07:19:23','2026-06-17 07:19:23','0','127.0.0.1','curl/8.14.1'),
('68416b9c6784be76cd217294dcdb81ea',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2263383532306339663364393264633636373865373236373131346464653634343866666334366134223B733A343A2274696D65223B693A313738313635383039333B7D,'2026-06-18 08:01:33','2026-06-17 08:01:33','0','127.0.0.1','curl/8.14.1'),
('69b2eecaac5b57e4fbde015e62f23c86',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238333266336239386162353064303634383563333837383262633461666532356631303735303836223B733A343A2274696D65223B693A313738313635363838343B7D,'2026-06-18 07:41:24','2026-06-17 07:41:24','0','127.0.0.1','curl/8.14.1'),
('6a0095d093374be332bbabbfda350b38',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262353435363066333565653165623732313831626136306337393439643137373736356135313862223B733A343A2274696D65223B693A313738313635383439333B7D,'2026-06-18 08:08:13','2026-06-17 08:08:13','0','127.0.0.1','curl/8.14.1'),
('6a1c215207cb646023fc9441150fceaa',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265656239386333656232353735383466363163313838663866366337636638346464663430346565223B733A343A2274696D65223B693A313738313635343730323B7D,'2026-06-18 07:05:02','2026-06-17 07:05:02','0','127.0.0.1','curl/8.14.1'),
('6a80821aaf4da7fb280e8aa3852b4c32',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231383166313238363636363639393732663263353664303333623837363336313537666333626532223B733A343A2274696D65223B693A313738313635343733333B7D,'2026-06-18 07:05:33','2026-06-17 07:05:33','0','127.0.0.1','curl/8.14.1'),
('6fb881c66598a2eaae468eb9c6017864',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239656334393138303636306437383533373330623333313331326564306266616662653135386333223B733A343A2274696D65223B693A313738313635353837313B7D,'2026-06-18 07:24:31','2026-06-17 07:24:31','0','127.0.0.1','curl/8.14.1'),
('710ca6017e99152a946a8c3e88ddafad',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261316333366530663939316361666135666164313461346336323061646537636632383939643166223B733A343A2274696D65223B693A313738313635373236343B7D,'2026-06-18 07:47:44','2026-06-17 07:47:44','0','127.0.0.1','curl/8.14.1'),
('7160649f5acd3abc32726205fbb7f97a',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239343434643832383137666663653435656232336634393232313761386335343766356638316230223B733A343A2274696D65223B693A313738313635373633323B7D,'2026-06-18 07:53:52','2026-06-17 07:53:52','0','127.0.0.1','curl/8.14.1'),
('7435f6d790e69ead1a9a1fed662a202d',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233396563343834623665616434306535333165373964343832313862636463313337333731643938223B733A343A2274696D65223B693A313738313635373639333B7D,'2026-06-18 07:54:53','2026-06-17 07:54:53','0','127.0.0.1','curl/8.14.1'),
('74934d714fef2207145d81f045ea6f2d',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231636461656337343434356230323666663465363133343037353561373531323761326265396637223B733A343A2274696D65223B693A313738313635373338373B7D,'2026-06-18 07:49:47','2026-06-17 07:49:47','0','127.0.0.1','curl/8.14.1'),
('766d013c2447d50bc42aadb8f86703a8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234363131383936326437326465626432626631393866323337613030373165643566346331613866223B733A343A2274696D65223B693A313738313635373738353B7D,'2026-06-18 07:56:25','2026-06-17 07:56:25','0','127.0.0.1','curl/8.14.1'),
('7676b5fab187e63f97644e765a0f64a7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230653663303037656631356666616438666638353862303732396563373235663435333537656563223B733A343A2274696D65223B693A313738313635343137383B7D,'2026-06-18 06:56:18','2026-06-17 06:56:18','0','127.0.0.1','curl/8.14.1'),
('78c3e8d3520e36e8874eb135d2982aaf',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238333265383630323739653034323561303236356139663133633561373331636466666166653162223B733A343A2274696D65223B693A313738313635383733383B7D,'2026-06-18 08:12:18','2026-06-17 08:12:18','0','127.0.0.1','curl/8.14.1'),
('794813243576188158cc278cfa472892',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261643430396334306263613533303239656463346464663030396262343230383662613838643235223B733A343A2274696D65223B693A313738313635363134373B7D,'2026-06-18 07:29:07','2026-06-17 07:29:07','0','127.0.0.1','curl/8.14.1'),
('79f99f26d0a38c4fae2ce55373fcf910',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264646630646231666461613435333635326238363566633062343839626431303665363439323134223B733A343A2274696D65223B693A313738313636303237393B7D,'2026-06-18 08:37:59','2026-06-17 08:37:59','0','127.0.0.1','curl/8.14.1'),
('7d48a72209d15c5138cde6e7a1fcb181',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235623133626661643938323330326439353964643036396230653764336634386165386565666461223B733A343A2274696D65223B693A313738313134373932323B7D,'2026-06-12 10:18:42','2026-06-11 10:18:42','0','127.0.0.1','curl/8.14.1'),
('8245108109fad4ff297e03d5fe1d75e3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266326237306562323339396635653361333761373730636339393830663035396361656637666336223B733A343A2274696D65223B693A313738313635383036323B7D,'2026-06-18 08:01:02','2026-06-17 08:01:02','0','127.0.0.1','curl/8.14.1'),
('835c40656eeeadced91edbdf46bb1858',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232616432326565343332636637373439313736383661333239663138613131363934313364623438223B733A343A2274696D65223B693A313738313635363537373B7D,'2026-06-18 07:36:17','2026-06-17 07:36:17','0','127.0.0.1','curl/8.14.1'),
('88df83921bf2e4e4814036ac29cc9fdf',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231623666316364373136353561326332313331373964623438623937343631323036373466336332223B733A343A2274696D65223B693A313738313635363733313B7D,'2026-06-18 07:38:51','2026-06-17 07:38:51','0','127.0.0.1','curl/8.14.1'),
('89078cbdd00b7077fa1ccb042748a839',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261653736346665663662656264623163336262633931356333363432656165383937356334383065223B733A343A2274696D65223B693A313738313635393735343B7D,'2026-06-18 08:29:14','2026-06-17 08:29:14','0','127.0.0.1','curl/8.14.1'),
('897d99a583db9c0163f818f45279e394',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231393262323536633063353033666435353261623633343464366536646533353337316532656463223B733A343A2274696D65223B693A313738313635363730303B7D,'2026-06-18 07:38:20','2026-06-17 07:38:20','0','127.0.0.1','curl/8.14.1'),
('8bc3e3d0a41db69b18a3229725b9213f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234633030396433353632626566393038323565363430323437393837396533616661386266373330223B733A343A2274696D65223B693A313738313635393338333B7D,'2026-06-18 08:23:03','2026-06-17 08:23:03','0','127.0.0.1','curl/8.14.1'),
('8bcd378a1e3101da9bcbdde30b4b3858',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235326137636361356665343737326338636130336333666330363830396231666364643432613036223B733A343A2274696D65223B693A313738313636303030313B7D,'2026-06-18 08:33:21','2026-06-17 08:33:21','0','127.0.0.1','curl/8.14.1'),
('8dbb6c0cebbdedbe24c150597a081910',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230363466396362353239656234316235363239643438653533333164613036356635373639633661223B733A343A2274696D65223B693A313738313635383532343B7D,'2026-06-18 08:08:44','2026-06-17 08:08:44','0','127.0.0.1','curl/8.14.1'),
('8ebdbac44170526dd5802784e64b54d3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234383264666438383563373761373433313266363236336132383330343934656631616130396138223B733A343A2274696D65223B693A313738313635353130313B7D,'2026-06-18 07:11:41','2026-06-17 07:11:41','0','127.0.0.1','curl/8.14.1'),
('8f6bbf37709b5fc6ce8971adda0bc0cc',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238363434323264666338316335336564386234666234383966316366626537333461343831323035223B733A343A2274696D65223B693A313738313635353635353B7D,'2026-06-18 07:20:55','2026-06-17 07:20:55','0','127.0.0.1','curl/8.14.1'),
('9159e1d929ecd0c38963c1a64e3d80a1',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230393430633764366334616236376233383134646262323733316531636537386564343566366436223B733A343A2274696D65223B693A313738313635393930383B7D,'2026-06-18 08:31:48','2026-06-17 08:31:48','0','127.0.0.1','curl/8.14.1'),
('9167df273d0cece5ca7479b068ec8e41',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234356439333838393062653137633136643532366430616536643633643765336666343130653331223B733A343A2274696D65223B693A313738313635353437313B7D,'2026-06-18 07:17:51','2026-06-17 07:17:51','0','127.0.0.1','curl/8.14.1'),
('9197fa215daf6d088ad833f5f9a5dd39',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262333237383934653734626236323766353465633563373363376662353666353836313235303130223B733A343A2274696D65223B693A313738313635373630313B7D,'2026-06-18 07:53:21','2026-06-17 07:53:21','0','127.0.0.1','curl/8.14.1'),
('919e8bf0951a389f7c2ddde3cf2b2537',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231336366333162386164376436356233326163613563643335366431353331656232323565373863223B733A343A2274696D65223B693A313738313134373836303B7D,'2026-06-12 10:17:40','2026-06-11 10:17:40','0','127.0.0.1','curl/8.14.1'),
('92e3bebace370b8a1e08cefe0af3256b',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264333439613266356531623535653564623164333432326234353339616233323665653032663466223B733A343A2274696D65223B693A313738313635343237313B7D,'2026-06-18 06:57:51','2026-06-17 06:57:51','0','127.0.0.1','curl/8.14.1'),
('9456cc40d13e1969d0e2766fa7913000',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234623862646535333533386530656538313036653261346263656437626530303231313632633462223B733A343A2274696D65223B693A313738313635393236303B7D,'2026-06-18 08:21:00','2026-06-17 08:21:00','0','127.0.0.1','curl/8.14.1'),
('94a5b481b5056f32ec49d9eaac5d095c',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234373930363036396636386661633537653030353765663730623836663037656337333366383530223B733A343A2274696D65223B693A313738313635353731363B7D,'2026-06-18 07:21:56','2026-06-17 07:21:56','0','127.0.0.1','curl/8.14.1'),
('9774d20fc43b9ed1678534cdd833f374',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232653637383561386139643633326635346136353438346466316134666462323335663864366133223B733A343A2274696D65223B693A313738313635373137323B7D,'2026-06-18 07:46:12','2026-06-17 07:46:12','0','127.0.0.1','curl/8.14.1'),
('989086c5b2159b713feadf0eaefa2908',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264393865666237613562336233386662636134383133306233396666386562356232373165626362223B733A343A2274696D65223B693A313738313635353334383B7D,'2026-06-18 07:15:49','2026-06-17 07:15:49','0','127.0.0.1','curl/8.14.1'),
('98fc72548845c1ac17d7f929aa80e369',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232363135336535656461343565333064366466656138396365623963653763346562376235626236223B733A343A2274696D65223B693A313738313636303231383B7D,'2026-06-18 08:36:58','2026-06-17 08:36:58','0','127.0.0.1','curl/8.14.1'),
('99c87f5e1a7b1be5edac5546afc46427',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234383135393833626161363966393139343539306164656264626638383433333039346663316266223B733A343A2274696D65223B693A313738313635343934373B7D,'2026-06-18 07:09:07','2026-06-17 07:09:07','0','127.0.0.1','curl/8.14.1'),
('9a2267715e9ddf24cc1d0b998f2cbdca',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233333137376364336536396336326135666432356264656430326131363738363730386465663765223B733A343A2274696D65223B693A313738313635393034353B7D,'2026-06-18 08:17:25','2026-06-17 08:17:25','0','127.0.0.1','curl/8.14.1'),
('9b8094a0810b00733b3e91e33acb2150',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266313761613035313836353966666632663435613832333239373936386238363833656165306334223B733A343A2274696D65223B693A313738313134373231343B7D,'2026-06-12 10:06:54','2026-06-11 10:06:54','0','127.0.0.1','curl/8.14.1'),
('9be0257522503c90ed632de8f59e0c51',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234663564313837343365626665376163303864633939386436393338643461616565356238376636223B733A343A2274696D65223B693A313738313635353133323B7D,'2026-06-18 07:12:12','2026-06-17 07:12:12','0','127.0.0.1','curl/8.14.1'),
('9bf3000438d0fc7a2e80528a9cd9d00f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232623932656533356638303132653633633239636365346363643063323164356130343038306139223B733A343A2274696D65223B693A313738313635353238373B7D,'2026-06-18 07:14:47','2026-06-17 07:14:47','0','127.0.0.1','curl/8.14.1'),
('a08b861d9aacd43bbcd4539351802693',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233633736376435363732373366386238386263303666616361323532393637323131343433616161223B733A343A2274696D65223B693A313738313134373739383B7D,'2026-06-12 10:16:38','2026-06-11 10:16:38','0','127.0.0.1','curl/8.14.1'),
('a23507a38ae06f2dd66033d756198227',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264656565333566333531313637646131666239356439396633663239643337323061383737343538223B733A343A2274696D65223B693A313738313635363432343B7D,'2026-06-18 07:33:44','2026-06-17 07:33:44','0','127.0.0.1','curl/8.14.1'),
('a4059b0400c6817648dd13f5db3117da',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266303762623361616131363137386166613139346164336263666262326365313239623066353333223B733A343A2274696D65223B693A313738313134373330373B7D,'2026-06-12 10:08:27','2026-06-11 10:08:27','0','127.0.0.1','curl/8.14.1'),
('a52a499982be1087dc1557144b6801ba',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262393239366363306161313532376134303434623363303435373461373638346531313638333530223B733A343A2274696D65223B693A313738313635363633393B7D,'2026-06-18 07:37:19','2026-06-17 07:37:19','0','127.0.0.1','curl/8.14.1'),
('a5cf122fad92e9b62bea6d1ddb5943df',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266346364656637316133313562633732383139343339653664363232313939376564303436653963223B733A343A2274696D65223B693A313738313636303234383B7D,'2026-06-18 08:37:28','2026-06-17 08:37:28','0','127.0.0.1','curl/8.14.1'),
('a7903e6618a1339d24449de46413f8ce',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232343537303862323637343835383737376265656231396463326531313433366366363730353133223B733A343A2274696D65223B693A313738313635343838363B7D,'2026-06-18 07:08:06','2026-06-17 07:08:06','0','127.0.0.1','curl/8.14.1'),
('a7f615ee458e24dec87c6d72bfbe3bf5',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231303333373662353435653831666462363437613166626337303035396164366465373137633562223B733A343A2274696D65223B693A313738313635353632353B7D,'2026-06-18 07:20:25','2026-06-17 07:20:25','0','127.0.0.1','curl/8.14.1'),
('a8a40e529c89d0c8d0555bce694d75fc',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234663163653931653237363835343138666630363364306338313564383538343562613037373232223B733A343A2274696D65223B693A313738313134373832393B7D,'2026-06-12 10:17:09','2026-06-11 10:17:09','0','127.0.0.1','curl/8.14.1'),
('ab8d9b7dec0c3477e527318c10a389f1',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230346663643936303336343031303165616431333965393436626563646566336539306464633638223B733A343A2274696D65223B693A313738313635343634313B7D,'2026-06-18 07:04:01','2026-06-17 07:04:01','0','127.0.0.1','curl/8.14.1'),
('abc1139b12436d4afa4abe7de79b20d3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2236626462323663613434316561633631343261383531366562346464633466306639333833323632223B733A343A2274696D65223B693A313738313635383935333B7D,'2026-06-18 08:15:53','2026-06-17 08:15:53','0','127.0.0.1','curl/8.14.1'),
('acf701b83f3e181d1510b7338dc8b2c6',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239333962353533343562356466646332383838623630376261666538626234343731616463393037223B733A343A2274696D65223B693A313738313635383237383B7D,'2026-06-18 08:04:38','2026-06-17 08:04:38','0','127.0.0.1','curl/8.14.1'),
('ae80e647f1ff6c3538a63730fc6de610',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262306561323561633962333266656430393837353932316639363465383634306166346361636135223B733A343A2274696D65223B693A313738313635383231373B7D,'2026-06-18 08:03:37','2026-06-17 08:03:37','0','127.0.0.1','curl/8.14.1'),
('af78c30abaf42205629a970a235e7bb5',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234316334323134346335613235633535343161333031653865636264323033636139636531633235223B733A343A2274696D65223B693A313738313635343538303B7D,'2026-06-18 07:03:00','2026-06-17 07:03:00','0','127.0.0.1','curl/8.14.1'),
('affd391cb3238ef6a16fc46ebba1dc94',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239353966636131663437653230633539393839386566303366653636303433373766306630363934223B733A343A2274696D65223B693A313738313134373632313B7D5F73746166667C613A313A7B733A343A2261757468223B613A323A7B733A343A2264657374223B733A31343A222F7363702F61646D696E2E706870223B733A333A226D7367223B733A32333A2241757468656E7469636174696F6E205265717569726564223B7D7D5F617574687C613A333A7B733A353A227374616666223B613A333A7B733A323A226964223B693A313B733A333A226B6579223B733A31343A226C6F63616C3A68656C706465736B223B733A333A22326661223B4E3B7D733A343A2275736572223B4E3B733A31313A22757365722D7469636B6574223B733A363A22363032313735223B7D3A746F6B656E7C613A323A7B733A353A227374616666223B733A37363A2231356465333665356532363134383764623933386162396538623530386632393A313738313134373632313A3362313431323735336634373563633936396333373233316464366561656132223B733A363A22636C69656E74223B733A37363A2236393165376162326533373936653635313236636665343231636539363032373A313738313134373433303A3362313431323735336634373563633936396333373233316464366561656132223B7D54494D455F424F4D427C693A313738313134393130343B6366673A636F72657C613A313A7B733A31313A2264625F74696D657A6F6E65223B733A31323A22417369612F4A616B61727461223B7D71636F756E74737C613A313A7B733A34383A22636F756E74732E7175657565732E312E58527373745A31735F69556545327A38613D6B4F36713734734F3738435A5361223B613A323A7B733A363A22636F756E7473223B613A31343A7B733A323A227131223B643A313B733A323A227132223B643A313B733A323A227136223B643A303B733A323A227139223B643A303B733A323A227133223B643A303B733A323A227137223B643A303B733A333A22713130223B643A303B733A323A227134223B643A303B733A323A227135223B643A303B733A333A22713131223B643A303B733A323A227138223B643A303B733A333A22713132223B643A303B733A333A22713133223B643A303B733A333A22713134223B643A303B7D733A343A2274696D65223B693A313738313134373238383B7D7D6C61737463726F6E63616C6C7C693A313738313134373439313B3A3A513A547C693A313B736F72747C613A313A7B693A313B613A323A7B733A393A227175657565736F7274223B4F3A393A225175657565536F7274223A373A7B733A323A226874223B613A353A7B733A323A226964223B693A313B733A343A22726F6F74223B4E3B733A343A226E616D65223B733A33323A225072696F72697479202B204D6F737420526563656E746C792055706461746564223B733A373A22636F6C756D6E73223B733A33343A225B222D63646174615F5F7072696F72697479222C222D6C617374757064617465225D223B733A373A2275706461746564223B733A31393A22323032362D30362D31312031303A30363A3334223B7D733A353A226469727479223B613A303A7B7D733A373A225F5F6E65775F5F223B623A303B733A31313A225F5F64656C657465645F5F223B623A303B733A31323A225F5F64656665727265645F5F223B613A303A7B7D733A383A225F636F6C756D6E73223B613A323A7B733A31353A2263646174615F5F7072696F72697479223B623A313B733A31303A226C617374757064617465223B623A313B7D733A363A225F6578747261223B4E3B7D733A333A22646972223B693A303B7D7D3A3A513A417C733A303A22223B3A51413A3A736F72747C613A323A7B693A303B733A373A2263726561746564223B693A313B693A303B7D3A513A7461736B737C4F3A383A225175657279536574223A31363A7B733A353A226D6F64656C223B733A343A225461736B223B733A31313A22636F6E73747261696E7473223B613A323A7B693A303B4F3A313A2251223A333A7B693A303B693A303B693A313B693A303B693A323B613A313A7B693A303B4F3A313A2251223A333A7B693A303B693A303B693A313B693A303B693A323B613A313A7B733A31333A22666C6167735F5F686173626974223B693A313B7D7D7D7D693A313B4F3A313A2251223A333A7B693A303B693A303B693A313B693A303B693A323B613A313A7B693A303B4F3A313A2251223A333A7B693A303B693A303B693A313B693A323B693A323B613A333A7B693A303B4F3A313A2251223A333A7B693A303B693A303B693A313B693A303B693A323B613A323A7B733A31333A22666C6167735F5F686173626974223B693A313B733A383A2273746166665F6964223B693A313B7D7D693A313B4F3A313A2251223A333A7B693A303B693A303B693A313B693A303B693A323B613A323A7B733A31363A227469636B65745F5F73746166665F6964223B693A313B733A32313A227469636B65745F5F7374617475735F5F7374617465223B733A343A226F70656E223B7D7D693A323B4F3A313A2251223A333A7B693A303B693A303B693A313B693A303B693A323B613A313A7B733A31313A22646570745F69645F5F696E223B613A333A7B693A303B693A313B693A313B693A323B693A323B693A333B7D7D7D7D7D7D7D7D733A31363A22706174685F636F6E73747261696E7473223B613A303A7B7D733A383A226F72646572696E67223B613A313A7B693A303B733A383A222D63726561746564223B7D733A373A2272656C61746564223B623A303B733A363A2276616C756573223B613A31343A7B733A323A226964223B733A323A226964223B733A363A226E756D626572223B733A363A226E756D626572223B733A373A2263726561746564223B733A373A2263726561746564223B733A383A2273746166665F6964223B733A383A2273746166665F6964223B733A373A22646570745F6964223B733A373A22646570745F6964223B733A373A227465616D5F6964223B733A373A227465616D5F6964223B733A31363A2273746166665F5F66697273746E616D65223B733A31363A2273746166665F5F66697273746E616D65223B733A31353A2273746166665F5F6C6173746E616D65223B733A31353A2273746166665F5F6C6173746E616D65223B733A31303A227465616D5F5F6E616D65223B733A31303A227465616D5F5F6E616D65223B733A31303A22646570745F5F6E616D65223B733A31303A22646570745F5F6E616D65223B733A31323A2263646174615F5F7469746C65223B733A31323A2263646174615F5F7469746C65223B733A353A22666C616773223B733A353A22666C616773223B733A31343A227469636B65745F5F6E756D626572223B733A31343A227469636B65745F5F6E756D626572223B733A31373A227469636B65745F5F7469636B65745F6964223B733A31373A227469636B65745F5F7469636B65745F6964223B7D733A353A226465666572223B613A303A7B7D733A31303A2261676772656761746564223B623A303B733A31313A22616E6E6F746174696F6E73223B613A333A7B733A31323A22636F6C6C61625F636F756E74223B4F3A31323A2253716C416767726567617465223A353A7B733A353A22616C696173223B733A31323A22636F6C6C61625F636F756E74223B733A343A2266756E63223B733A353A22434F554E54223B733A343A2265787072223B733A32313A227468726561645F5F636F6C6C61626F7261746F7273223B733A383A2264697374696E6374223B623A313B733A31303A22636F6E73747261696E74223B623A303B7D733A31363A226174746163686D656E745F636F756E74223B4F3A31323A2253716C416767726567617465223A353A7B733A353A22616C696173223B733A31363A226174746163686D656E745F636F756E74223B733A343A2266756E63223B733A353A22434F554E54223B733A343A2265787072223B4F3A373A2253716C43617365223A353A7B733A353A22616C696173223B4E3B733A353A226361736573223B613A313A7B693A303B613A323A7B693A303B4F3A383A2253716C4669656C64223A353A7B733A353A22616C696173223B4E3B733A383A226F70657261746F72223B4E3B733A383A226F706572616E6473223B4E3B733A353A226C6576656C223B693A303B733A353A226669656C64223B733A33363A227468726561645F5F656E74726965735F5F6174746163686D656E74735F5F696E6C696E65223B7D693A313B4E3B7D7D733A343A22656C7365223B4F3A383A2253716C4669656C64223A353A7B733A353A22616C696173223B4E3B733A383A226F70657261746F72223B4E3B733A383A226F706572616E6473223B4E3B733A353A226C6576656C223B693A303B733A353A226669656C64223B733A32383A227468726561645F5F656E74726965735F5F6174746163686D656E7473223B7D733A343A2266756E63223B733A343A2243415345223B733A343A2261726773223B613A303A7B7D7D733A383A2264697374696E6374223B623A313B733A31303A22636F6E73747261696E74223B623A303B7D733A31323A227468726561645F636F756E74223B4F3A31323A2253716C416767726567617465223A353A7B733A353A22616C696173223B733A31323A227468726561645F636F756E74223B733A343A2266756E63223B733A353A22434F554E54223B733A343A2265787072223B4F3A373A2253716C43617365223A353A7B733A353A22616C696173223B4E3B733A353A226361736573223B613A313A7B693A303B613A323A7B693A303B4F3A313A2251223A333A7B693A303B693A303B693A313B693A303B693A323B613A313A7B733A33303A227468726561645F5F656E74726965735F5F666C6167735F5F686173626974223B693A343B7D7D693A313B4E3B7D7D733A343A22656C7365223B4F3A383A2253716C4669656C64223A353A7B733A353A22616C696173223B4E3B733A383A226F70657261746F72223B4E3B733A383A226F706572616E6473223B4E3B733A353A226C6576656C223B693A303B733A353A226669656C64223B733A31393A227468726561645F5F656E74726965735F5F6964223B7D733A343A2266756E63223B733A343A2243415345223B733A343A2261726773223B613A303A7B7D7D733A383A2264697374696E6374223B623A313B733A31303A22636F6E73747261696E74223B623A303B7D7D733A353A226578747261223B613A303A7B7D733A383A2264697374696E6374223B613A303A7B7D733A343A226C6F636B223B623A303B733A353A22636861696E223B613A303A7B7D733A373A226F7074696F6E73223B613A303A7B7D733A343A2269746572223B693A323B733A383A22636F6D70696C6572223B733A31333A224D7953716C436F6D70696C6572223B7D3A513A75736572737C4F3A383A225175657279536574223A31363A7B733A353A226D6F64656C223B733A343A2255736572223B733A31313A22636F6E73747261696E7473223B613A303A7B7D733A31363A22706174685F636F6E73747261696E7473223B613A303A7B7D733A383A226F72646572696E67223B613A313A7B693A303B733A343A226E616D65223B7D733A373A2272656C61746564223B623A303B733A363A2276616C756573223B613A373A7B733A323A226964223B733A323A226964223B733A343A226E616D65223B733A343A226E616D65223B733A32323A2264656661756C745F656D61696C5F5F61646472657373223B733A32323A2264656661756C745F656D61696C5F5F61646472657373223B733A31313A226163636F756E745F5F6964223B733A31313A226163636F756E745F5F6964223B733A31353A226163636F756E745F5F737461747573223B733A31353A226163636F756E745F5F737461747573223B733A373A2263726561746564223B733A373A2263726561746564223B733A373A2275706461746564223B733A373A2275706461746564223B7D733A353A226465666572223B613A303A7B7D733A31303A2261676772656761746564223B623A303B733A31313A22616E6E6F746174696F6E73223B613A313A7B733A31323A227469636B65745F636F756E74223B4F3A31323A2253716C416767726567617465223A353A7B733A353A22616C696173223B733A31323A227469636B65745F636F756E74223B733A343A2266756E63223B733A353A22434F554E54223B733A343A2265787072223B733A373A227469636B657473223B733A383A2264697374696E6374223B623A303B733A31303A22636F6E73747261696E74223B623A303B7D7D733A353A226578747261223B613A303A7B7D733A383A2264697374696E6374223B613A303A7B7D733A343A226C6F636B223B623A303B733A353A22636861696E223B613A303A7B7D733A373A226F7074696F6E73223B613A303A7B7D733A343A2269746572223B693A323B733A383A22636F6D70696C6572223B733A31333A224D7953716C436F6D70696C6572223B7D3A6D7367737C613A303A7B7D,'2026-06-11 10:43:41','2026-06-11 10:13:41','1','172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
('b0ad81af99edb3a759c77936b3181065',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266383430616533383761653937396362653838616265663833653538353134626464366162383536223B733A343A2274696D65223B693A313738313134373637353B7D,'2026-06-12 10:14:35','2026-06-11 10:14:35','0','127.0.0.1','curl/8.14.1'),
('b0b337bb1a5874bd7b3a93f26fa46841',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262306236616131663663666265353231386230386664356537346264393662653962323932303633223B733A343A2274696D65223B693A313738313635363934363B7D,'2026-06-18 07:42:26','2026-06-17 07:42:26','0','127.0.0.1','curl/8.14.1'),
('b2c264dac954c6ac7ed69c0dc6bc599d',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234653162666432633536336565373661666665616530626364393939303662383239393838323766223B733A343A2274696D65223B693A313738313635353530323B7D,'2026-06-18 07:18:22','2026-06-17 07:18:22','0','127.0.0.1','curl/8.14.1'),
('b4b02dde329ff6fdce8083f86dc38902',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2236646532363464313136383139636537306233643966613534356264613264643364303831343361223B733A343A2274696D65223B693A313738313635383337303B7D,'2026-06-18 08:06:10','2026-06-17 08:06:10','0','127.0.0.1','curl/8.14.1'),
('b6310ac4b68a272bf652a856e2f4261d',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238643634393934383037373464633930363363376637646236376663643364663831656133323361223B733A343A2274696D65223B693A313738313635393130363B7D,'2026-06-18 08:18:26','2026-06-17 08:18:26','0','127.0.0.1','curl/8.14.1'),
('b7146a84c07ca709158b1ff4a2815bf3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265326532383333316136643966386139643037613363626234336332353763343138613531633736223B733A343A2274696D65223B693A313738313635383535343B7D,'2026-06-18 08:09:14','2026-06-17 08:09:14','0','127.0.0.1','curl/8.14.1'),
('b739eb6d0cab8dc581ec6a392850550c',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2236303232643966613731326535326338323439376261313766633363613531643362323366323362223B733A343A2274696D65223B693A313738313635383430313B7D,'2026-06-18 08:06:41','2026-06-17 08:06:41','0','127.0.0.1','curl/8.14.1'),
('b7bceb8c0526870751f33745375d162e',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235336133323261363064316339653537653137626338323930346134343831653463646235636362223B733A343A2274696D65223B693A313738313635373530393B7D,'2026-06-18 07:51:49','2026-06-17 07:51:49','0','127.0.0.1','curl/8.14.1'),
('b7ffd9340d083576809e7e8b389a9e3f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239303633656132346334643231346463393536373635653434613934666539323837316433663133223B733A343A2274696D65223B693A313738313635363835343B7D,'2026-06-18 07:40:54','2026-06-17 07:40:54','0','127.0.0.1','curl/8.14.1'),
('b881e5fba50637f0138cbd3b1de72fad',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239646638336231383539396263326434633530643461623962653633636335663431613033653539223B733A343A2274696D65223B693A313738313635393335323B7D,'2026-06-18 08:22:32','2026-06-17 08:22:32','0','127.0.0.1','curl/8.14.1'),
('b88f6b5afe674915e4f8855abe09c642',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266303161333738616634356461623861373936336361366235643539666332656236613562316461223B733A343A2274696D65223B693A313738313635353737383B7D,'2026-06-18 07:22:58','2026-06-17 07:22:58','0','127.0.0.1','curl/8.14.1'),
('bb48c79b281627e898b937e05fd1e9f5',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261346637323638626138353032396462353039666536323561386263313331653431656465636265223B733A343A2274696D65223B693A313738313134373333383B7D,'2026-06-12 10:08:58','2026-06-11 10:08:58','0','127.0.0.1','curl/8.14.1'),
('bb91114b91fc022d2b47dc82ed7a6a4b',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234653332303535656536613639666264313531323838666462336661363635366264623366393439223B733A343A2274696D65223B693A313738313635373233333B7D,'2026-06-18 07:47:13','2026-06-17 07:47:13','0','127.0.0.1','curl/8.14.1'),
('bc4b2482818066a63479ab8569743b58',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233666664326362656565363732643334616139313231633562613465623362306465343033323963223B733A343A2274696D65223B693A313738313635353936333B7D,'2026-06-18 07:26:03','2026-06-17 07:26:03','0','127.0.0.1','curl/8.14.1'),
('bcde9d7cbf063dcfa72dabb344e2c9cc',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232653434323264636339343134636362306539373236633666663661333432383235646263333034223B733A343A2274696D65223B693A313738313635383730373B7D,'2026-06-18 08:11:47','2026-06-17 08:11:47','0','127.0.0.1','curl/8.14.1'),
('bf028e240b5455b6a0b8fefd1b9c4548',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235373637376666336335653662363637303134383339633437366136396138656365633330356161223B733A343A2274696D65223B693A313738313635373834373B7D,'2026-06-18 07:57:27','2026-06-17 07:57:27','0','127.0.0.1','curl/8.14.1'),
('c1316ba24ec56b191fc5185b8269e747',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261623464383936353564356537306637396432643135336337613564633537646530396530383361223B733A343A2274696D65223B693A313738313635373831363B7D,'2026-06-18 07:56:56','2026-06-17 07:56:56','0','127.0.0.1','curl/8.14.1'),
('c2df363d1daf9e1763595f62f106ea31',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264316237636665376136316535353336363066663265393439636432383336373563653932353630223B733A343A2274696D65223B693A313738313635373035373B7D,'2026-06-18 07:44:17','2026-06-17 07:44:17','0','127.0.0.1','curl/8.14.1'),
('c2e872ea572fa4905aaac608719cf5c8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261316634366264626138613434643062656437353864656362333365666430373038363565376664223B733A343A2274696D65223B693A313738313635373038383B7D,'2026-06-18 07:44:48','2026-06-17 07:44:48','0','127.0.0.1','curl/8.14.1'),
('c30f460ab71dab024a86a8dd91cf26e6',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238393861366531346364326237313733313463626564323865636361626265646364363737323763223B733A343A2274696D65223B693A313738313636303138373B7D,'2026-06-18 08:36:27','2026-06-17 08:36:27','0','127.0.0.1','curl/8.14.1'),
('c481da943f5b332cf2caf0cb2ba793e9',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264333361336663396236633435633266616639653661656131353432336261396632663738646237223B733A343A2274696D65223B693A313738313134373730363B7D,'2026-06-12 10:15:06','2026-06-11 10:15:06','0','127.0.0.1','curl/8.14.1'),
('c5f6fbcec19beb468c04c7b170997ae8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262346137636439383835383631343038386635643132353064396536366365313663623432363561223B733A343A2274696D65223B693A313738313635373936393B7D,'2026-06-18 07:59:29','2026-06-17 07:59:29','0','127.0.0.1','curl/8.14.1'),
('c7d7e7cefe7a45ece7e3ed9713e3ae1f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238316332353338356530386532343939353263643437353566393736363633333037656564373032223B733A343A2274696D65223B693A313738313635383030303B7D,'2026-06-18 08:00:00','2026-06-17 08:00:00','0','127.0.0.1','curl/8.14.1'),
('c8407171fb353e25983e0b0d97e8a09f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238363437623830353430366536636663633833653166656364646662343435616432613538633034223B733A343A2274696D65223B693A313738313134383233313B7D,'2026-06-12 10:23:51','2026-06-11 10:23:51','0','127.0.0.1','curl/8.14.1'),
('c85f1bfc9372ec1615f1a8c6770ed6b7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237323561316433623663333530353431356131636366313336663439653166323839666530333666223B733A343A2274696D65223B693A313738313635343230393B7D,'2026-06-18 06:56:49','2026-06-17 06:56:49','0','127.0.0.1','curl/8.14.1'),
('c8d0cea25b5d8b9534a5c2128bd462ee',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2234376562653138343638303361313332333636656438333665613662393232663564353164636134223B733A343A2274696D65223B693A313738313635393639333B7D,'2026-06-18 08:28:13','2026-06-17 08:28:13','0','127.0.0.1','curl/8.14.1'),
('c9ad353d4b348bebbf04fcd8bff73759',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237373762343331623135316561316162613034306537373732666161303831386130383838343530223B733A343A2274696D65223B693A313738313635363438353B7D,'2026-06-18 07:34:45','2026-06-17 07:34:45','0','127.0.0.1','curl/8.14.1'),
('c9aece11b576bfe906621307f2c815e1',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239393232313439633436393939666434643630363239343037303565633038356466626362333036223B733A343A2274696D65223B693A313738313635343234313B7D,'2026-06-18 06:57:21','2026-06-17 06:57:21','0','127.0.0.1','curl/8.14.1'),
('c9f2debeb545de18e1340359335071e0',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262316633633036633062353032666430633535646463643030353038646339376231313432623538223B733A343A2274696D65223B693A313738313635393732343B7D,'2026-06-18 08:28:44','2026-06-17 08:28:44','0','127.0.0.1','curl/8.14.1'),
('ca32adcb1b7e61c5508d659fcc4cdfcf',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266353434376430643436656439316137336239643531313136643766323332346264616530646337223B733A343A2274696D65223B693A313738313134373433303B7D,'2026-06-12 10:10:30','2026-06-11 10:10:30','0','127.0.0.1','curl/8.14.1'),
('cc85c19c1e0052f68c1f7fa7252dfad8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261393832613531643837393034333439623266316665373934383331323634653337643861383362223B733A343A2274696D65223B693A313738313635373332353B7D,'2026-06-18 07:48:45','2026-06-17 07:48:45','0','127.0.0.1','curl/8.14.1'),
('cd4664225fc626ccb417e9785e496335',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230393738356566376632353032626261323531643838363037373534663164333934316562363363223B733A343A2274696D65223B693A313738313134383136393B7D,'2026-06-12 10:22:49','2026-06-11 10:22:49','0','127.0.0.1','curl/8.14.1'),
('cdca9eab68e745cf559ae0b0fbf20835',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266616330356134323139613766643235356665663131663466396363313531653731376537393532223B733A343A2274696D65223B693A313738313635373131393B7D,'2026-06-18 07:45:19','2026-06-17 07:45:19','0','127.0.0.1','curl/8.14.1'),
('cf1e3b5eddea9820a1d08f05a8c02ef5',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233666131326264333830306437626332306334343439376637323233346564643435336635333831223B733A343A2274696D65223B693A313738313635393332313B7D,'2026-06-18 08:22:01','2026-06-17 08:22:01','0','127.0.0.1','curl/8.14.1'),
('cf9c12936cd42487af0edb53547362ec',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230653834373865663238393661613135663232633630646637386161656366363364313530383436223B733A343A2274696D65223B693A313738313635343835363B7D,'2026-06-18 07:07:36','2026-06-17 07:07:36','0','127.0.0.1','curl/8.14.1'),
('d1e98ccdf4b90769ffa51be27f13d5c6',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237623866336362663661613863323936323465653634643039626337636466373761343436636434223B733A343A2274696D65223B693A313738313635373537313B7D,'2026-06-18 07:52:51','2026-06-17 07:52:51','0','127.0.0.1','curl/8.14.1'),
('d355c5571ecb99a30cb210f50d894024',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230313332653361623538343338303736353765383332633164396263643063353764353437386563223B733A343A2274696D65223B693A313738313635373732343B7D,'2026-06-18 07:55:24','2026-06-17 07:55:24','0','127.0.0.1','curl/8.14.1'),
('d3abecfaad68d37245bade46da65d4eb',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233393538313235386566393039316665613538323965363537396134366235616438393465353639223B733A343A2274696D65223B693A313738313635383637373B7D,'2026-06-18 08:11:17','2026-06-17 08:11:17','0','127.0.0.1','curl/8.14.1'),
('d3b584bfbe184c7f8bddc3bd40bc5b8f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265326139333330326463313636386330323834343437663736306466363462336164316231663864223B733A343A2274696D65223B693A313738313635383436323B7D,'2026-06-18 08:07:42','2026-06-17 08:07:42','0','127.0.0.1','curl/8.14.1'),
('d5182df9dfc65db07496f1284a6f9240',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231376364616538643763656536303463633138656265383330376239643861303030333964376535223B733A343A2274696D65223B693A313738313635343134373B7D,'2026-06-18 06:55:48','2026-06-17 06:55:48','0','127.0.0.1','curl/8.14.1'),
('d5661b2d78295275a5a5fe6b0cf70aa8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262383464666438636263366537343835393934623464303335373162613661656234333463643331223B733A343A2274696D65223B693A313738313635343937383B7D,'2026-06-18 07:09:38','2026-06-17 07:09:38','0','127.0.0.1','curl/8.14.1'),
('d71d96ac863bc77f09d44c8ece81cf0f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231626634633565306632623132643538613166363035353539613462393939346338666233336637223B733A343A2274696D65223B693A313738313635373534303B7D,'2026-06-18 07:52:20','2026-06-17 07:52:20','0','127.0.0.1','curl/8.14.1'),
('d7367080b57a5f2a1804b9369aee072f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238363231303437313437393237623366663234623362383839303366386566313264383431336435223B733A343A2274696D65223B693A313738313635343438373B7D,'2026-06-18 07:01:27','2026-06-17 07:01:27','0','127.0.0.1','curl/8.14.1'),
('d7fdf17346a070efee3fb7f1d8337b30',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230393834613636353462613437393235363833366666383162346561623430376538363135316630223B733A343A2274696D65223B693A313738313635353235363B7D,'2026-06-18 07:14:16','2026-06-17 07:14:16','0','127.0.0.1','curl/8.14.1'),
('d818f0a76acbbc9d1c3f59d78383c7f3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266306630643530323630373662313435653566343964666136396534386465623965663138643331223B733A343A2274696D65223B693A313738313134373938343B7D,'2026-06-12 10:19:44','2026-06-11 10:19:44','0','127.0.0.1','curl/8.14.1'),
('db3948ccc41f9d1f3f72ef47c45fe65f',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2263303038356139636435373234643934393632393231646665356232333265666632666439343234223B733A343A2274696D65223B693A313738313635373230333B7D,'2026-06-18 07:46:43','2026-06-17 07:46:43','0','127.0.0.1','curl/8.14.1'),
('dd22b51541fc0823d377044f2d6b94a7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233336164383861336338303634663463356461316432396231653962636664396239663666396364223B733A343A2274696D65223B693A313738313635393136383B7D,'2026-06-18 08:19:28','2026-06-17 08:19:28','0','127.0.0.1','curl/8.14.1'),
('dd83ab98c6b75a50fb88915f9c3ab34a',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261616265373038643265363639333339326138323563666465303964366633333666303566363364223B733A343A2274696D65223B693A313738313636303331303B7D,'2026-06-18 08:38:30','2026-06-17 08:38:30','0','127.0.0.1','curl/8.14.1'),
('e102efca155f793533356cfd02693663',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264386639653562653039653633386163376430613038333630343036613532313036646666356365223B733A343A2274696D65223B693A313738313134373234353B7D,'2026-06-12 10:07:25','2026-06-11 10:07:25','0','127.0.0.1','curl/8.14.1'),
('e1ba87eecf9040dd44ea13a0cd59b824',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237653764386539393237666663653335303763656233353939636135393334363931333062323562223B733A343A2274696D65223B693A313738313635393431343B7D,'2026-06-18 08:23:34','2026-06-17 08:23:34','0','127.0.0.1','curl/8.14.1'),
('e23d08707ff388300c0d4b4afd2bc894',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2263623666396635663330323965303463633361333539653364313839323432633039363732366465223B733A343A2274696D65223B693A313738313635373335363B7D,'2026-06-18 07:49:16','2026-06-17 07:49:16','0','127.0.0.1','curl/8.14.1'),
('e2cc4b5e2045666e0f9ae4b316ef4951',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233646633633966636262663062393938376235623761336330653634303861316338323061353736223B733A343A2274696D65223B693A313738313635393933393B7D,'2026-06-18 08:32:19','2026-06-17 08:32:19','0','127.0.0.1','curl/8.14.1'),
('e2f7e70b91bc7bfce422d8e753be49a1',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233663434333139343632323963376562326562353939666334313263373739656536633031396430223B733A343A2274696D65223B693A313738313635363531363B7D,'2026-06-18 07:35:16','2026-06-17 07:35:16','0','127.0.0.1','curl/8.14.1'),
('e3e23bb28f47d753521e494641e6992c',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232643662386164363766653934653937346465616233303936623537366166323339386664383730223B733A343A2274696D65223B693A313738313635393937303B7D,'2026-06-18 08:32:50','2026-06-17 08:32:50','0','127.0.0.1','curl/8.14.1'),
('e5549fcfca44a4e9bf41544391a393cd',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266363763396436366534333936623232373762393733393637663865363332346434396439623437223B733A343A2274696D65223B693A313738313635343739343B7D,'2026-06-18 07:06:34','2026-06-17 07:06:34','0','127.0.0.1','curl/8.14.1'),
('e75e1e2560a74c37557519a60d9cab40',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2266363830363834656166326463363734353839373432346332303664663934316639356136646438223B733A343A2274696D65223B693A313738313635393831363B7D,'2026-06-18 08:30:16','2026-06-17 08:30:16','0','127.0.0.1','curl/8.14.1'),
('e922eb6a66ac0ea58ab125a5c77642d7',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262346636633837383365653765363831383538633236636535373138396362613036306231666433223B733A343A2274696D65223B693A313738313134373436303B7D,'2026-06-12 10:11:00','2026-06-11 10:11:00','0','127.0.0.1','curl/8.14.1'),
('ea71e8682f21a8e6a2dd17b32185e873',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2262343464383532653164653038633461613835666539646566323835613132646530653939396432223B733A343A2274696D65223B693A313738313635353139343B7D,'2026-06-18 07:13:14','2026-06-17 07:13:14','0','127.0.0.1','curl/8.14.1'),
('eab2a35564197427438398803a955a5c',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264393333303561303936646233656661313134376161333766303566346136303363626339373934223B733A343A2274696D65223B693A313738313635373032373B7D,'2026-06-18 07:43:47','2026-06-17 07:43:47','0','127.0.0.1','curl/8.14.1'),
('eb9ac5c2d7f5266fc213e9ae509316c3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231353462376539396335386365313063366632393138633431326536313363343037316533373337223B733A343A2274696D65223B693A313738313635393530373B7D,'2026-06-18 08:25:07','2026-06-17 08:25:07','0','127.0.0.1','curl/8.14.1'),
('ebaebb587a1e826541dd0a4196640b80',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235656235383831323632663866646432316435396466363066313765666638313934363738643539223B733A343A2274696D65223B693A313738313635353930313B7D,'2026-06-18 07:25:01','2026-06-17 07:25:01','0','127.0.0.1','curl/8.14.1'),
('ecc1788b822643870475d60d6c16b63c',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261396534336661386633336237383136383034373966343262616335343134376237303435333633223B733A343A2274696D65223B693A313738313635393037363B7D,'2026-06-18 08:17:56','2026-06-17 08:17:56','0','127.0.0.1','curl/8.14.1'),
('ed153fae6284edab1d180bdfcca14f2a',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232366565643634356630396461636261306536353639366165383661613139333135633634396561223B733A343A2274696D65223B693A313738313635383333393B7D,'2026-06-18 08:05:39','2026-06-17 08:05:39','0','127.0.0.1','curl/8.14.1'),
('ed87526c4882328e79da38acc3985984',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2239386461613261383239333530326664383965636539623665616333613265376631333863656666223B733A343A2274696D65223B693A313738313635353431303B7D,'2026-06-18 07:16:50','2026-06-17 07:16:50','0','127.0.0.1','curl/8.14.1'),
('ede41d11ce0eeb36f4935ee56a55dd73',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232316538393031373332383132306535613238363464303536366462626332613839346336343036223B733A343A2274696D65223B693A313738313635353734373B7D,'2026-06-18 07:22:27','2026-06-17 07:22:27','0','127.0.0.1','curl/8.14.1'),
('ee6b7754f4a9305726d6f7e8ced6db9b',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235363435343330363465366636353332383435336463316462636430333636616130323837616165223B733A343A2274696D65223B693A313738313635383330393B7D,'2026-06-18 08:05:09','2026-06-17 08:05:09','0','127.0.0.1','curl/8.14.1'),
('ee9ad2fcaa5910cd05ff5028c3eb344d',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2230646239353761303637666633316166666262646363613963313362373534306664313436656164223B733A343A2274696D65223B693A313738313635383833303B7D,'2026-06-18 08:13:50','2026-06-17 08:13:50','0','127.0.0.1','curl/8.14.1'),
('ef88b973a5ee6bc4baeb0669c7e37373',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2232366233303338366464616536626666373363666236326538326661333261346139626637653637223B733A343A2274696D65223B693A313738313635393031353B7D,'2026-06-18 08:16:55','2026-06-17 08:16:55','0','127.0.0.1','curl/8.14.1'),
('efeb5dd1ab59f3cddb644c4d4cad4f57',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265633533633033353462343261343035373739623531346136303233653536663061363336653236223B733A343A2274696D65223B693A313738313635393239313B7D,'2026-06-18 08:21:31','2026-06-17 08:21:31','0','127.0.0.1','curl/8.14.1'),
('f08b7c5f8e99794393a3f8728f736e84',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238643465393766643537626162636566303437376564336564333632643932633461396338366439223B733A343A2274696D65223B693A313738313635353533333B7D,'2026-06-18 07:18:53','2026-06-17 07:18:53','0','127.0.0.1','curl/8.14.1'),
('f09e766ef356ec497872981d936083af',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264663131363164626237323735393839336239373237646565616637656436633031663839653033223B733A343A2274696D65223B693A313738313635393533383B7D,'2026-06-18 08:25:38','2026-06-17 08:25:38','0','127.0.0.1','curl/8.14.1'),
('f16094641fbc9551fa05eac24ba44407',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233623231653661643533643234663730643262626630626165343235393931393466646262373163223B733A343A2274696D65223B693A313738313635373134393B7D,'2026-06-18 07:45:49','2026-06-17 07:45:49','0','127.0.0.1','curl/8.14.1'),
('f2a4c03cd6c33fbeb05ff6e70cfc669e',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2237646135363837663533663165313131323064623231643965383536363163386532633436323533223B733A343A2274696D65223B693A313738313635373933393B7D,'2026-06-18 07:58:59','2026-06-17 07:58:59','0','127.0.0.1','curl/8.14.1'),
('f51b3433d0735219a885befd426e8e03',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235643865326636393933316462323733346163326138663066333435383439326665396437373937223B733A343A2274696D65223B693A313738313635353933333B7D,'2026-06-18 07:25:33','2026-06-17 07:25:33','0','127.0.0.1','curl/8.14.1'),
('f5458d8d5dd6e8c9b6315bb0ea7795f3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265363262316534313938643539333836376563633063383834356533333166623364613836336539223B733A343A2274696D65223B693A313738313635353136333B7D,'2026-06-18 07:12:43','2026-06-17 07:12:43','0','127.0.0.1','curl/8.14.1'),
('f74fa5b6a3686e99da51664810587cda',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238623830313037393362363430363634353461343063306230663862333633303331373938393831223B733A343A2274696D65223B693A313738313635363131373B7D,'2026-06-18 07:28:37','2026-06-17 07:28:37','0','127.0.0.1','curl/8.14.1'),
('f9dd3e76096be27d63213f8e0c3e7262',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2238356232386130376630383735396666346566353831313730316439613064336139353862663333223B733A343A2274696D65223B693A313738313635343336343B7D,'2026-06-18 06:59:24','2026-06-17 06:59:24','0','127.0.0.1','curl/8.14.1'),
('fa486c35dec1385027d4f2a492993d51',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2233326462613932353137326438666333616164663035323264616631333838626661346331393836223B733A343A2274696D65223B693A313738313635363035353B7D,'2026-06-18 07:27:35','2026-06-17 07:27:35','0','127.0.0.1','curl/8.14.1'),
('fc89e8d20ab1d72a21622c9acc7944a8',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2231313835356238656238626639663830386664636365623738636634656237343231306633326631223B733A343A2274696D65223B693A313738313635373930383B7D,'2026-06-18 07:58:28','2026-06-17 07:58:28','0','127.0.0.1','curl/8.14.1'),
('fc97f16fc75cbdd7e28687f8c31c27f3',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2264633437306663613764666334643533656538346337353363373835633863343331386164333263223B733A343A2274696D65223B693A313738313635393434353B7D,'2026-06-18 08:24:05','2026-06-17 08:24:05','0','127.0.0.1','curl/8.14.1'),
('ff23a3f3b7c78b9ba8c791ae773c98e5',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2261323035636235636366393132653832663530363632666236383066646338376534663733636331223B733A343A2274696D65223B693A313738313635343832353B7D,'2026-06-18 07:07:05','2026-06-17 07:07:05','0','127.0.0.1','curl/8.14.1'),
('ff4b218079429fccc4ef445e65d823c9',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2265383161373134343433313638343934313933623839613366316263616163383332313462323530223B733A343A2274696D65223B693A313738313635363435353B7D,'2026-06-18 07:34:15','2026-06-17 07:34:15','0','127.0.0.1','curl/8.14.1'),
('ffccb6a1c1648fcdd5acd4c060dab98a',0x637372667C613A323A7B733A353A22746F6B656E223B733A34303A2235323263383662626362356666633134633237353734393337336538333137316464303532393637223B733A343A2274696D65223B693A313738313134373733373B7D,'2026-06-12 10:15:37','2026-06-11 10:15:37','0','127.0.0.1','curl/8.14.1');
/*!40000 ALTER TABLE `ost_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_sla`
--

DROP TABLE IF EXISTS `ost_sla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_sla` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` int(10) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 3,
  `grace_period` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sla`
--

LOCK TABLES `ost_sla` WRITE;
/*!40000 ALTER TABLE `ost_sla` DISABLE KEYS */;
INSERT INTO `ost_sla` VALUES
(1,0,3,18,'Default SLA',NULL,'2026-06-11 10:06:32','2026-06-11 10:06:32');
/*!40000 ALTER TABLE `ost_sla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_staff`
--

DROP TABLE IF EXISTS `ost_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_staff` (
  `staff_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `username` varchar(32) NOT NULL DEFAULT '',
  `firstname` varchar(32) DEFAULT NULL,
  `lastname` varchar(32) DEFAULT NULL,
  `passwd` varchar(128) DEFAULT NULL,
  `backend` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(24) NOT NULL DEFAULT '',
  `phone_ext` varchar(6) DEFAULT NULL,
  `mobile` varchar(24) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `locale` varchar(16) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `isactive` tinyint(1) NOT NULL DEFAULT 1,
  `isadmin` tinyint(1) NOT NULL DEFAULT 0,
  `isvisible` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `onvacation` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `assigned_only` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `show_assigned_tickets` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `change_passwd` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `max_page_size` int(11) unsigned NOT NULL DEFAULT 0,
  `auto_refresh_rate` int(10) unsigned NOT NULL DEFAULT 0,
  `default_signature_type` enum('none','mine','dept') NOT NULL DEFAULT 'none',
  `default_paper_size` enum('Letter','Legal','Ledger','A4','A3') NOT NULL DEFAULT 'Letter',
  `extra` text DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `passwdreset` datetime DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `username` (`username`),
  KEY `dept_id` (`dept_id`),
  KEY `issuperuser` (`isadmin`),
  KEY `isactive` (`isactive`),
  KEY `onvacation` (`onvacation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_staff`
--

LOCK TABLES `ost_staff` WRITE;
/*!40000 ALTER TABLE `ost_staff` DISABLE KEYS */;
INSERT INTO `ost_staff` VALUES
(1,1,1,'helpdesk','Helpdesk','Layanan Ticketing','$2a$08$qjsky2KbK2JDuxx2H0R1G.ZrRma7mK1HeEaBXWNlmVLzsmBwVWGU.',NULL,'helpdesk@dompukab.go.id','',NULL,'','',NULL,NULL,NULL,NULL,1,1,1,0,0,0,0,25,0,'none','Letter','{\"browser_lang\":\"en_US\"}','{\"user.create\":1,\"user.delete\":1,\"user.edit\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.delete\":1,\"org.edit\":1,\"faq.manage\":1,\"visibility.agents\":1,\"emails.banlist\":1,\"visibility.departments\":1}','2026-06-11 10:06:38','2026-06-11 10:08:07','2026-06-11 10:06:38','2026-06-11 10:08:07');
/*!40000 ALTER TABLE `ost_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_staff_dept_access`
--

DROP TABLE IF EXISTS `ost_staff_dept_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_staff_dept_access` (
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`staff_id`,`dept_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_staff_dept_access`
--

LOCK TABLES `ost_staff_dept_access` WRITE;
/*!40000 ALTER TABLE `ost_staff_dept_access` DISABLE KEYS */;
INSERT INTO `ost_staff_dept_access` VALUES
(1,2,1,1),
(1,3,1,1);
/*!40000 ALTER TABLE `ost_staff_dept_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_syslog`
--

DROP TABLE IF EXISTS `ost_syslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_syslog` (
  `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` enum('Debug','Warning','Error') NOT NULL,
  `title` varchar(255) NOT NULL,
  `log` text NOT NULL,
  `logger` varchar(64) NOT NULL,
  `ip_address` varchar(64) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_type` (`log_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_syslog`
--

LOCK TABLES `ost_syslog` WRITE;
/*!40000 ALTER TABLE `ost_syslog` DISABLE KEYS */;
INSERT INTO `ost_syslog` VALUES
(1,'Debug','osTicket installed!','Congratulations osTicket basic installation completed!\n\nThank you for choosing osTicket!','','172.18.0.1','2026-06-11 10:06:39','2026-06-11 10:06:39'),
(2,'Error','Mailer Error','Unable to email via Sendmail Unable to send mail: Unknown error ','','172.18.0.1','2026-06-11 10:10:08','2026-06-11 10:10:08'),
(3,'Error','Mailer Error','Unable to email via Sendmail Unable to send mail: Unknown error ','','172.18.0.1','2026-06-11 10:10:30','2026-06-11 10:10:30'),
(4,'Error','Mailer Error','Unable to email via Sendmail Unable to send mail: Unknown error ','','172.18.0.1','2026-06-11 10:11:30','2026-06-11 10:11:30');
/*!40000 ALTER TABLE `ost_syslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task`
--

DROP TABLE IF EXISTS `ost_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL DEFAULT 0,
  `object_type` char(1) NOT NULL,
  `number` varchar(20) DEFAULT NULL,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `team_id` int(10) unsigned NOT NULL DEFAULT 0,
  `lock_id` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `duedate` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`),
  KEY `team_id` (`team_id`),
  KEY `created` (`created`),
  KEY `object` (`object_id`,`object_type`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task`
--

LOCK TABLES `ost_task` WRITE;
/*!40000 ALTER TABLE `ost_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task__cdata`
--

DROP TABLE IF EXISTS `ost_task__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_task__cdata` (
  `task_id` int(11) unsigned NOT NULL,
  `title` mediumtext DEFAULT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task__cdata`
--

LOCK TABLES `ost_task__cdata` WRITE;
/*!40000 ALTER TABLE `ost_task__cdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_task__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_team`
--

DROP TABLE IF EXISTS `ost_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_team` (
  `team_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` int(10) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(125) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `name` (`name`),
  KEY `lead_id` (`lead_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team`
--

LOCK TABLES `ost_team` WRITE;
/*!40000 ALTER TABLE `ost_team` DISABLE KEYS */;
INSERT INTO `ost_team` VALUES
(1,0,1,'Level I Support','Tier 1 support, responsible for the initial iteraction with customers','2026-06-11 10:06:33','2026-06-11 10:06:33');
/*!40000 ALTER TABLE `ost_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_team_member`
--

DROP TABLE IF EXISTS `ost_team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_team_member` (
  `team_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`team_id`,`staff_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team_member`
--

LOCK TABLES `ost_team_member` WRITE;
/*!40000 ALTER TABLE `ost_team_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_team_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread`
--

DROP TABLE IF EXISTS `ost_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `object_type` char(1) NOT NULL,
  `extra` text DEFAULT NULL,
  `lastresponse` datetime DEFAULT NULL,
  `lastmessage` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_id` (`object_id`),
  KEY `object_type` (`object_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread`
--

LOCK TABLES `ost_thread` WRITE;
/*!40000 ALTER TABLE `ost_thread` DISABLE KEYS */;
INSERT INTO `ost_thread` VALUES
(1,1,'T',NULL,NULL,'2026-06-11 10:06:39','2026-06-11 10:06:39'),
(2,2,'T',NULL,'2026-06-11 10:11:29','2026-06-11 10:10:05','2026-06-11 10:10:05');
/*!40000 ALTER TABLE `ost_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_collaborator`
--

DROP TABLE IF EXISTS `ost_thread_collaborator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_collaborator` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT 1,
  `thread_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `role` char(1) NOT NULL DEFAULT 'M',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collab` (`thread_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_collaborator`
--

LOCK TABLES `ost_thread_collaborator` WRITE;
/*!40000 ALTER TABLE `ost_thread_collaborator` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_collaborator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry`
--

DROP TABLE IF EXISTS `ost_thread_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT 0,
  `thread_id` int(11) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `type` char(1) NOT NULL DEFAULT '',
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `poster` varchar(128) NOT NULL DEFAULT '',
  `editor` int(10) unsigned DEFAULT NULL,
  `editor_type` char(1) DEFAULT NULL,
  `source` varchar(32) NOT NULL DEFAULT '',
  `title` varchar(255) DEFAULT NULL,
  `body` text NOT NULL,
  `format` varchar(16) NOT NULL DEFAULT 'html',
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `extra` text DEFAULT NULL,
  `recipients` text DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `thread_id` (`thread_id`),
  KEY `staff_id` (`staff_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry`
--

LOCK TABLES `ost_thread_entry` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry` DISABLE KEYS */;
INSERT INTO `ost_thread_entry` VALUES
(1,0,1,0,1,'M',65,'osTicket Team',NULL,NULL,'Web','osTicket Installed!',' <p>Thank you for choosing osTicket. </p> <p>Please make sure you join the <a href=\"https://forum.osticket.com\">osTicket forums</a> and our <a href=\"https://osticket.com\">mailing list</a> to stay up to date on the latest news, security alerts and updates. The osTicket forums are also a great place to get assistance, guidance, tips, and help from other osTicket users. In addition to the forums, the <a href=\"https://docs.osticket.com\">osTicket Docs</a> provides a useful collection of educational materials, documentation, and notes from the community. We welcome your contributions to the osTicket community. </p> <p>If you are looking for a greater level of support, we provide professional services and commercial support with guaranteed response times, and access to the core development team. We can also help customize osTicket or even add new features to the system to meet your unique needs. </p> <p>If the idea of managing and upgrading this osTicket installation is daunting, you can try osTicket as a hosted service at <a href=\"https://supportsystem.com\">https://supportsystem.com/</a> -- no installation required and we can import your data! With SupportSystem\'s turnkey infrastructure, you get osTicket at its best, leaving you free to focus on your customers without the burden of making sure the application is stable, maintained, and secure. </p> <p>Cheers, </p> <p>-<br /> osTicket Team - https://osticket.com/ </p> <p><strong>PS.</strong> Don\'t just make customers happy, make happy customers! </p>','html','172.18.0.1',NULL,NULL,'2026-06-11 10:06:39','2026-06-11 10:06:39'),
(2,0,2,0,2,'M',65,'lkks dompu',NULL,NULL,'',NULL,'<p>Coba</p>','html','172.18.0.1',NULL,NULL,'2026-06-11 10:10:05','2026-06-11 10:10:05'),
(3,2,2,1,0,'R',576,'Helpdesk Layanan Ticketing',NULL,NULL,'',NULL,'<p>Cek</p>','html','172.18.0.1',NULL,'{\"to\":{\"2\":\"lkks dompu <lkksdompu@gmail.com>\"}}','2026-06-11 10:11:29','2026-06-11 10:11:29');
/*!40000 ALTER TABLE `ost_thread_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry_email`
--

DROP TABLE IF EXISTS `ost_thread_entry_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_entry_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `thread_entry_id` int(11) unsigned NOT NULL,
  `email_id` int(11) unsigned DEFAULT NULL,
  `mid` varchar(255) NOT NULL,
  `headers` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thread_entry_id` (`thread_entry_id`),
  KEY `mid` (`mid`),
  KEY `email_id` (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry_email`
--

LOCK TABLES `ost_thread_entry_email` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_entry_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry_merge`
--

DROP TABLE IF EXISTS `ost_thread_entry_merge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_entry_merge` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `thread_entry_id` int(11) unsigned NOT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thread_entry_id` (`thread_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry_merge`
--

LOCK TABLES `ost_thread_entry_merge` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry_merge` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_entry_merge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_event`
--

DROP TABLE IF EXISTS `ost_thread_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) unsigned NOT NULL DEFAULT 0,
  `thread_type` char(1) NOT NULL DEFAULT '',
  `event_id` int(11) unsigned DEFAULT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  `team_id` int(11) unsigned NOT NULL,
  `dept_id` int(11) unsigned NOT NULL,
  `topic_id` int(11) unsigned NOT NULL,
  `data` varchar(1024) DEFAULT NULL COMMENT 'Encoded differences',
  `username` varchar(128) NOT NULL DEFAULT 'SYSTEM',
  `uid` int(11) unsigned DEFAULT NULL,
  `uid_type` char(1) NOT NULL DEFAULT 'S',
  `annulled` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_state` (`thread_id`,`event_id`,`timestamp`),
  KEY `ticket_stats` (`timestamp`,`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_event`
--

LOCK TABLES `ost_thread_event` WRITE;
/*!40000 ALTER TABLE `ost_thread_event` DISABLE KEYS */;
INSERT INTO `ost_thread_event` VALUES
(1,1,'T',1,0,0,1,1,NULL,'SYSTEM',1,'U',0,'2026-06-11 10:06:39'),
(2,2,'T',1,0,0,1,1,NULL,'SYSTEM',2,'U',0,'2026-06-11 10:10:05');
/*!40000 ALTER TABLE `ost_thread_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_referral`
--

DROP TABLE IF EXISTS `ost_thread_referral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_thread_referral` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) unsigned NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `object_type` char(1) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ref` (`object_id`,`object_type`,`thread_id`),
  KEY `thread_id` (`thread_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_referral`
--

LOCK TABLES `ost_thread_referral` WRITE;
/*!40000 ALTER TABLE `ost_thread_referral` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_referral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket`
--

DROP TABLE IF EXISTS `ost_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_ticket` (
  `ticket_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_pid` int(11) unsigned DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `user_email_id` int(11) unsigned NOT NULL DEFAULT 0,
  `status_id` int(10) unsigned NOT NULL DEFAULT 0,
  `dept_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sla_id` int(10) unsigned NOT NULL DEFAULT 0,
  `topic_id` int(10) unsigned NOT NULL DEFAULT 0,
  `staff_id` int(10) unsigned NOT NULL DEFAULT 0,
  `team_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email_id` int(11) unsigned NOT NULL DEFAULT 0,
  `lock_id` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `sort` int(11) unsigned NOT NULL DEFAULT 0,
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `source` enum('Web','Email','Phone','API','Other') NOT NULL DEFAULT 'Other',
  `source_extra` varchar(40) DEFAULT NULL,
  `isoverdue` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `isanswered` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `duedate` datetime DEFAULT NULL,
  `est_duedate` datetime DEFAULT NULL,
  `reopened` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `lastupdate` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`),
  KEY `team_id` (`team_id`),
  KEY `status_id` (`status_id`),
  KEY `created` (`created`),
  KEY `closed` (`closed`),
  KEY `duedate` (`duedate`),
  KEY `topic_id` (`topic_id`),
  KEY `sla_id` (`sla_id`),
  KEY `ticket_pid` (`ticket_pid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket`
--

LOCK TABLES `ost_ticket` WRITE;
/*!40000 ALTER TABLE `ost_ticket` DISABLE KEYS */;
INSERT INTO `ost_ticket` VALUES
(1,NULL,'171173',1,0,1,1,1,1,0,0,0,0,0,0,'172.18.0.1','Web',NULL,0,0,NULL,'2026-06-15 10:06:39',NULL,NULL,'2026-06-11 10:06:39','2026-06-11 10:06:39','2026-06-11 10:06:39'),
(2,NULL,'602175',2,0,1,1,1,1,1,0,0,0,0,0,'172.18.0.1','Web',NULL,0,1,NULL,'2026-06-15 10:10:05',NULL,NULL,'2026-06-11 10:10:05','2026-06-11 10:10:05','2026-06-11 10:11:30');
/*!40000 ALTER TABLE `ost_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket__cdata`
--

DROP TABLE IF EXISTS `ost_ticket__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_ticket__cdata` (
  `ticket_id` int(11) unsigned NOT NULL,
  `subject` mediumtext DEFAULT NULL,
  `priority` mediumtext DEFAULT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket__cdata`
--

LOCK TABLES `ost_ticket__cdata` WRITE;
/*!40000 ALTER TABLE `ost_ticket__cdata` DISABLE KEYS */;
INSERT INTO `ost_ticket__cdata` VALUES
(1,'osTicket Installed!',NULL),
(2,'Coba','2');
/*!40000 ALTER TABLE `ost_ticket__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket_priority`
--

DROP TABLE IF EXISTS `ost_ticket_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_ticket_priority` (
  `priority_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `priority` varchar(60) NOT NULL DEFAULT '',
  `priority_desc` varchar(30) NOT NULL DEFAULT '',
  `priority_color` varchar(7) NOT NULL DEFAULT '',
  `priority_urgency` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `ispublic` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`priority_id`),
  UNIQUE KEY `priority` (`priority`),
  KEY `priority_urgency` (`priority_urgency`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_priority`
--

LOCK TABLES `ost_ticket_priority` WRITE;
/*!40000 ALTER TABLE `ost_ticket_priority` DISABLE KEYS */;
INSERT INTO `ost_ticket_priority` VALUES
(1,'low','Low','#DDFFDD',4,1),
(2,'normal','Normal','#FFFFF0',3,1),
(3,'high','High','#FEE7E7',2,1),
(4,'emergency','Emergency','#FEE7E7',1,1);
/*!40000 ALTER TABLE `ost_ticket_priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket_status`
--

DROP TABLE IF EXISTS `ost_ticket_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_ticket_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `state` varchar(16) DEFAULT NULL,
  `mode` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  `sort` int(11) unsigned NOT NULL DEFAULT 0,
  `properties` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_status`
--

LOCK TABLES `ost_ticket_status` WRITE;
/*!40000 ALTER TABLE `ost_ticket_status` DISABLE KEYS */;
INSERT INTO `ost_ticket_status` VALUES
(1,'Open','open',3,0,1,'{\"description\":\"Open tickets.\"}','2026-06-11 10:06:33','0000-00-00 00:00:00'),
(2,'Resolved','closed',1,0,2,'{\"allowreopen\":true,\"reopenstatus\":0,\"description\":\"Resolved tickets\"}','2026-06-11 10:06:33','0000-00-00 00:00:00'),
(3,'Closed','closed',3,0,3,'{\"allowreopen\":true,\"reopenstatus\":0,\"description\":\"Closed tickets. Tickets will still be accessible on client and staff panels.\"}','2026-06-11 10:06:33','0000-00-00 00:00:00'),
(4,'Archived','archived',3,0,4,'{\"description\":\"Tickets only adminstratively available but no longer accessible on ticket queues and client panel.\"}','2026-06-11 10:06:33','0000-00-00 00:00:00'),
(5,'Deleted','deleted',3,0,5,'{\"description\":\"Tickets queued for deletion. Not accessible on ticket queues.\"}','2026-06-11 10:06:33','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ost_ticket_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_translation`
--

DROP TABLE IF EXISTS `ost_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_translation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_hash` char(16) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `type` enum('phrase','article','override') DEFAULT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `revision` int(11) unsigned DEFAULT NULL,
  `agent_id` int(10) unsigned NOT NULL DEFAULT 0,
  `lang` varchar(16) NOT NULL DEFAULT '',
  `text` mediumtext NOT NULL,
  `source_text` text DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`lang`),
  KEY `object_hash` (`object_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_translation`
--

LOCK TABLES `ost_translation` WRITE;
/*!40000 ALTER TABLE `ost_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user`
--

DROP TABLE IF EXISTS `ost_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` int(10) unsigned NOT NULL,
  `default_email_id` int(10) NOT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  KEY `default_email_id` (`default_email_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user`
--

LOCK TABLES `ost_user` WRITE;
/*!40000 ALTER TABLE `ost_user` DISABLE KEYS */;
INSERT INTO `ost_user` VALUES
(1,1,1,0,'osTicket Team','2026-06-11 10:06:39','2026-06-11 10:06:39'),
(2,0,2,0,'lkks dompu','2026-06-11 10:10:05','2026-06-11 10:10:05');
/*!40000 ALTER TABLE `ost_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user__cdata`
--

DROP TABLE IF EXISTS `ost_user__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_user__cdata` (
  `user_id` int(11) unsigned NOT NULL,
  `email` mediumtext DEFAULT NULL,
  `name` mediumtext DEFAULT NULL,
  `phone` mediumtext DEFAULT NULL,
  `notes` mediumtext DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user__cdata`
--

LOCK TABLES `ost_user__cdata` WRITE;
/*!40000 ALTER TABLE `ost_user__cdata` DISABLE KEYS */;
INSERT INTO `ost_user__cdata` VALUES
(2,NULL,NULL,'081399332689','');
/*!40000 ALTER TABLE `ost_user__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user_account`
--

DROP TABLE IF EXISTS `ost_user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_user_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT 0,
  `timezone` varchar(64) DEFAULT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `passwd` varchar(128) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `backend` varchar(32) DEFAULT NULL,
  `extra` text DEFAULT NULL,
  `registered` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user_account`
--

LOCK TABLES `ost_user_account` WRITE;
/*!40000 ALTER TABLE `ost_user_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user_email`
--

DROP TABLE IF EXISTS `ost_user_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ost_user_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `address` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address` (`address`),
  KEY `user_email_lookup` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user_email`
--

LOCK TABLES `ost_user_email` WRITE;
/*!40000 ALTER TABLE `ost_user_email` DISABLE KEYS */;
INSERT INTO `ost_user_email` VALUES
(1,1,0,'feedback@osticket.com'),
(2,2,0,'lkksdompu@gmail.com');
/*!40000 ALTER TABLE `ost_user_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'osticket'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-17  8:39:12
