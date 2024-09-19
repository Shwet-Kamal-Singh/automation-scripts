#!/bin/bash

# Function to display the menu and get user selection
select_log_to_clear() {
  echo "Select the log file to clear:"
  echo "1) System logs (/var/log/syslog)"
  echo "2) Authentication logs (/var/log/auth.log)"
  echo "3) Application logs (/var/log/app.log)"
  echo "4) Custom log file"

  read -p "Enter your choice (1-4): " choice

  case $choice in
    1)
      log_file="/var/log/syslog"
      ;;
    2)
      log_file="/var/log/auth.log"
      ;;
    3)
      log_file="/var/log/app.log"
      ;;
    4)
      read -p "Enter the full path of the custom log file: " log_file
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
  esac
}

# Function to clear the selected log file
clear_log_file() {
  if [ -f "$log_file" ]; then
    sudo truncate -s 0 "$log_file"
    echo "Log file $log_file has been cleared."
  else
    echo "Log file $log_file does not exist."
    exit 1
  fi
}

# Main script logic
select_log_to_clear
clear_log_file

exit 0