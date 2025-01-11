#!/bin/bash

source "$(dirname "$0")/../../../scripts/utils.sh"

setup_asdf() {
    if ! command -v asdf &> /dev/null; then
        log_error "ASDF is not installed"
        return 1
    fi

    # Get latest release
    latest_asdf_release=$(curl -s "https://api.github.com/repos/asdf-vm/asdf/releases/latest" | jq -r .tag_name)

    # Clone ASDF if not exists
    if [ ! -d "$HOME/.asdf" ]; then
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $latest_asdf_release

        # Setup completions
        mkdir -p ~/.config/fish/completions
        ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
    fi

    # Add plugins
    asdf plugin add nodejs
    asdf plugin add python
    asdf plugin add ruby
    asdf plugin add rust
    asdf plugin add golang

    # Install latest versions
    asdf install nodejs latest
    asdf install python latest
    asdf install ruby latest
    asdf install rust latest
    asdf install golang latest

    # Set global versions
    asdf global nodejs latest
    asdf global python latest
    asdf global ruby latest
    asdf global rust latest
    asdf global golang latest

    log_success "Programming languages installed via ASDF"
}

setup_asdf
