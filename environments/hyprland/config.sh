#!/bin/bash

source "$(dirname "$0")/../../scripts/utils.sh"

configure_hyprland() {
    log_info "Configuring Hyprland..."

    # Install packages
    install_packages_from_conf "$(dirname "$0")/packages.conf" "Hyprland packages"

    # Verify installation
    if ! command -v Hyprland &> /dev/null; then
        log_error "Hyprland is not installed"
        return 1
    fi

    log_success "Hyprland configured successfully"
}

configure_hyprland
