#!/bin/bash

# Get the project root directory
export PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Core utilities in order
source "${PROJECT_ROOT}/core/logging.sh"
source "${PROJECT_ROOT}/core/utils.sh"
source "${PROJECT_ROOT}/core/modules.sh"

# Export core functions
export -f register_module
export -f configure_modules
export -f source_module
export -f log
export -f track_failed_package
export -f show_failed_packages
export -f backup_file
export -f install_packages_from_list
