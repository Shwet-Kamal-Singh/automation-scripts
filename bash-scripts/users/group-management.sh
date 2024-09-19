#!/bin/bash

# Function to list all groups
list_groups() {
    echo "Available groups:"
    cut -d: -f1 /etc/group
}

# Function to list all users
list_users() {
    echo "Available users:"
    cut -d: -f1 /etc/passwd
}

# List groups and users
list_groups
echo
list_users
echo

# Prompt for user and group
read -p "Enter the username to add to a group: " username
read -p "Enter the group to add the user to: " group

# Check if the user exists
if id "$username" &>/dev/null; then
    # Check if the group exists
    if getent group "$group" &>/dev/null; then
        # Add user to group
        sudo usermod -aG "$group" "$username"
        if [ $? -eq 0 ]; then
            echo "User $username added to group $group successfully"
        else
            echo "Failed to add user $username to group $group"
        fi
    else
        echo "Group $group does not exist"
    fi
else
    echo "User $username does not exist"
fi