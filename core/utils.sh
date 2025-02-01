#!/bin/bash

source "$(dirname "$0")/logging.sh"

# Track failed package installations
FAILED_PACKAGES=()

track_failed_package() {
    FAILED_PACKAGES+=("$1")
    log "ERROR" "Failed to install: $1"
}

show_failed_packages() {
    if [ ${#FAILED_PACKAGES[@]} -eq 0 ]; then
        log "SUCCESS" "All packages installed successfully"
        return 0
    fi

    log "WARNING" "The following packages failed to install:"
    printf '%s\n' "${FAILED_PACKAGES[@]}"
    return 1
}

install_packages_from_list() {
    local config_file=$1
    log "INFO" "Installing packages from $config_file"

    while read -r package; do
        # Skip comments and empty lines
        [[ $package =~ ^# ]] || [ -z "$package" ] && continue

        log "INFO" "Installing $package..."
        if ! yay -S --needed --noconfirm "$package"; then
            track_failed_package "$package"
            continue
        fi
        log "SUCCESS" "Installed $package"

    done < "$config_file"

    # Show installation summary
    show_failed_packages
}
