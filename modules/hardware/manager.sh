#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../../core/init.sh"

select_and_install_gpu() {
    log "INFO" "Selecting available GPU configurations..."

    local gpu_modules=()
    while IFS= read -r -d '' file; do
        local name=$(basename "$file" .sh)
        [ "$name" != "manager" ] && gpu_modules+=("$name")
    done < <(find modules/hardware -maxdepth 1 -name '*.sh' -print0)

    if [ ${#gpu_modules[@]} -eq 0 ]; then
        log "WARNING" "No GPU configurations found"
        return 1
    fi

    gpu_modules+=("Skip GPU Setup")

    echo "Available GPU configurations:"
    PS3="Select GPU driver (1-${#gpu_modules[@]}): "
    select gpu in "${gpu_modules[@]}"; do
        if [ "$gpu" = "Skip GPU Setup" ]; then
            log "INFO" "Skipping GPU configuration"
            break
        elif [ -n "$gpu" ]; then
            log "INFO" "Selected GPU: $gpu"
            source "modules/hardware/$gpu.sh"
            configure_gpu
            break
        else
            log "ERROR" "Invalid selection"
        fi
    done
}
