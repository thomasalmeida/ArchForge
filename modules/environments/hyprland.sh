#!/bin/bash
source "${ARCHFORGE_ROOT}/core/bootstrap.sh"

configure_environment() {
    log "INFO" "Configuring Hyprland..."

    # Install packages
    install_packages_from_list "configs/packages/hyprland.conf"

    # Configure electron for better Wayland support
    configure_electron() {
        local electron_flags="$HOME/.config/electron-flags.conf"
        echo "--enable-features=WaylandWindowDecorations" > "$electron_flags"
        echo "--ozone-platform-hint=auto" >> "$electron_flags"
        echo "--enable-features=UseOzonePlatform" >> "$electron_flags"
        echo "--ozone-platform=wayland" >> "$electron_flags"
    }

    configure_electron

    log "SUCCESS" "Hyprland configured successfully"
}
