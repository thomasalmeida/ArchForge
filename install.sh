#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/core/init.sh"

# Register all modules
register_modules() {
    # Core system modules
    register_module "system" "boot" "${PROJECT_ROOT}/modules/system/boot.sh" "configure_boot"
    register_module "system" "pacman" "${PROJECT_ROOT}/modules/system/pacman.sh" "configure_pacman"
    register_module "system" "services" "${PROJECT_ROOT}/modules/system/services.sh" "configure_services"

    # Core tools
    register_module "core" "git" "${PROJECT_ROOT}/modules/apps/core_tools/git.sh" "configure_git"
    register_module "core" "vim" "${PROJECT_ROOT}/modules/apps/core_tools/vim.sh" "configure_vim"
    register_module "core" "fish" "${PROJECT_ROOT}/modules/apps/core_tools/fish.sh" "configure_fish"
    register_module "core" "starship" "${PROJECT_ROOT}/modules/apps/core_tools/starship.sh" "configure_starship"

    # Development tools
    register_module "dev" "asdf" "${PROJECT_ROOT}/modules/apps/development/asdf.sh" "configure_asdf"
    register_module "dev" "docker" "${PROJECT_ROOT}/modules/apps/development/docker.sh" "configure_docker_services"

    # Services
    register_module "services" "audio" "${PROJECT_ROOT}/modules/apps/services/audio.sh" "configure_audio_services"
}

main() {
    # ... resto do código ...
}
