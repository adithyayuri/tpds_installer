#!/bin/bash
# TPDS (Trustplatform Design Suite) Installer for Debian Linux
# This script installs TPDS from Microchip in a Python virtual environment
# using Python 3.10 (only installs Python if not already available)

set -e

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Microchip TPDS Installer for Debian-based Linux Systems ===${NC}"
echo "This script will install TPDS in a Python 3.10 virtual environment"

# Get the current non-root user
LOGGED_IN_USER=$(logname)
USER_HOME="/home/$LOGGED_IN_USER"

# Setup install path
VENV_PATH="$USER_HOME/tpds"
echo -e "\n${YELLOW}TPDS Installation path:${NC} $VENV_PATH"

# Ensure ownership of installation directory
mkdir -p "$VENV_PATH"
chown -R "$LOGGED_IN_USER:$LOGGED_IN_USER" "$VENV_PATH"

# Check if Python 3.10 is already installed
echo -e "\n${YELLOW}Checking for Python 3.10...${NC}"
if command -v python3.10 &> /dev/null; then
    echo -e "${GREEN}Python 3.10 is already installed${NC}"
    PYTHON_CMD=$(which python3.10)
else
    echo "Python 3.10 is not installed, installing..."
    sudo apt-get update
    sudo apt-get install -y python3.10 python3.10-venv python3.10-dev
    PYTHON_CMD=$(which python3.10)
fi

# Create python virtual env
echo -e "\n${YELLOW}Creating Python virtual environment...${NC}"
sudo -u "$LOGGED_IN_USER" "$PYTHON_CMD" -m venv "$VENV_PATH"

# Activate virtual env and install packages
echo -e "\n${YELLOW}Activating virtual environment and installing TPDS...${NC}"
sudo -u "$LOGGED_IN_USER" bash -c "source $VENV_PATH/bin/activate && \ 
    python -m pip install --upgrade pip setuptools wheel && \ 
    python -m pip install tpds-application[ext] tpds-extension-ta010-support tpds-extension-ecc204-support"

# Create TPDS Launch script
LAUNCHER_PATH="$USER_HOME/launch_tpds.sh"
echo -e "\n${YELLOW}Creating TPDS launcher script...${NC}"
cat << EOF | sudo -u "$LOGGED_IN_USER" tee "$LAUNCHER_PATH" > /dev/null
#!/bin/bash
source "$VENV_PATH/bin/activate"
export QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox"
python "$VENV_PATH/bin/tpds"
EOF
chmod +x "$LAUNCHER_PATH"

# Create desktop shortcut
DESKTOP_PATH="$USER_HOME/.local/share/applications/tpds.desktop"
echo -e "\n${YELLOW}Creating desktop shortcut...${NC}"
sudo -u "$LOGGED_IN_USER" mkdir -p "$USER_HOME/.local/share/applications"
cat << EOF | sudo -u "$LOGGED_IN_USER" tee "$DESKTOP_PATH" > /dev/null
[Desktop Entry]
Name=Microchip TPDS
Comment=Trustplatform Design Suite
Exec=$LAUNCHER_PATH
Icon=$VENV_PATH/lib/python3*/site-packages/tpds_application/resources/logo/tpds.png
Terminal=false
Type=Application
Categories=Development;
EOF

# Ensure correct ownership
chown -R "$LOGGED_IN_USER:$LOGGED_IN_USER" "$USER_HOME/.local/share/applications" "$LAUNCHER_PATH"

# Final message
echo -e "\n${GREEN}=== Installation Complete ===${NC}"
echo -e "TPDS installed at: ${YELLOW}$VENV_PATH${NC}"
echo -e "Launch script created: ${YELLOW}$LAUNCHER_PATH${NC}"
echo -e "Desktop shortcut created: ${YELLOW}$DESKTOP_PATH${NC}"
echo -e "\n${YELLOW}Note:${NC} A system restart is recommended for changes to take effect."
