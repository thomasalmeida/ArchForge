#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_env_packages() {
    log_info "Installing environment specific packages..."
    while read -r package; do
        [[ $package =~ ^# ]] || [ -z "$package" ] && continue
        yay -S --needed --noconfirm "$package" >> "$INSTALL_LOG" 2>> "$ERROR_LOG" || track_failed_package "$package"
    done < "environments/${ENV_CHOICE}/packages.conf"

    log_success "Environment packages installed successfully"
}

install_gpu_packages() {
    log_info "Installing GPU specific packages..."
    while read -r package; do
        [[ $package =~ ^# ]] || [ -z "$package" ] && continue
        yay -S --needed --noconfirm "$package" >> "$INSTALL_LOG" 2>> "$ERROR_LOG" || track_failed_package "$package"
    done < "hardware/gpu/${GPU_VENDOR}/packages.conf"

    log_success "GPU packages installed successfully"
}
