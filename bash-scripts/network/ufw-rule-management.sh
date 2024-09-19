#!/bin/bash

# ufw-rule-management.sh
# A script to manage UFW rules

# Function to check if the script is run as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit 1
    fi
}

# Function to show UFW status
show_status() {
    echo "UFW Status:"
    ufw status verbose
}

# Function to enable UFW
enable_ufw() {
    echo "Enabling UFW..."
    ufw enable
}

# Function to disable UFW
disable_ufw() {
    echo "Disabling UFW..."
    ufw disable
}

# Function to open a port
open_port() {
    read -p "Enter the port number to open: " port
    ufw allow "$port"
    echo "Port $port opened."
}

# Function to remove a port rule
remove_port() {
    read -p "Enter the port number to remove: " port
    ufw delete allow "$port"
    echo "Port $port rule removed."
}

# Function to show the menu
show_menu() {
    echo "Select an option:"
    echo "1) Show UFW Status"
    echo "2) Enable UFW"
    echo "3) Disable UFW"
    echo "4) Open a Port"
    echo "5) Remove a Port Rule"
    echo "6) Exit"
}

# Function to handle user input
handle_choice() {
    case $1 in
        1)
            show_status
            ;;
        2)
            enable_ufw
            ;;
        3)
            disable_ufw
            ;;
        4)
            open_port
            ;;
        5)
            remove_port
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please select a valid option."
            ;;
    esac
}

# Main script execution
check_root
while true; do
    show_menu
    read -p "Enter your choice: " choice
    handle_choice "$choice"
done