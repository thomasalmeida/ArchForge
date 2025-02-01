#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../../core/init.sh"

install_yay() {
    if ! command -v yay &> /dev/null; then
        log "INFO" "Installing yay..."
        local temp_dir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$temp_dir"
        (cd "$temp_dir" && makepkg -si --noconfirm)
        rm -rf "$temp_dir"
        log "SUCCESS" "Yay installed successfully"
    else
        log "INFO" "Yay already installed"
    fi
}

configure_pacman() {
    log "INFO" "Configuring pacman..."

    backup_file "/etc/pacman.conf"

    # Enable common pacman improvements
    sudo sed -i 's/#Color/Color/; s/#ParallelDownloads = 5/ParallelDownloads = 10/; s/#VerbosePkgLists/ILoveCandy/' /etc/pacman.conf

    install_yay
    log "SUCCESS" "Pacman configuration completed"
}
