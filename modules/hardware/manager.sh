#!/bin/bash

select_and_install_gpu() {
    log "INFO" "Detecting available GPU configurations..."

    local gpu_modules=()
    while IFS= read -r -d '' file; do
        gpu_modules+=("$(basename "$file" .sh)")
    done < <(find modules/hardware -maxdepth 1 -name '*.sh' -not -name 'manager.sh' -print0)

    PS3=$'\n'"Select GPU driver to install: "
    select gpu in "${gpu_modules[@]}" "Skip GPU Setup"; do
        case $gpu in
            "Skip GPU Setup")
                log "INFO" "Skipping GPU configuration"
                break
                ;;
            *)
                if [[ -n $gpu ]]; then
                    log "INFO" "Selected GPU: $gpu"
                    source "modules/hardware/$gpu.sh"
                    configure_gpu
                    break
                else
                    log "ERROR" "Invalid selection, try again"
                fi
                ;;
        esac
    done
}
