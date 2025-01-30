#!/bin/bash

select_and_install_environment() {
    log "INFO" "Detecting available environments..."

    local environments=($(ls modules/environments | grep -v manager.sh))

    PS3="Select your desktop environment: "
    select env in "${environments[@]}" "None"; do
        case $env in
            "None") break ;;
            *)
                if [[ -f "modules/environments/$env" ]]; then
                    source "modules/environments/$env"
                    configure_environment
                    break
                else
                    log "ERROR" "Invalid selection"
                fi
                ;;
        esac
    done
}
