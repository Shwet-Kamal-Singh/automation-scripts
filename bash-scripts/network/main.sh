#!/bin/bash

# main.sh
# A script to provide a menu for network-related scripts

# Function to show the menu
show_menu() {
    echo "Select an option:"
    echo "1) Firewall Configuration"
    echo "2) IP Monitor"
    echo "3) Network Configuration Backup"
    echo "4) Network Monitor"
    echo "5) UFW Rule Management"
    echo "6) Exit"
}

# Function to run the selected script
run_script() {
    # Get the directory of the current script
    script_dir="$(dirname "$0")"
    
    case $1 in
        1)
            bash "$script_dir/firewall-config.sh"
            ;;
        2)
            bash "$script_dir/ip-monitor.sh"
            ;;
        3)
            bash "$script_dir/network-config-backup.sh"
            ;;
        4)
            bash "$script_dir/network-monitor.sh"
            ;;
        5)
            bash "$script_dir/ufw-rule-management.sh"
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
while true; do
    show_menu
    read -p "Enter your choice: " choice
    run_script "$choice"
done