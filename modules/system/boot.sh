#!/bin/bash

source "$(dirname "$0")/../../scripts/utils.sh"

configure_boot() {
    log_info "Configuring systemd-boot..."

    local loader_conf="/boot/loader/loader.conf"

    # Create directory if not exists
    sudo mkdir -p /boot/loader/entries

    # Only modify if file exists
    if [ -f "$loader_conf" ]; then
        # Remove timeout
        sudo sed -i 's/timeout .*/timeout 0/' "$loader_conf"

        # Remove quiet parameter from all entries
        sudo find /boot/loader/entries -name "*.conf" -exec sed -i 's/ quiet//g' {} +
        log_success "Boot configuration completed"
    else
        log_warning "loader.conf not found, skipping boot configuration"
    fi
}

configure_boot
