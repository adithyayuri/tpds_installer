# TPDS Installer for Debian Linux

This repository contains scripts to help install and uninstall the Microchip Trustplatform Design Suite (TPDS) on Debian-based Linux systems.

## Overview

The Microchip Trustplatform Design Suite (TPDS) is a development environment for configuring, programming, and debugging Microchip's security solutions. These scripts automate the installation process and set up all necessary dependencies and system configurations.

## Features

- **Automatic Python 3.10 installation** (only if not already installed)
- **Virtual environment creation** for isolated dependencies
- **UDEV rules setup** for Microchip development kits
- **Desktop shortcut creation** for easy access
- **Launcher script** for proper environment setup

## System Requirements

- Debian-based Linux distribution (Debian, Ubuntu, Linux Mint, etc.)
- Internet connection
- Administrator (sudo) privileges

## Installation

### Quick Install

1. Download install script:
   ```
   wget https://github.com/adithyayuri/tpds_installer/blob/main/debian/install.sh
   ```

2. Make the installer script executable:
   ```
   chmod +x install_tpds.sh
   ```

3. Run the installer (Administrator sudo privileges are required for updating udev rules and installation of python addons):
   ```
   sudo ./install_tpds.sh
   ```

4. Restart your system (recommended for UDEV rules to take effect)

### What the Installer Does

1. Checks if Python 3.10 is already installed
2. If not found, installs Python 3.10 using the most appropriate method:
   - Package manager (apt) for Ubuntu/Debian
   - pyenv for other systems or if package manager fails
3. Creates a Python virtual environment for TPDS
4. Installs TPDS and extension packages
5. Sets up UDEV rules for Microchip development kits
6. Creates launcher script and desktop shortcut

## Uninstallation

To uninstall TPDS and related components:

1. Make the uninstaller script executable:
   ```
   wget https://github.com/adithyayuri/tpds_installer/blob/main/debian/uninstall.sh
   ```

2. Make the uninstaller script executable:
   ```
   chmod +x uninstall_tpds.sh
   ```

3. Run the uninstaller:
   ```
   ./uninstall_tpds.sh
   ```

3. Follow the prompts to remove components

The uninstaller will remove:
- TPDS virtual environment
- Launcher script and desktop shortcut
- UDEV rules for Microchip kits
- Optionally: Python 3.10 (if installed by the script)

## Usage

After installation, you can start TPDS by:

1. Clicking the TPDS desktop shortcut
2. Running the launcher script:
   ```
   ~./launch_tpds.sh
   ```

## Troubleshooting

### USB Device Detection Issues
If TPDS cannot detect your Microchip development kit:
1. Make sure you've restarted your system after installation
2. Verify that your user is part of the plugdev group:
   ```
   sudo usermod -a -G plugdev $USER
   ```
3. Log out and back in for group changes to take effect

### Package Installation Errors
If you encounter errors during TPDS package installation:
1. Make sure your system is up to date:
   ```
   sudo apt-get update && sudo apt-get upgrade
   ```
2. Try installing with verbose output to see detailed errors:
   ```
   source ~/tpds/bin/activate
   pip install -v tpds-application[ext]
   ```

## License

This installer is provided under the [MIT License](LICENSE).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
