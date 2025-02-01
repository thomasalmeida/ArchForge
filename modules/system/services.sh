#!/bin/bash

source "$(dirname "$0")/../../core/logging.sh"

configure_services() {
    log "INFO" "Configuring services..."

    # Configure selected environment
    source "modules/environments/hyprland.sh"
    configure_environment

    # Configure GPU if selected
    if [ "$GPU_VENDOR" != "none" ]; then
        source "modules/hardware/${GPU_VENDOR}.sh"
        configure_gpu
    fi

    # Configure core services
    source "modules/apps/services/audio.sh"
    configure_audio_services

    # Configure development tools
    source "modules/apps/development/docker.sh"
    configure_docker_services

    source "modules/apps/development/asdf.sh"
    configure_asdf

    # Configure core tools
    source "modules/apps/core_tools/git.sh"
    configure_git

    source "modules/apps/core_tools/vim.sh"
    configure_vim

    source "modules/apps/core_tools/fish.sh"
    configure_fish

    source "modules/apps/core_tools/starship.sh"
    configure_starship

    log "SUCCESS" "All services configured"
}
