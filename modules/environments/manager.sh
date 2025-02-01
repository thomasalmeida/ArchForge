#!/bin/bash

select_and_install_environment() {
    log "INFO" "Detecting available environments..."

    # Find all environment files excluding manager.sh
    local env_dir="modules/environments"
    local environments=()
    while IFS= read -r -d '' file; do
        # Get filename without .sh and exclude manager
        local env_name=$(basename "$file" .sh)
        if [ "$env_name" != "manager" ]; then
            environments+=("$env_name")
        fi
    done < <(find "$env_dir" -maxdepth 1 -type f -name "*.sh" -print0)

    if [ ${#environments[@]} -eq 0 ]; then
        log "ERROR" "No environment configurations found"
        return 1
    fi

    # Show selection menu
    PS3=$'\n'"Select desktop environment to install: "
    select env in "${environments[@]}" "None"; do
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
