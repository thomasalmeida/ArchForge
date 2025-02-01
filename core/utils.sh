#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/init.sh"

# Track failed package installations
declare -a FAILED_PACKAGES=()

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

backup_file() {
    local file=$1
    if [ -f "$file" ]; then
        sudo cp "$file" "${file}.backup"
        log "INFO" "Backed up $file to ${file}.backup"
    fi
}

install_packages_from_list() {
    local config_file=$1
    local full_path="${PROJECT_ROOT}/${config_file}"

    log "INFO" "Installing packages from $config_file"

    if [ ! -f "$full_path" ]; then
        log "ERROR" "Package list not found: $config_file"
        return 1
    }

    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        log "ERROR" "Yay is not installed. Install it first."
        return 1
    }

    while read -r package; do
        # Skip comments and empty lines
        [[ $package =~ ^# ]] || [ -z "$package" ] && continue

        log "INFO" "Installing $package..."
        if ! yay -S --needed --noconfirm "$package"; then
            track_failed_package "$package"
            continue
        fi
        log "SUCCESS" "Installed $package"

    done < "$full_path"

    # Show installation summary
    show_failed_packages
}
