#!/bin/bash

source "$(dirname "$0")/utils.sh"

prepare_system() {
    log_info "Preparing system for installation..."

    # Update system
    sudo pacman -Syu --noconfirm

    # Configure pacman and install yay
    bash "system/pacman/config.sh"

    # Install base system packages
    bash "system/setup.sh"

    log_success "System preparation completed"
}

prepare_installation() {
    source "scripts/setup.sh"
    setup_user_choices
}
