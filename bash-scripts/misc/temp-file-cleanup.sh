#!/bin/bash

# Function to list temporary files and directories
list_temp_files() {
  echo "Listing temporary files and directories..."
  temp_files=("/tmp/*" "/var/tmp/*" "$HOME/.cache/*")
  for path in "${temp_files[@]}"; do
    echo "Files in $path:"
    ls -lh $path
    echo ""
  done
}

# Function to ask for user confirmation
confirm_deletion() {
  read -p "Do you want to delete these temporary files and directories? (y/n): " choice
  case "$choice" in
    y|Y ) delete_temp_files ;;
    n|N ) echo "Deletion cancelled." ;;
    * ) echo "Invalid choice. Deletion cancelled." ;;
  esac
}

# Function to delete temporary files and directories
delete_temp_files() {
  echo "Deleting temporary files and directories..."
  for path in "${temp_files[@]}"; do
    sudo rm -rf $path
  done
  echo "Temporary files and directories have been deleted."
}

# Main script logic
list_temp_files
confirm_deletion

exit 0