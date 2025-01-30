#!/bin/bash

source core/logging.sh
source core/utils.sh

main() {
    log "INFO" "Starting ArchForge installation"

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

    # Phase 4: Core Applications
    log "INFO" "=== APPLICATION SETUP ==="
    source modules/apps/core_tools.sh
    install_core_tools

    log "SUCCESS" "Installation completed successfully"
    log "INFO" "Please reboot your system to apply changes"
}

main "$@"
