#!/bin/bash

# Function to display the menu
show_menu() {
  echo "Select an option:"
  echo "1) API Interaction"
  echo "2) Disk Usage Report"
  echo "3) Environment Setup/Teardown"
  echo "4) Log Cleanup"
  echo "5) System Health Check"
  echo "6) Temp File Cleanup"
  echo "7) SSH Key Management"
  echo "8) Exit"
}

# Function to run the selected script
run_script() {
  # Get the directory of the current script
  script_dir="$(dirname "$0")"
  
  case $1 in
    1)
      bash "$script_dir/api-interaction.sh"
      ;;
    2)
      bash "$script_dir/disk-usage-report.sh"
      ;;
    3)
      bash "$script_dir/environment-setup-teardown.sh"
      ;;
    4)
      bash "$script_dir/log-cleanup.sh"
      ;;
    5)
      bash "$script_dir/system-health-check.sh"
      ;;
    6)
      bash "$script_dir/temp-file-cleanup.sh"
      ;;
    7)
      bash "$script_dir/ssh-key-management.sh"
      ;;
    8)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid option. Please try again."
      ;;
  esac
}

# Main script logic
while true; do
  show_menu
  read -p "Enter your choice (1-8): " choice
  run_script "$choice"
done