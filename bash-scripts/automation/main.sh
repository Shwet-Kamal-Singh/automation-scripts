#!/bin/bash

# Function to display the menu
show_menu() {
    echo "Select an option:"
    echo "1) Cron Automation"
    echo "2) Deploy Automation"
    echo "3) First Setup"
    echo "4) Server Hardening"
    echo "5) Server Provisioning"
    echo "6) Exit"
}

# Function to run the selected script
run_script() {
    # Get the directory of the current script
    script_dir="$(dirname "$0")"
    
    case $1 in
        1)
            bash "$script_dir/cron-automation.sh"
            ;;
        2)
            bash "$script_dir/deploy-automation.sh"
            ;;
        3)
            bash "$script_dir/first-setup.sh"
            ;;
        4)
            bash "$script_dir/server-hardening.sh"
            ;;
        5)
            bash "$script_dir/server-provision.sh"
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