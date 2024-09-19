#!/bin/bash

# firewall-config.sh
# A script to configure the firewall using ufw on an Ubuntu-based system

# Function to check if the script is run as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit 1
    fi
}

# Function to enable UFW
enable_ufw() {
    echo "Enabling UFW..."
    ufw enable
}

# Function to set default policies
set_default_policies() {
    echo "Setting default policies..."
    ufw default deny incoming
    ufw default allow outgoing
}

# Function to allow specific ports
allow_ports() {
    echo "Allowing specific ports..."
    ufw allow 22/tcp    # SSH
    ufw allow 80/tcp    # HTTP
    ufw allow 443/tcp   # HTTPS
}

# Function to reload UFW
reload_ufw() {
    echo "Reloading UFW..."
    ufw reload
}

# Main function
main() {
    check_root
    enable_ufw
    set_default_policies
    allow_ports
    reload_ufw
    echo "Firewall configuration completed."
}

# Execute main function
main