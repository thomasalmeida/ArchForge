#!/bin/bash

source "$(dirname "$0")/../scripts/utils.sh"

setup_system() {
    log_info "Installing base system packages..."
    local base_conf="$(realpath "$(dirname "$0")/../packages/base.conf")"

    if [ -f "$base_conf" ]; then
        install_packages_from_conf "$base_conf" "base system" "--progress"
    else
        log_error "base.conf not found at: $base_conf"
        return 1
    fi
}

setup_system
