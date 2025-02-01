# ArchForge

Personal scripts to automate my Arch Linux post-installation setup.

## Usage

```bash
git clone https://github.com/thomasalmeida/archforge.git
cd archforge
./install.sh
```

## Features

- System update and package manager configuration
- GPU driver setup (NVIDIA)
- Desktop environment installation (Hyprland)
- Development environment setup (Docker, ASDF)
- Shell configuration (Fish, Starship)
- Audio services (Pipewire)
- Personal dotfiles installation

## Configuration

Main package list is in `configs/packages/base.conf`:
- Add/remove packages as needed
- Comment out packages with # to skip installation

## Note

This is a personal configuration tool. Make sure to review the configs before running on your system.
