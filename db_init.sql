-- ============================================================
-- osTicket Database Initialization Script
-- ============================================================
-- Script ini dijalankan otomatis ketika container database dimulai
-- File ini akan dieksekusi oleh MariaDB initialization process

-- ============================================================
-- Create osTicket Database
-- ============================================================

-- Database sudah dibuat oleh docker-compose variables,
-- tapi script ini memastikan semuanya siap

-- Set default character set
ALTER DATABASE osticket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- ============================================================
-- Create Required Tables Structure
-- ============================================================
-- Catatan: osTicket akan membuat tabel-tabel lain melalui
-- installer web, script ini hanya mempersiapkan database

-- Gunakan database osticket
USE osticket;

-- Grant permissions untuk osticket user
GRANT ALL PRIVILEGES ON osticket.* TO 'osticket'@'%' IDENTIFIED BY 'osticketpass';

-- Refresh privileges
FLUSH PRIVILEGES;

-- ============================================================
-- Verifikasi
-- ============================================================

-- Verifikasi database dibuat
SHOW DATABASES LIKE 'osticket';

-- Verifikasi user
SELECT User, Host FROM mysql.user WHERE User='osticket';

-- ============================================================
-- Database ready for osTicket installer
-- ============================================================
