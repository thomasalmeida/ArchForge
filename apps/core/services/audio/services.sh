#!/bin/bash

source "$(dirname "$0")/../../../../scripts/utils.sh"

configure_audio_services() {
    log_info "Configuring audio services..."

    systemctl --user enable pipewire.service
    systemctl --user enable pipewire-pulse.service

    log_success "Audio services configured"
}

configure_audio_services
