#!/bin/bash

source "$(dirname "$0")/../../../../scripts/utils.sh"

configure_starship() {
    if command -v starship &> /dev/null; then
        create_dir_if_missing "$HOME/.config" || {
            log_error "Failed to create config directory"
            return 1
        }
        starship init fish > "$HOME/.config/fish/conf.d/starship.fish"
        log_success "Starship prompt configured successfully"
    else
        log_error "Starship is not installed"
    fi
}

configure_starship
