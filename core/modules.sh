#!/bin/bash

# Array to store all module configurations
declare -A MODULES

# Register a module for configuration
register_module() {
    local category=$1
    local name=$2
    local script_path=$3
    local config_function=$4

    if [ ! -f "$script_path" ]; then
        log "WARNING" "Module script not found: $script_path"
        return 1
    }

    MODULES["${category}/${name}"]="${script_path}:${config_function}"
    log "INFO" "Registered module: ${category}/${name}"
}

# Configure registered modules in a category
configure_modules() {
    local category=$1
    local skip_errors=${2:-false}
    local total=0
    local configured=0

    # Count total modules in category
    for module in "${!MODULES[@]}"; do
        [[ $module == ${category}/* ]] && ((total++))
    done

    if [ $total -eq 0 ]; then
        log "WARNING" "No modules found in category: ${category}"
        return 0
    }

    log "INFO" "Configuring ${category} modules (${total} found)..."

    for module in "${!MODULES[@]}"; do
        if [[ $module == ${category}/* ]]; then
            local module_name=${module#*/}
            local module_data=${MODULES[$module]}
            local script_path=${module_data%:*}
            local config_function=${module_data#*:}

            log "INFO" "Configuring ${module_name}..."

            if source "$script_path"; then
                if $config_function; then
                    log "SUCCESS" "${module_name} configured successfully"
                    ((configured++))
                else
                    log "ERROR" "Failed to configure ${module_name}"
                    [[ "$skip_errors" != "true" ]] && return 1
                fi
            else
                log "ERROR" "Failed to source ${module_name} configuration"
                [[ "$skip_errors" != "true" ]] && return 1
            fi
        fi
    done

    log "SUCCESS" "Configured ${configured}/${total} modules in ${category}"
}
