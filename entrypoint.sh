#!/bin/sh

# ============================================================
# osTicket Docker Entrypoint Script
# ============================================================
# Script ini melakukan:
# 1. Mengecek koneksi ke database
# 2. Menunggu database siap
# 3. Mengatur permission yang benar
# 4. Menjalankan Apache

set -e

# Color output functions
log_info() {
    echo "[INFO] $1"
}

log_error() {
    echo "[ERROR] $1" >&2
}

log_success() {
    echo "[SUCCESS] $1"
}

# ============================================================
# 1. Validasi environment variables
# ============================================================
log_info "Validating environment variables..."

if [ -z "$MYSQL_HOST" ]; then
    log_error "MYSQL_HOST is not set"
    exit 1
fi

if [ -z "$MYSQL_DATABASE" ]; then
    log_error "MYSQL_DATABASE is not set"
    exit 1
fi

if [ -z "$MYSQL_USER" ]; then
    log_error "MYSQL_USER is not set"
    exit 1
fi

if [ -z "$MYSQL_PASSWORD" ]; then
    log_error "MYSQL_PASSWORD is not set"
    exit 1
fi

log_success "Environment variables validated"

# ============================================================
# 2. Tunggu database siap (dengan retry)
# ============================================================
log_info "Waiting for database to be ready..."
log_info "Connecting to: $MYSQL_HOST:${MYSQL_PORT:-3306}"

MYSQL_PORT=${MYSQL_PORT:-3306}
MAX_ATTEMPTS=30
ATTEMPT=0

while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    ATTEMPT=$((ATTEMPT + 1))
    
    if mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" > /dev/null 2>&1; then
        log_success "Database is ready! (attempt $ATTEMPT/$MAX_ATTEMPTS)"
        break
    else
        log_info "Database not ready yet... (attempt $ATTEMPT/$MAX_ATTEMPTS, retrying in 2 seconds)"
        sleep 2
    fi
    
    if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
        log_error "Could not connect to database after $MAX_ATTEMPTS attempts"
        exit 1
    fi
done

# ============================================================
# 3. Cek dan setup database
# ============================================================
log_info "Checking database and tables..."

# Create database jika belum ada (ini jarang terjadi karena docker-compose sudah membuat)
mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" << EOF
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EOF

log_success "Database is ready"

# ============================================================
# 4. Setup file permissions
# ============================================================
log_info "Setting up file permissions..."

# Directory utama
if [ -d "/var/www/html" ]; then
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    
    # Set write permissions untuk directory yang membutuhkan
    if [ -d "/var/www/html/upload" ]; then
        chmod -R 755 /var/www/html/upload
    fi
    
    # Setup directory - sebaiknya read-only setelah instalasi
    if [ -d "/var/www/html/setup" ]; then
        chmod -R 755 /var/www/html/setup
    fi
    
    # Attachment directory - needs write access
    if [ -d "/var/www/html/upload/attachments" ]; then
        chmod -R 755 /var/www/html/upload/attachments
        chown -R www-data:www-data /var/www/html/upload/attachments
    fi
    
    # Include directory - needs write access untuk config
    if [ -d "/var/www/html/upload/include" ]; then
        chmod -R 755 /var/www/html/upload/include
        chown -R www-data:www-data /var/www/html/upload/include
    fi
    
    log_success "File permissions set correctly"
fi

# ============================================================
# 5. Check Apache configuration
# ============================================================
log_info "Validating Apache configuration..."

if ! apache2ctl configtest 2>/dev/null; then
    log_error "Apache configuration is invalid"
    apache2ctl configtest
    exit 1
fi

log_success "Apache configuration is valid"

# ============================================================
# 6. Setup log directory
# ============================================================
log_info "Setting up log directories..."

if [ ! -d "/var/log/apache2" ]; then
    mkdir -p /var/log/apache2
fi

if [ ! -d "/var/lib/php/sessions" ]; then
    mkdir -p /var/lib/php/sessions
    chmod 1777 /var/lib/php/sessions
fi

log_success "Log directories ready"

# ============================================================
# 7. Show startup information
# ============================================================
log_info "==============================================="
log_info "osTicket Docker Environment Ready"
log_info "==============================================="
log_info "Database Host: $MYSQL_HOST"
log_info "Database Name: $MYSQL_DATABASE"
log_info "Database User: $MYSQL_USER"
log_info "Database Port: $MYSQL_PORT"
log_info "Timezone: $TZ"
log_info "==============================================="
log_info "Starting Apache..."
log_info "==============================================="

# ============================================================
# 8. Jalankan Apache
# ============================================================
# Jalankan command yang diberikan (default: apache2-foreground)
exec "$@"
