#!/bin/bash

source "$(dirname "$0")/../../../scripts/utils.sh"

configure_nvidia() {
    log_info "Setting up NVIDIA GPU..."

    # Install packages
    install_packages_from_conf "$(dirname "$0")/packages.conf" "NVIDIA drivers and tools"

    # Configure kernel modules
    log_info "Configuring kernel modules..."
    sudo sed -i 's/^MODULES=(/&nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
    sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

    # Configure driver options
    log_info "Setting up driver options..."
    echo "options nvidia-drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf

    # Verify configuration
    if grep -q "options nvidia-drm modeset=1" /etc/modprobe.d/nvidia.conf; then
        log_success "NVIDIA GPU configuration verified"
    else
        log_error "NVIDIA GPU configuration verification failed"
        exit 1
    fi

    log_success "NVIDIA GPU setup completed"
}

configure_nvidia
