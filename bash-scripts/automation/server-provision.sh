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
    sudo apt-get install -y git curl vim ufw
    if [ $? -ne 0 ]; then
        echo "Package installation failed."
        exit 1
    fi
    echo "Essential packages installed successfully."
}

# Function to create a new user with sudo privileges
create_user() {
    read -p "Enter the username for the new user: " username
    sudo adduser "$username"
    sudo usermod -aG sudo "$username"
    if [ $? -ne 0 ]; then
        echo "User creation failed."
        exit 1
    fi
    echo "User $username created and added to sudo group successfully."
}

# Function to configure SSH
configure_ssh() {
    echo "Configuring SSH..."
    sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    if [ $? -ne 0 ]; then
        echo "SSH configuration failed."
        exit 1
    fi
    echo "SSH configured successfully."
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

# Main script execution
update_system
install_packages
create_user
configure_ssh
configure_firewall

echo "Server provisioning completed successfully!"