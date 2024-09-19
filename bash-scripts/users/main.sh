#!/bin/bash

# Function to display the menu
show_menu() {
    echo "User Management Menu"
    echo "1) Bulk User Create"
    echo "2) Group Management"
    echo "3) Single User Create"
    echo "4) User Activity Monitor"
    echo "5) Exit"
}

# Function to run the selected script
run_script() {
    # Get the directory of the current script
    script_dir="$(dirname "$0")"
    
    case $1 in
        1)
            bash "$script_dir/bulk-user-create.sh"
            ;;
        2)
            bash "$script_dir/group-management.sh"
            ;;
        3)
            bash "$script_dir/single-user-create.sh"
            ;;
        4)
            bash "$script_dir/user-activity-monitor.sh"
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

# Main loop
while true; do
    show_menu
    read -p "Enter choice [1-5]: " choice
    run_script "$choice"
done