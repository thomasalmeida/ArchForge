#!/bin/bash

install_packages_from_list() {
    local config_file=$1
    log "INFO" "Installing packages from $config_file"

    while read -r package; do
        [[ $package =~ ^# ]] || [ -z "$package" ] && continue
        yay -S --needed --noconfirm "$package"
    done < "$config_file"
}
