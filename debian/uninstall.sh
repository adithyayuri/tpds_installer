#!/bin/bash
# TPDS (Trustplatform Design Suite) Uninstaller for Debian Linux
# This script uninstalls TPDS and related components for the specified user

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Microchip TPDS Uninstaller for Debian-based Linux Systems ===${NC}"

# Get the current non-root user if no user is specified
if [ -z "$1" ]; then
    LOGGED_IN_USER=$(logname)
else
    LOGGED_IN_USER="$1"
fi

USER_HOME="/home/$LOGGED_IN_USER"
VENV_PATH="$USER_HOME/tpds"
LAUNCHER_PATH="$USER_HOME/launch_tpds.sh"
DESKTOP_PATH="$USER_HOME/.local/share/applications/tpds.desktop"

if [ ! -d "$USER_HOME" ]; then
    echo -e "${RED}Error: User '$LOGGED_IN_USER' does not exist or has no home directory.${NC}"
    exit 1
fi

echo -e "\n${YELLOW}TPDS Installation path:${NC} $VENV_PATH"

# Check if installation exists
if [ ! -d "$VENV_PATH" ]; then
    echo -e "${YELLOW}TPDS installation not found at $VENV_PATH${NC}"
    echo "Checking for other components..."
else
    echo -e "${YELLOW}Found TPDS installation at $VENV_PATH${NC}"
fi

# Ask for confirmation
echo -e "\n${RED}Warning: This will remove TPDS and related components${NC}"
read -p "Continue with uninstallation? (y/n): " confirm
if [[ $confirm != [yY] ]]; then
    echo "Uninstallation cancelled."
    exit 0
fi

# Remove desktop shortcut
if [ -f "$DESKTOP_PATH" ]; then
    echo -e "\n${YELLOW}Removing desktop shortcut...${NC}"
    rm -f "$DESKTOP_PATH"
    echo "Desktop shortcut removed."
fi

# Remove launcher script
if [ -f "$LAUNCHER_PATH" ]; then
    echo -e "\n${YELLOW}Removing launcher script...${NC}"
    rm -f "$LAUNCHER_PATH"
    echo "Launcher script removed."
fi

# Remove virtual environment
if [ -d "$VENV_PATH" ]; then
    echo -e "\n${YELLOW}Removing TPDS virtual environment...${NC}"
    rm -rf "$VENV_PATH"
    echo "TPDS virtual environment removed."
fi

echo -e "\n${GREEN}=== Uninstallation Complete ===${NC}"
echo "TPDS and related components have been removed from user $LOGGED_IN_USER's system."
