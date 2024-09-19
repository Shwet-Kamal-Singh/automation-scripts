#!/bin/bash

# Function to list all users
list_users() {
    echo "Available users:"
    cut -d: -f1 /etc/passwd
}

# List users
list_users
echo

# Prompt for username
read -p "Enter the username to monitor activity: " username

# Check if the user exists
if id "$username" &>/dev/null; then
    echo "Monitoring activity for user: $username"
    echo
    # Display user activity
    last "$username"
else
    echo "User $username does not exist"
fi