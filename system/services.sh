#!/bin/bash

source "$(dirname "$0")/../scripts/utils.sh"

configure_services() {
    log_info "Configuring services..."

    # Configure selected environment
    bash "environments/${ENV_CHOICE}/config.sh"

    # Configure GPU if selected
    if [ "$GPU_VENDOR" != "none" ]; then
        bash "hardware/gpu/${GPU_VENDOR}/config.sh"
    fi

    # Configure core services
    bash "apps/core/services/audio/services.sh"

    # Configure shell
    bash "apps/core/shell/fish/config.sh"
    bash "apps/core/shell/starship/config.sh"

    # Configure development tools
    bash "apps/dev/docker/services.sh"
    bash "apps/dev/asdf/config.sh"

    log_success "All services configured"
}

configure_services
