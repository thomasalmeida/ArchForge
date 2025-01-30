#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_env_packages() {
    local conf_file="environments/${ENV_CHOICE}/packages.conf"
    install_packages_from_conf "$conf_file" "${ENV_CHOICE} environment"
}

install_gpu_packages() {
    if [ "$GPU_VENDOR" != "none" ]; then
        local conf_file="hardware/gpu/${GPU_VENDOR}/packages.conf"
        install_packages_from_conf "$conf_file" "${GPU_VENDOR} GPU"
    else
        log_info "Skipping GPU packages installation"
    fi
}
