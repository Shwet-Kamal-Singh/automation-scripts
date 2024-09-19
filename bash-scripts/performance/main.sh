#!/bin/bash

# main.sh
# This script provides a menu to run various performance-related scripts.

# Function to display the menu
show_menu() {
    echo "Performance Scripts Menu"
    echo "------------------------"
    echo "1) Clear Cache"
    echo "2) Analyze Resource Usage"
    echo "3) Exit"
}

# Function to run the selected script
run_script() {
    # Get the directory of the current script
    script_dir="$(dirname "$0")"
    
    case $1 in
        1)
            echo "Running cache-clearing.sh..."
            bash "$script_dir/cache-clearing.sh"
            ;;
        2)
            echo "Running resource-usage-analysis.sh..."
            bash "$script_dir/resource-usage-analysis.sh"
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please select a valid option [1-3]."
            ;;
    esac
}

# Main script execution
while true; do
    show_menu
    read -p "Please select an option [1-3]: " choice
    run_script "$choice"
done