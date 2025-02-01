#!/bin/bash

configure_vim() {
    log_info "Configuring Vim..."
    cp "$(dirname "$0")/vimrc" "$HOME/.vimrc"
    log_success "Vim configuration completed"
}

configure_vim
