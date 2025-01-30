#!/bin/bash

source "$(dirname "$0")/../../../scripts/utils.sh"

configure_git() {
    log_info "Configuring Git..."

    read -p "Do you want to configure git user settings? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter your git user name: " git_name
        read -p "Enter your git email: " git_email

        # Copy base config
        cp "$(dirname "$0")/gitconfig" "$HOME/.gitconfig" || {
            log_error "Failed to copy gitconfig"
            return 1
        }

        # Add user settings
        git config --global user.name "$git_name"
        git config --global user.email "$git_email"

        log_success "Git configured with user settings"
    else
        # Copy only base config
        cp "$(dirname "$0")/gitconfig" "$HOME/.gitconfig"
        log_info "Git configured without user settings"
    fi

    log_success "Git configuration completed"
}

configure_git
