#!/bin/bash

source "$(dirname "$0")/../../scripts/utils.sh"

configure_boot() {
    log_info "Configuring systemd-boot..."

    # Remove timeout
    sudo sed -i 's/timeout .*/timeout 0/' /boot/loader/loader.conf

    # Remove quiet parameter from all entries
    sudo find /boot/loader/entries -name "*.conf" -exec sed -i 's/quiet//' {} +

    log_success "Boot configuration completed"
}

configure_boot
