#!/bin/bash
source "${ARCHFORGE_ROOT}/core/bootstrap.sh"

configure_boot() {
    log "INFO" "Configuring systemd-boot..."

    local loader_conf="/boot/loader/loader.conf"
    local entries_dir="/boot/loader/entries"

    # Create entries directory if it doesn't exist
    if [ ! -d "$entries_dir" ]; then
        sudo mkdir -p "$entries_dir"
    fi

    # Configure loader if it exists
    if [ -f "$loader_conf" ]; then
        # Remove timeout
        sudo sed -i 's/timeout .*/timeout 0/' "$loader_conf"

        # Remove quiet parameter from all entries
        sudo find "$entries_dir" -name "*.conf" -exec sed -i 's/ quiet//g' {} +

        log "SUCCESS" "Boot configuration completed"
    else
        log "ERROR" "loader.conf not found at $loader_conf"
        return 1
    fi
}
