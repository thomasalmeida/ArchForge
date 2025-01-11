#!/bin/bash

source "$(dirname "$0")/utils.sh"

select_from_options() {
    local dir=$1
    local prompt=$2
    local add_none=$3

    # Get options from directory
    local options=($(ls "$dir"))

    # Add "none" option if requested
    if [ "$add_none" = "true" ]; then
        options+=("none")
    fi

    # Show selection menu
    PS3="$prompt: "
    select choice in "${options[@]}"; do
        if [[ " ${options[@]} " =~ " ${choice} " ]]; then
            echo "$choice"
            break
        else
            echo "Invalid option"
        fi
    done
}

setup_user_choices() {
    # Select desktop environment
    ENV_CHOICE=$(select_from_options "environments" "Select your desktop environment" "false")
    log_info "Selected environment: $ENV_CHOICE"
    export ENV_CHOICE

    # Select GPU
    GPU_VENDOR=$(select_from_options "hardware/gpu" "Select your GPU type" "true")
    log_info "Selected GPU: $GPU_VENDOR"
    export GPU_VENDOR
}
