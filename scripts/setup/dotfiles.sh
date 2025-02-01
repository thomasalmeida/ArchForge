#!/bin/bash
source "${ARCHFORGE_ROOT}/core/bootstrap.sh"

setup_dotfiles() {
    local dotfiles_repo="https://github.com/thomasalmeida/dotfiles.git"
    local config_dir="$HOME/.config"
    local temp_dir="/tmp/dotfiles_temp_$(date +%s)"

    log_info "Dotfiles configuration"

    read -p "Do you want to install personal dotfiles? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_info "Cloning dotfiles repository..."

        if git clone "$dotfiles_repo" "$temp_dir" 2>> "$ERROR_LOG"; then
            log_info "Installing dotfiles to $config_dir"
            mkdir -p "$config_dir"

            # Copy with verbose output
            rsync -vrul --progress "$temp_dir"/ "$config_dir"/ 2>> "$ERROR_LOG" && \
            log_success "Dotfiles installed successfully" || \
            log_error "Failed to copy dotfiles"

            rm -rf "$temp_dir"
        else
            log_error "Failed to clone dotfiles repository"
            return 1
        fi
    else
        log_info "Skipping dotfiles installation"
    fi
}
