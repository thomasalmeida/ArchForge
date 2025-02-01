#!/bin/bash

configure_environment() {
    log "INFO" "Configuring ASDF version manager..."

    # Install ASDF
    local latest_version=$(curl -s https://api.github.com/repos/asdf-vm/asdf/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$latest_version"

    # Configure shell integration
    if [ -x "$(command -v fish)" ]; then
        mkdir -p "$HOME/.config/fish/completions"
        echo "source $HOME/.asdf/asdf.fish" >> "$HOME/.config/fish/config.fish"
        ln -sf "$HOME/.asdf/completions/asdf.fish" "$HOME/.config/fish/completions"
    fi

    # Install essential plugins and latest versions
    local plugins=(
        "nodejs"
        "python"
        "ruby"
        "rust"
        "golang"
        "lazydocker"
    )

    for plugin in "${plugins[@]}"; do
        asdf plugin add "$plugin" || log "WARNING" "Failed to add plugin: $plugin"
        asdf install "$plugin" latest || log "WARNING" "Failed to install latest version of $plugin"
        asdf global "$plugin" latest || log "WARNING" "Failed to set global version for $plugin"
    done

    # Refresh shell paths
    asdf reshim

    log "SUCCESS" "ASDF configuration completed"
}
