#!/bin/bash

source "$(dirname "$0")/../../scripts/utils.sh"

install_yay() {
    if ! command -v yay &> /dev/null; then
        log_info "Installing yay..."
        local temp_dir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$temp_dir" >/dev/null 2>> "$ERROR_LOG"
        (cd "$temp_dir" && makepkg -si --noconfirm >/dev/null 2>> "$ERROR_LOG")
        rm -rf "$temp_dir"
        log_success "Yay installed successfully"
    else
        log_info "Yay already installed"
    fi
}

configure_pacman() {
    log_info "Configuring pacman..."

    backup_file "/etc/pacman.conf"

    # Enable common pacman improvements
    sudo sed -i 's/#Color/Color/; s/#ParallelDownloads = 5/ParallelDownloads = 10/; s/#VerbosePkgLists/ILoveCandy/' /etc/pacman.conf

    install_yay
    log_success "Pacman configuration completed"
}

configure_pacman
