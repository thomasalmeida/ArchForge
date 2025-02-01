#!/bin/bash

select_and_install_environment() {
    log "INFO" "Selecting available environments..."

    local env_dir="${PROJECT_ROOT}/modules/environments"
    local environments=()

    while IFS= read -r -d '' file; do
        local env_name=$(basename "$file" .sh)
        [ "$env_name" != "manager" ] && environments+=("$env_name")
    done < <(find "$env_dir" -maxdepth 1 -type f -name "*.sh" -print0)

    if [ ${#environments[@]} -eq 0 ]; then
        log "ERROR" "No environment configurations found"
        return 1
    fi

    echo "Available desktop environments:"
    echo "Press Enter to skip environment installation"
    PS3="Select desktop environment (1-${#environments[@]}): "
    select env in "${environments[@]}"; do
        if [ -z "$env" ]; then
            log "INFO" "No environment selected"
            break
        elif [ -n "$env" ]; then
            log "INFO" "Selected environment: $env"
            source_module "modules/environments/$env.sh"
            configure_environment
            break
        fi
    done
}
