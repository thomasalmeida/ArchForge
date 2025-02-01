#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../../../../core/init.sh"

configure_fish() {
    if command -v fish &> /dev/null; then
        # Add fish to shells if not present
        if ! grep -q "fish" /etc/shells; then
            echo "/usr/bin/fish" | sudo tee -a /etc/shells
        fi

        # Set as default shell
        chsh -s /usr/bin/fish || log_error "Failed to set fish as default shell"

        # Install Oh My Fish
        fish -c "curl -L https://get.oh-my.fish | fish" || log_error "Failed to install Oh My Fish"

        # Install Catppuccin theme
        fish -c "omf install https://github.com/catppuccin/fish" || log_error "Failed to install Catppuccin theme"

        log_success "Fish shell configured successfully"
    else
        log_error "Fish shell is not installed"
    fi
}

configure_fish
