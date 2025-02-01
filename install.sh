#!/bin/bash

source core/logging.sh
source core/utils.sh
source core/modules.sh

# Register all modules
register_modules() {
    # Core tools
    register_module "core" "git" "modules/apps/core_tools/git.sh" "configure_git"
    register_module "core" "vim" "modules/apps/core_tools/vim.sh" "configure_vim"
    register_module "core" "fish" "modules/apps/core_tools/fish.sh" "configure_fish"
    register_module "core" "starship" "modules/apps/core_tools/starship.sh" "configure_starship"

    # Development tools
    register_module "dev" "asdf" "modules/apps/development/asdf.sh" "configure_asdf"
    register_module "dev" "docker" "modules/apps/development/docker.sh" "configure_docker_services"

    # Services
    register_module "services" "audio" "modules/apps/services/audio.sh" "configure_audio_services"
}

main() {
    log "INFO" "Starting ArchForge installation"

    # Register all modules
    register_modules

    # Phase 1: System Setup
    log "INFO" "=== SYSTEM CONFIGURATION ==="
    source modules/system/pacman.sh
    configure_pacman

    # Phase 2: Hardware Setup
    log "INFO" "=== HARDWARE CONFIGURATION ==="
    source modules/hardware/manager.sh
    select_and_install_gpu

    # Phase 3: Environment Setup
    log "INFO" "=== DESKTOP ENVIRONMENT ==="
    source modules/environments/manager.sh
    select_and_install_environment

    # Phase 4: Configure all modules by category
    log "INFO" "=== CONFIGURING MODULES ==="
    configure_modules "core" true
    configure_modules "dev" true
    configure_modules "services" true

    log "SUCCESS" "Installation completed successfully"
    log "INFO" "Please reboot your system to apply changes"
}

main "$@"
