#!/bin/bash

# security-patch-management.sh
# This script checks for and applies security updates on an Ubuntu-based system.

# Function to check for updates
check_updates() {
    echo "Checking for updates..."
    sudo apt-get update -y
}

# Function to list available security updates
list_security_updates() {
    echo "Listing available security updates..."
    sudo apt-get upgrade -s | grep -i security
}

# Function to apply security updates
apply_security_updates() {
    echo "Applying security updates..."
    sudo apt-get upgrade -y
}

# Main script execution
echo "Starting security patch management script..."

check_updates
list_security_updates
apply_security_updates

echo "Security updates applied successfully."

# End of script