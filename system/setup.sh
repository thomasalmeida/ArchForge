#!/bin/bash

source "$(dirname "$0")/../scripts/utils.sh"

setup_system() {
    log_info "Setting up system..."

    # Install base packages only
    log_info "Installing base packages..."
    while read -r package; do
        [[ $package =~ ^# ]] || [ -z "$package" ] && continue
        yay -S --needed --noconfirm "$package" >> "$INSTALL_LOG" 2>> "$ERROR_LOG" || track_failed_package "$package"
    done < "packages/base.conf"

    log_success "Base system setup completed"
}

setup_system
