#!/bin/bash

source "$(dirname "$0")/../../../../scripts/utils.sh"

configure_fish() {
    if command -v fish &> /dev/null; then
        # Add fish to shells if not present
        if ! grep -q "fish" /etc/shells; then
            echo "/usr/bin/fish" | sudo tee -a /etc/shells
        fi

        # Set as default shell
        chsh -s /usr/bin/fish

        # Install Oh My Fish
        fish -c "curl -L https://get.oh-my.fish | fish"

        # Install Catppuccin theme
        fish -c "omf install https://github.com/catppuccin/fish"

        log_success "Fish shell configured successfully"
    else
        log_error "Fish shell is not installed"
    fi
}

configure_fish
