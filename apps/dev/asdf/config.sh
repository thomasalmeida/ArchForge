#!/bin/bash

source "$(dirname "$0")/../../../scripts/utils.sh"

install_asdf() {
    log_info "Installing asdf version manager..."

    # Get latest release
    log_info "Getting latest asdf version..."
    latest_asdf_release=$(curl -s "https://api.github.com/repos/asdf-vm/asdf/releases/latest" | jq -r .tag_name)

    # Clone asdf repo with latest version
    log_info "Cloning asdf repository..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $latest_asdf_release

    log_success "asdf installation complete! Proceeding with configuration..."
}

setup_asdf() {
    if ! command -v asdf &> /dev/null; then
        log_error "asdf is not installed"
        return 1
    }

    log_info "Configuring asdf plugins and runtime versions..."

    # Development tools
    local plugins=(
        "nodejs"
        "python"
        "ruby"
        "rust"
        "golang"
        "lazydocker"
    )

    # Install plugins and latest versions
    for plugin in "${plugins[@]}"; do
        log_info "Setting up $plugin..."
        asdf plugin add "$plugin"
        asdf install "$plugin" latest
        asdf global "$plugin" latest
    done

    # Rehash after installing all tools
    asdf reshim

    log_success "Programming languages and tools installed via asdf"
}

configure_asdf() {
    install_asdf
    source "$HOME/.asdf/asdf.sh"
    setup_asdf
}

configure_asdf
