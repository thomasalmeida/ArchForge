#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../../../../core/init.sh"

configure_docker_services() {
    if command -v docker &> /dev/null; then
        log_info "Configuring docker services..."
        sudo systemctl enable docker.service
        log_success "Docker services configured"
    fi
}

configure_docker_services
