#!/bin/bash
source "${ARCHFORGE_ROOT}/core/bootstrap.sh"

select_and_install_gpu() {
    log "INFO" "Selecting available GPU configurations..."

    local gpu_modules=()
    while IFS= read -r -d '' file; do
        local name=$(basename "$file" .sh)
        [ "$name" != "manager" ] && gpu_modules+=("$name")
    done < <(find "${PROJECT_ROOT}/modules/hardware" -maxdepth 1 -name '*.sh' -print0)

    if [ ${#gpu_modules[@]} -eq 0 ]; then
        log "WARNING" "No GPU configurations found"
        return 1
    fi

    echo "Available GPU configurations:"
    echo "Press Enter to skip GPU installation"
    PS3="Select GPU driver (1-${#gpu_modules[@]}): "
    select gpu in "${gpu_modules[@]}"; do
        if [ -z "$gpu" ]; then
            log "INFO" "No GPU configuration selected"
            break
        elif [ -n "$gpu" ]; then
            log "INFO" "Selected GPU: $gpu"
            source_module "modules/hardware/$gpu.sh"
            configure_gpu
            break
        fi
    done
}
