#!/bin/bash

source "$(dirname "$0")/utils.sh"

prepare_system() {
    log_info "Preparing system for installation..."

    # Verify directories and files
    validate_config_paths || return 1

    # Verify directories structure
    check_required_dirs || return 1

    # Update system
    sudo pacman -Syu --noconfirm

    # Configure pacman and install yay
    bash "system/pacman/config.sh"

    # Install base system packages with progress
    log_info "Installing base system packages..."
    bash "system/setup.sh"

    log_success "System preparation completed"
}

check_required_dirs() {
    local required_dirs=(
        "environments"
        "hardware/gpu"
        "system/boot"
    )

    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            log_error "Missing required directory: $dir"
            return 1
        fi
    done
}

prepare_installation() {
    source "scripts/setup.sh"
    setup_user_choices
    setup_dotfiles
}
