#!/bin/bash

select_and_install_environment() {
    log "INFO" "Selecting available environments..."

    local env_dir="modules/environments"
    local environments=()

    while IFS= read -r -d '' file; do
        local env_name=$(basename "$file" .sh)
        [ "$env_name" != "manager" ] && environments+=("$env_name")
    done < <(find "$env_dir" -maxdepth 1 -type f -name "*.sh" -print0)

    if [ ${#environments[@]} -eq 0 ]; then
        log "ERROR" "No environment configurations found"
        return 1
    fi

    environments+=("None")

    echo "Available desktop environments:"
    PS3="Select desktop environment (1-${#environments[@]}): "
    select env in "${environments[@]}"; do
        case $env in
            "None")
                log "INFO" "Skipping environment installation"
                break
                ;;
            *)
                if [[ " ${environments[@]} " =~ " ${env} " ]]; then
                    log "INFO" "Selected environment: $env"
                    source "$env_dir/$env.sh"
                    configure_environment
                    break
                else
                    log "ERROR" "Invalid selection"
                fi
                ;;
        esac
    done
}
