#!/bin/bash

# Get the project root directory
export PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Core utilities
source "${PROJECT_ROOT}/core/logging.sh"
source "${PROJECT_ROOT}/core/utils.sh"
source "${PROJECT_ROOT}/core/modules.sh"

# Function to source module files
source_module() {
    local module_path="$1"
    local full_path="${PROJECT_ROOT}/${module_path}"

    if [ -f "$full_path" ]; then
        source "$full_path"
    else
        log "ERROR" "Module not found: ${module_path}"
        return 1
    fi
}
