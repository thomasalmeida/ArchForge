#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Log files
INSTALL_LOG="/tmp/archforge_install.log"
ERROR_LOG="/tmp/archforge_error.log"

# Logging functions
log_info() {
    local msg="[INFO] $1"
    echo -e "${BLUE}${msg}${NC}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ${msg}" >> "$INSTALL_LOG"
}

log_success() {
    local msg="[SUCCESS] $1"
    echo -e "${GREEN}${msg}${NC}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ${msg}" >> "$INSTALL_LOG"
}

log_warning() {
    local msg="[WARNING] $1"
    echo -e "${YELLOW}${msg}${NC}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ${msg}" >> "$INSTALL_LOG"
}

log_error() {
    local msg="[ERROR] $1"
    echo -e "${RED}${msg}${NC}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ${msg}" >> "$ERROR_LOG"
}

# Initialize log files
initialize_logs() {
    > "$INSTALL_LOG"
    > "$ERROR_LOG"
    chmod 600 "$INSTALL_LOG" "$ERROR_LOG"
}

# Helper functions
backup_file() {
    local file=$1
    if [ -f "$file" ]; then
        cp "$file" "${file}.backup"
        log_info "Backed up $file to ${file}.backup"
    fi
}

create_directory() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        log_info "Created directory $dir"
    fi
}

install_packages_from_conf() {
    local conf_file=$1
    local description=$2

    log_info "Installing ${description}..."
    while read -r package; do
        [[ $package =~ ^# ]] || [ -z "$package" ] && continue
        yay -S --needed --noconfirm "$package" >> "$INSTALL_LOG" 2>> "$ERROR_LOG" || track_failed_package "$package"
    done < "$conf_file"
    log_success "${description} installed successfully"
}

# Failed packages tracking
FAILED_PACKAGES=()

track_failed_package() {
    FAILED_PACKAGES+=("$1")
    log_error "Failed to install: $1"
}

show_failed_packages() {
    if [ ${#FAILED_PACKAGES[@]} -eq 0 ]; then
        log_success "All packages installed successfully"
    else
        log_warning "Failed packages:"
        printf '%s\n' "${FAILED_PACKAGES[@]}" | tee -a "$ERROR_LOG"
    fi
}
