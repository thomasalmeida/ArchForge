#!/bin/bash

configure_environment() {
    log "INFO" "Configuring Hyprland..."

    # Install packages
    install_packages_from_list "configs/packages/hyprland.conf"

    # Configure electron
    configure_electron() {
        echo "--enable-features=WaylandWindowDecorations" > "$HOME/.config/electron-flags.conf"
        echo "--ozone-platform-hint=auto" >> "$HOME/.config/electron-flags.conf"
    }

    configure_electron

    log "SUCCESS" "Hyprland configured successfully"
}
