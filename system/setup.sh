#!/bin/bash

source "$(dirname "$0")/../scripts/utils.sh"

setup_system() {
    log_info "Installing base system packages..."
    local base_conf="$(dirname "$0")/../packages/base.conf"
    install_packages_from_conf "$base_conf" "base system"
}

setup_system
