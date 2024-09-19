#!/bin/bash

# Function to display the menu
show_menu() {
    echo "Compliance Auditing Main Menu"
    echo "============================="
    echo "1) Generate Audit Report"
    echo "2) Run Compliance Check"
    echo "3) Enforce Policies"
    echo "4) Exit"
}

# Function to run the selected script
run_script() {
    # Get the directory of the current script
    script_dir="$(dirname "$0")"
    
    case $1 in
        1)
            bash "$script_dir/audit-report-generation.sh"
            ;;
        2)
            bash "$script_dir/compliance-check.sh"
            ;;
        3)
            bash "$script_dir/policy-enforcement.sh"
            ;;
        4)
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
    read -p "Please enter your choice [1-4]: " choice
    run_script "$choice"
done