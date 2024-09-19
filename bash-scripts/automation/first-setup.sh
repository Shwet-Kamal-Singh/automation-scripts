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

# Function to install essential packages
install_packages() {
    echo "Installing essential packages..."
    sudo apt-get install -y git curl vim
    if [ $? -ne 0 ]; then
        echo "Package installation failed."
        exit 1
    fi
    echo "Essential packages installed successfully."
}

# Function to set up a basic directory structure
setup_directories() {
    echo "Setting up directory structure..."
    mkdir -p ~/projects ~/scripts ~/logs
    if [ $? -ne 0 ]; then
        echo "Directory setup failed."
        exit 1
    fi
    echo "Directory structure set up successfully."
}

# Function to display a completion message
completion_message() {
    echo "First setup completed successfully!"
}

# Main script execution
update_system
install_packages
setup_directories
completion_message