#!/bin/bash

# main.sh
# This script serves as an entry point to run various security scripts.

# Function to display the menu
show_menu() {
    echo "Security Scripts Menu:"
    echo "1) Security Patch Management"
    echo "2) SSH Brute Force Monitor"
    echo "3) Vulnerability Scan"
    echo "4) Exit"
}

# Function to run the selected script
run_script() {
    # Get the directory of the current script
    script_dir="$(dirname "$0")"
    
    case $1 in
        1)
            bash "$script_dir/security-patch-management.sh"
            ;;
        2)
            bash "$script_dir/ssh-brute-force-monitor.sh"
            ;;
        3)
            bash "$script_dir/vulnerability-scan.sh"
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            ;;
    esac
}

# Main script execution
while true; do
    show_menu
    read -p "Enter your choice: " choice
    run_script "$choice"
done