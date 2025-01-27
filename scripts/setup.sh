#!/bin/bash

source "$(dirname "$0")/utils.sh"

select_from_options() {
    local dir=$1
    local prompt=$2
    local add_none=$3
    local options=()

    # Get valid options from directory
    if [ -d "$dir" ]; then
        options=($(ls "$dir"))
    else
        log_error "Directory not found: $dir"
        return 1
    fi

    # Add "none" option if requested
    [ "$add_none" = "true" ] && options+=("none")

    # Show selection menu
    PS3="$prompt: "
    select choice in "${options[@]}"; do
        if [[ " ${options[*]} " =~ " ${choice} " ]]; then
            echo "$choice"
            return 0
        else
            log_error "Invalid option"
            return 1
        fi
    done
}

setup_user_choices() {
    local base_dir="$(dirname "$0")/.."

    # Environment selection
    ENV_CHOICE=$(select_from_options "${base_dir}/environments" "Select desktop environment" "false")
    log_info "Selected environment: ${ENV_CHOICE}"
    export ENV_CHOICE

    # GPU selection
    GPU_VENDOR=$(select_from_options "${base_dir}/hardware/gpu" "Select GPU type" "true")
    log_info "Selected GPU: ${GPU_VENDOR}"
    export GPU_VENDOR
}
