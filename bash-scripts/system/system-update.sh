#!/bin/bash

# Function to update package lists
update_package_lists() {
    echo "Updating package lists..."
    sudo apt-get update
}

# Function to upgrade installed packages
upgrade_packages() {
    echo "Upgrading installed packages..."
    sudo apt-get upgrade -y
}

# Function to clean up unnecessary packages
cleanup_packages() {
    echo "Cleaning up unnecessary packages..."
    sudo apt-get autoremove -y
    sudo apt-get clean
}

# Main script
echo "Starting system update..."

update_package_lists
upgrade_packages
cleanup_packages

echo "System update completed."