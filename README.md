# ArchForge

A personal script collection designed to automate my post-installation setup of Arch Linux. This tool configures my system with my commonly used applications, development tools, and personal settings.

## Installation

1. Clone the repository:
```bash
git clone https://github.com/thomasalmeida/archforge.git
cd archforge
```

2. Run the installer:
```bash
./install.sh
```

## What It Does

The installer will:

1. Update your system and configure pacman
2. Install and configure Yay for AUR support
3. Let you choose your GPU (currently supports NVIDIA)
4. Let you choose your desktop environment (currently supports Hyprland)
5. Install and configure selected packages
6. Configure system services (audio, docker, etc.)
7. Optionally install personal dotfiles

## Customization

The main package configuration is in `packages/base.conf`. You can customize your installation by:
- Adding new packages you want to install
- Removing packages you don't want
- Commenting out packages with # to skip installation

## Important Notes

- The installer requires sudo privileges for certain operations
- Some packages are installed from AUR, which might take longer to compile
- Make sure to backup your data before running the installer
- The dotfiles installation will override existing configurations in `~/.config`
