#!/bin/bash

#!/bin/bash
source "$(dirname "$0")/utils.sh"

setup_user_choices() {
    local base_dir="$(realpath "$(dirname "$0")/..")"

    # Environment selection
    ENV_CHOICE=$(select_from_options "${base_dir}/environments" "Select desktop environment" "false") || {
        log_error "Failed to select environment"
        return 1
    }
    log_info "Selected environment: ${ENV_CHOICE}"
    export ENV_CHOICE

    # GPU selection
    GPU_VENDOR=$(select_from_options "${base_dir}/hardware/gpu" "Select GPU type" "true") || {
        log_error "Failed to select GPU"
        return 1
    }
    log_info "Selected GPU: ${GPU_VENDOR}"
    export GPU_VENDOR
}
