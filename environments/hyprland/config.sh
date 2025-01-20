#!/bin/bash

source "$(dirname "$0")/../../scripts/utils.sh"

configure_electron() {
    # Configure electron for better Wayland support
    echo "--enable-features=WaylandWindowDecorations" > "$HOME/.config/electron-flags.conf"
    echo "--ozone-platform-hint=auto" >> "$HOME/.config/electron-flags.conf"
    echo "--enable-features=UseOzonePlatform" >> "$HOME/.config/electron-flags.conf"
    echo "--ozone-platform=wayland" >> "$HOME/.config/electron-flags.conf"
}

configure_hyprland() {
    log_info "Configuring Hyprland..."

    # Install packages
    install_packages_from_conf "$(dirname "$0")/packages.conf" "Hyprland packages"

    # Verify installation
    if ! command -v Hyprland &> /dev/null; then
        log_error "Hyprland is not installed"
        return 1
    fi

    configure_electron()

    log_success "Hyprland configured successfully"
}

configure_hyprland
