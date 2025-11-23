#!/bin/bash
#
# Raspberry Pi Timechain Calendar Kiosk - Installation Script
# 
# This script automates the installation and configuration of the
# Timechain Calendar kiosk on Raspberry Pi OS Bookworm
#
# Usage: 
#   wget https://raw.githubusercontent.com/YOUR_USERNAME/raspberry-pi-timechain-kiosk/main/scripts/install.sh
#   chmod +x install.sh
#   ./install.sh

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
CALENDAR_URL="https://timechaincalendar.com"

echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}Timechain Calendar Kiosk Installer${NC}"
echo -e "${GREEN}=====================================${NC}\n"

# Check if running on Raspberry Pi
if ! grep -q "Raspberry Pi" /proc/cpuinfo; then
    echo -e "${RED}Error: This script must be run on a Raspberry Pi${NC}"
    exit 1
fi

# Check if running Bookworm
if ! grep -q "bookworm" /etc/os-release; then
    echo -e "${YELLOW}Warning: This script is designed for Raspberry Pi OS Bookworm${NC}"
    echo -e "${YELLOW}You are running a different version. Continue anyway? (y/n)${NC}"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo -e "${GREEN}[1/7] Updating system packages...${NC}"
sudo apt update
sudo apt upgrade -y

echo -e "\n${GREEN}[2/7] Installing required software...${NC}"
sudo apt install -y chromium-browser unclutter xserver-xorg-input-evdev

echo -e "\n${GREEN}[3/7] Configuring display driver...${NC}"

# Backup original config.txt
if [ ! -f /boot/firmware/config.txt.backup ]; then
    sudo cp /boot/firmware/config.txt /boot/firmware/config.txt.backup
    echo "Backed up original config.txt"
fi

# Add piscreen overlay if not already present
if ! grep -q "dtoverlay=piscreen" /boot/firmware/config.txt; then
    echo "Adding piscreen overlay to config.txt..."
    
    # Check if [all] section exists
    if grep -q "^\[all\]" /boot/firmware/config.txt; then
        # Add after [all] section
        sudo sed -i '/^\[all\]/a dtparam=spi=on\ndtoverlay=piscreen,drm,speed=18000000' /boot/firmware/config.txt
    else
        # Add [all] section
        echo -e "\n[all]\ndtparam=spi=on\ndtoverlay=piscreen,drm,speed=18000000" | sudo tee -a /boot/firmware/config.txt > /dev/null
    fi
    echo "Display driver configured"
else
    echo "Display driver already configured"
fi

echo -e "\n${GREEN}[4/7] Configuring touchscreen...${NC}"

# Create X11 config directory if it doesn't exist
sudo mkdir -p /etc/X11/xorg.conf.d

# Create touchscreen config
cat << 'EOF' | sudo tee /etc/X11/xorg.conf.d/10-touchscreen.conf > /dev/null
Section "InputClass"
    Identifier "ADS7846 Touchscreen"
    MatchProduct "ADS7846"
    MatchDevicePath "/dev/input/event0"
    Driver "evdev"
EndSection
EOF

echo "Touchscreen configuration created"

echo -e "\n${GREEN}[5/7] Configuring auto-login...${NC}"

# Configure lightdm for autologin
CURRENT_USER=$(whoami)
sudo mkdir -p /etc/lightdm/lightdm.conf.d

cat << EOF | sudo tee /etc/lightdm/lightdm.conf.d/10-autologin.conf > /dev/null
[Seat:*]
autologin-user=$CURRENT_USER
user-session=LXDE
EOF

echo "Auto-login configured for user: $CURRENT_USER"

echo -e "\n${GREEN}[6/7] Configuring kiosk mode...${NC}"

# Create autostart directory
mkdir -p ~/.config/lxsession/LXDE

# Create autostart file
cat << 'EOF' > ~/.config/lxsession/LXDE/autostart
@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
@xscreensaver -no-splash
@xset s off
@xset -dpms
@xset s noblank
@unclutter -idle 0
@chromium-browser --kiosk --noerrdialogs --disable-infobars --no-first-run --disable-pinch --overscroll-history-navigation=0 --app=https://timechaincalendar.com
EOF

echo "Kiosk mode configured with URL: $CALENDAR_URL"

echo -e "\n${GREEN}[7/7] Finalizing installation...${NC}"

# Enable time synchronization
sudo systemctl enable systemd-timesyncd
sudo systemctl start systemd-timesyncd

echo -e "\n${GREEN}=====================================${NC}"
echo -e "${GREEN}Installation Complete!${NC}"
echo -e "${GREEN}=====================================${NC}\n"

echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Reboot your Raspberry Pi: ${GREEN}sudo reboot${NC}"
echo -e "2. After reboot, the kiosk should start automatically"
echo -e "3. If the display rotation is wrong, edit /boot/firmware/config.txt"
echo -e "   and add ',rotate=90' to the dtoverlay=piscreen line\n"

echo -e "${YELLOW}To customize the displayed URL:${NC}"
echo -e "Edit ~/.config/lxsession/LXDE/autostart and change the URL\n"

echo -e "Would you like to reboot now? (y/n)"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Rebooting in 5 seconds... (Ctrl+C to cancel)"
    sleep 5
    sudo reboot
else
    echo -e "\n${YELLOW}Remember to reboot before the kiosk will work!${NC}"
fi
