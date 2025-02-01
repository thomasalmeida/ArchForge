#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../../core/init.sh"

configure_gpu() {
    log "INFO" "Configuring NVIDIA GPU..."

    # Install packages
    install_packages_from_list "configs/packages/nvidia.conf"

    # Essential kernel configuration
    log "INFO" "Setting up kernel modules..."
    sudo sed -i 's/^MODULES=(/&nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
    sudo mkinitcpio -P

    # Driver configuration
    log "INFO" "Configuring driver options..."
    echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf >/dev/null

    # Verification
    if ! nvidia-smi &> /dev/null; then
        log "ERROR" "NVIDIA drivers failed to initialize"
        exit 1
    fi

    log "SUCCESS" "NVIDIA GPU configured successfully"
}
