#!/bin/bash

source "$(dirname "$0")/../../../scripts/utils.sh"

configure_asdf() {
    local asdf_dir="$HOME/.asdf"
    local fish_conf="$HOME/.config/fish/config.fish"

    log_info "Configuring asdf version manager..."

    # Clone asdf repository if not exists
    if [ ! -d "$asdf_dir" ]; then
        git clone https://github.com/asdf-vm/asdf.git "$asdf_dir" --branch v0.14.0 >> "$INSTALL_LOG" 2>> "$ERROR_LOG" || {
            log_error "Failed to clone asdf repository"
            return 1
        }
    fi

    # Configure Fish shell
    if [ -x "$(command -v fish)" ]; then
        log_info "Setting up Fish shell integration"

        # Create fish config directory if needed
        mkdir -p "$(dirname "$fish_conf")"

        # Add asdf to fish configuration
        if ! grep -q 'asdf.fish' "$fish_conf"; then
            echo "source $HOME/.asdf/asdf.fish" >> "$fish_conf"

            # Completions for fish
            mkdir -p "$HOME/.config/fish/completions"
            ln -sfv "$asdf_dir/completions/asdf.fish" "$HOME/.config/fish/completions/asdf.fish" >> "$INSTALL_LOG" 2>> "$ERROR_LOG"
        fi

        # Add plugins path to fish
        if ! fish -c 'echo $fish_user_paths' | grep -q '.asdf/bin'; then
            fish -c "set -Ua fish_user_paths $HOME/.asdf/bin" >> "$INSTALL_LOG" 2>> "$ERROR_LOG"
        fi
    else
        log_warning "Fish shell not found, skipping asdf integration"
    fi

    # Install plugins
    log_info "Installing asdf plugins..."
    local plugins=(
        "nodejs https://github.com/asdf-vm/asdf-nodejs.git"
        "python https://github.com/danhper/asdf-python.git"
        "rust https://github.com/code-lever/asdf-rust.git"
    )

    for plugin in "${plugins[@]}"; do
        read -r name repo <<< "$plugin"
        asdf plugin-add "$name" "$repo" >> "$INSTALL_LOG" 2>> "$ERROR_LOG" || {
            log_warning "Failed to add $name plugin"
            continue
        }
        log_info "Added $name plugin"
    done

    log_success "asdf configuration completed"
}

configure_asdf
