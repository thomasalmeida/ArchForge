#!/bin/bash

source "$(dirname "$0")/../../scripts/utils.sh"

install_yay() {
    if ! command -v yay &> /dev/null; then
        log_info "Installing yay..."
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si --noconfirm
        cd .. && rm -rf yay
        log_success "Yay installed successfully"
    else
        log_info "Yay already installed"
    fi
}

configure_pacman() {
    log_info "Configuring pacman..."

    backup_config "/etc/pacman.conf"

    # Configure pacman
    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
    sudo sed -i 's/#VerbosePkgLists/ILoveCandy/' /etc/pacman.conf

    # Install yay first
    install_yay

    log_success "Pacman configuration completed"
}

configure_pacman
