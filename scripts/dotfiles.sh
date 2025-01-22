#!/bin/bash

source "$(dirname "$0")/utils.sh"

setup_dotfiles() {
    local dotfiles_repo="https://github.com/thomasalmeida/dotfiles.git"
    local config_dir="$HOME/.config"
    local temp_dir="/tmp/dotfiles_temp"

    read -p "Do you want to install personal dotfiles? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_info "Setting up dotfiles..."

        # Clone dotfiles to temp directory
        git clone "$dotfiles_repo" "$temp_dir"

        # Create .config if it doesn't exist
        mkdir -p "$config_dir"

        # Move everything from temp to .config, forcing overwrite
        cp -rf "$temp_dir"/* "$temp_dir"/.[!.]* "$config_dir" 2>/dev/null

        log_success "Dotfiles installed successfully"
    else
        log_info "Skipping dotfiles installation"
    fi
}
