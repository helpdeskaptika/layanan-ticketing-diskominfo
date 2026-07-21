#!/bin/bash

# ============================================================
# osTicket Docker - Helper Script
# ============================================================
# Script untuk memudahkan operasi sehari-hari

set -e

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_info() {
    echo -e "${COLOR_BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${COLOR_YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${COLOR_RED}[ERROR]${NC} $1"
}

# Show menu
show_menu() {
    echo ""
    echo "========================================"
    echo "  osTicket Docker Helper"
    echo "========================================"
    echo "1. Start containers"
    echo "2. Stop containers"
    echo "3. Restart containers"
    echo "4. View logs"
    echo "5. Bash shell (web)"
    echo "6. MySQL console"
    echo "7. Backup database"
    echo "8. Restore database"
    echo "9. Fix permissions"
    echo "10. Rebuild image"
    echo "11. Health check"
    echo "12. Exit"
    echo "========================================"
    echo -n "Pilih menu (1-12): "
}

# Commands
cmd_start() {
    print_info "Starting containers..."
    docker compose up -d
    print_success "Containers started"
    docker compose ps
}

cmd_stop() {
    print_info "Stopping containers..."
    docker compose stop
    print_success "Containers stopped"
}

cmd_restart() {
    print_info "Restarting containers..."
    docker compose restart
    print_success "Containers restarted"
    sleep 5
    docker compose ps
}

cmd_logs() {
    echo -n "Pilih service (web/db/all) [all]: "
    read -r service
    service=${service:-all}
    
    if [ "$service" = "all" ]; then
        docker compose logs -f
    else
        docker compose logs -f "$service"
    fi
}

cmd_bash() {
    print_info "Entering bash shell (web container)..."
    print_warning "Type 'exit' untuk keluar"
    docker compose exec web bash
}

cmd_mysql() {
    print_info "Entering MySQL console..."
    print_warning "Type 'exit' untuk keluar"
    
    # Get password from .env
    MYSQL_PASS=$(grep "MYSQL_PASSWORD=" .env | cut -d '=' -f2)
    MYSQL_USER=$(grep "MYSQL_USER=" .env | cut -d '=' -f2)
    
    docker compose exec db mysql -u "$MYSQL_USER" -p"$MYSQL_PASS"
}

cmd_backup() {
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="backup_$TIMESTAMP.sql"
    
    MYSQL_PASS=$(grep "MYSQL_PASSWORD=" .env | cut -d '=' -f2)
    MYSQL_USER=$(grep "MYSQL_USER=" .env | cut -d '=' -f2)
    MYSQL_DB=$(grep "MYSQL_DATABASE=" .env | cut -d '=' -f2)
    
    print_info "Backing up database ke $BACKUP_FILE..."
    docker compose exec db mysqldump -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" > "$BACKUP_FILE"
    
    print_success "Backup completed: $BACKUP_FILE"
    ls -lh "$BACKUP_FILE"
}

cmd_restore() {
    echo -n "Masukkan nama file backup (contoh: backup_20240101_120000.sql): "
    read -r backup_file
    
    if [ ! -f "$backup_file" ]; then
        print_error "File tidak ditemukan: $backup_file"
        return 1
    fi
    
    MYSQL_PASS=$(grep "MYSQL_PASSWORD=" .env | cut -d '=' -f2)
    MYSQL_USER=$(grep "MYSQL_USER=" .env | cut -d '=' -f2)
    MYSQL_DB=$(grep "MYSQL_DATABASE=" .env | cut -d '=' -f2)
    
    print_warning "Ini akan menghapus database yang ada dan restore dari backup"
    echo -n "Lanjutkan? (yes/no): "
    read -r confirm
    
    if [ "$confirm" != "yes" ]; then
        print_info "Restore dibatalkan"
        return 0
    fi
    
    print_info "Restoring dari $backup_file..."
    docker compose exec -T db mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" < "$backup_file"
    
    print_success "Restore completed"
}

cmd_fix_permissions() {
    print_info "Fixing file permissions..."
    
    docker compose exec web chown -R www-data:www-data /var/www/html
    docker compose exec web chmod -R 755 /var/www/html
    docker compose exec web chmod -R 775 /var/www/html/upload/attachments
    docker compose exec web chmod -R 775 /var/www/html/upload/include
    
    print_success "Permissions fixed"
}

cmd_rebuild() {
    print_warning "Ini akan rebuild image tanpa cache"
    echo -n "Lanjutkan? (yes/no): "
    read -r confirm
    
    if [ "$confirm" != "yes" ]; then
        print_info "Rebuild dibatalkan"
        return 0
    fi
    
    print_info "Stopping containers..."
    docker compose stop
    
    print_info "Rebuilding image..."
    docker compose build --no-cache
    
    print_info "Starting containers..."
    docker compose up -d
    
    print_success "Rebuild completed"
}

cmd_health_check() {
    print_info "Performing health checks..."
    echo ""
    
    echo "1. Container status:"
    docker compose ps
    echo ""
    
    echo "2. Web service health:"
    docker compose exec web curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" http://localhost/
    echo ""
    
    echo "3. Database connection:"
    if docker compose exec web mysql -h db -u osticket -p$(grep "MYSQL_PASSWORD=" .env | cut -d '=' -f2) -e "SELECT 1;" > /dev/null 2>&1; then
        print_success "Database is accessible"
    else
        print_error "Database connection failed"
    fi
    echo ""
    
    echo "4. PHP extensions:"
    docker compose exec web php -m | grep -E "mysqli|gd|imap|intl|zip|mbstring" || print_warning "Some extensions may be missing"
    echo ""
    
    echo "5. Disk usage:"
    docker system df
}

# Main loop
while true; do
    show_menu
    read -r choice
    
    case $choice in
        1) cmd_start ;;
        2) cmd_stop ;;
        3) cmd_restart ;;
        4) cmd_logs ;;
        5) cmd_bash ;;
        6) cmd_mysql ;;
        7) cmd_backup ;;
        8) cmd_restore ;;
        9) cmd_fix_permissions ;;
        10) cmd_rebuild ;;
        11) cmd_health_check ;;
        12) 
            print_info "Exiting..."
            exit 0
            ;;
        *)
            print_error "Pilihan tidak valid"
            ;;
    esac
done
