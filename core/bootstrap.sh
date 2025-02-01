#!/bin/bash

setup_environment() {
    # Project directories
    export ARCHFORGE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    export ARCHFORGE_CONFIG_DIR="${ARCHFORGE_ROOT}/configs"
    export ARCHFORGE_LOG="/tmp/archforge.log"

    # Create log file
    touch "$ARCHFORGE_LOG"

    # Import core functions
    source "${ARCHFORGE_ROOT}/core/logging.sh"
    source "${ARCHFORGE_ROOT}/core/utils.sh"
    source "${ARCHFORGE_ROOT}/core/modules.sh"
}

setup_environment
