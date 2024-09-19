#!/bin/bash

# Function to update the system
update_system() {
    echo "Updating the system..."
    sudo apt-get update && sudo apt-get upgrade -y
    if [ $? -ne 0 ]; then
        echo "System update failed."
        exit 1
    fi
    echo "System updated successfully."
}

# Function to configure the firewall
configure_firewall() {
    echo "Configuring the firewall..."
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw enable
    if [ $? -ne 0 ]; then
        echo "Firewall configuration failed."
        exit 1
    fi
    echo "Firewall configured successfully."
}

# Function to disable root login via SSH
disable_root_ssh() {
    echo "Disabling root login via SSH..."
    sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    if [ $? -ne 0 ]; then
        echo "Disabling root login via SSH failed."
        exit 1
    fi
    echo "Root login via SSH disabled successfully."
}

# Function to set up automatic security updates
setup_auto_updates() {
    echo "Setting up automatic security updates..."
    sudo apt-get install -y unattended-upgrades
    sudo dpkg-reconfigure -plow unattended-upgrades
    if [ $? -ne 0 ]; then
        echo "Setting up automatic security updates failed."
        exit 1
    fi
    echo "Automatic security updates set up successfully."
}

# Main script execution
update_system
configure_firewall
disable_root_ssh
setup_auto_updates

echo "Server hardening completed successfully!"