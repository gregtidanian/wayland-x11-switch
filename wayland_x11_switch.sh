#!/bin/bash

# Check current display server
CURRENT_SESSION_TYPE=$(echo $XDG_SESSION_TYPE)
echo "Current session type is: $CURRENT_SESSION_TYPE"

if [ "$CURRENT_SESSION_TYPE" = "wayland" ]; then
    read -p "Switch to Xorg (X11)? This will disable Wayland. (y/n): " SWITCH_CHOICE
    if [[ "$SWITCH_CHOICE" =~ ^[Yy]$ ]]; then
        echo "Switching to Xorg..."
        sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf
        echo "Switched to Xorg. Please reboot your system for the change to take effect."
    else
        echo "No changes made."
    fi
elif [ "$CURRENT_SESSION_TYPE" = "x11" ]; then
    read -p "Switch to Wayland? This will enable Wayland. (y/n): " SWITCH_CHOICE
    if [[ "$SWITCH_CHOICE" =~ ^[Yy]$ ]]; then
        echo "Switching to Wayland..."
        sudo sed -i 's/WaylandEnable=false/#WaylandEnable=false/g' /etc/gdm3/custom.conf
        echo "Switched to Wayland. Please reboot your system for the change to take effect."
    else
        echo "No changes made."
    fi
else
    echo "Unrecognized session type: $CURRENT_SESSION_TYPE. No changes made."
fi

# Optionally, offer to reboot the system
read -p "Would you like to reboot now? (y/n): " REBOOT_CHOICE
if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
    echo "Rebooting now..."
    sudo reboot
else
    echo "Remember to reboot your system later to apply any changes."
fi
