#!/bin/bash

# Function to display the menu
show_menu() {
    echo "Select an option:"
    echo "1) CPU and Memory Monitor"
    echo "2) Disk Space Monitor"
    echo "3) Log Rotation"
    echo "4) Service Status Monitor"
    echo "5) System Update"
    echo "6) Exit"
}

# Function to handle user input
run_script() {
    # Get the directory of the current script
    script_dir="$(dirname "$0")"
    
    case $1 in
        1)
            bash "$script_dir/cpu-memory-monitor.sh"
            ;;
        2)
            bash "$script_dir/disk-space-monitor.sh"
            ;;
        3)
            bash "$script_dir/log-rotation.sh"
            ;;
        4)
            bash "$script_dir/service-status-monitor.sh"
            ;;
        5)
            bash "$script_dir/system-update.sh"
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice: " choice
    run_script "$choice"
done