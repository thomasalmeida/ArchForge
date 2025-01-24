#!/bin/bash

source "scripts/utils.sh"

# Check for sudo privileges right at the start
check_sudo

configure_system() {
    bash "system/pacman/config.sh"
    bash "system/setup.sh"
    bash "system/boot/config.sh"
    bash "system/services.sh"
}

initialize_logs

# Prepare system and get user choices
source "scripts/prepare.sh"
prepare_system
prepare_installation

# Configure everything
configure_system
setup_dotfiles

# Show installation results
show_failed_packages

log_info "Installation log: $INSTALL_LOG"
log_info "Error log: $ERROR_LOG"

log_success "Installation completed!"
