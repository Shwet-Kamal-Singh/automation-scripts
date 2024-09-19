#!/bin/bash

# Prompt for username
read -p "Enter the username to create: " username

# Check if the user already exists
if id "$username" &>/dev/null; then
    echo "User $username already exists"
    exit 1
fi

# Create the user
sudo useradd "$username"
if [ $? -eq 0 ]; then
    echo "User $username created successfully"
else
    echo "Failed to create user $username"
    exit 1
fi

# Prompt to set a password
read -p "Do you want to set a password for $username? (y/n): " set_password
if [ "$set_password" == "y" ]; then
    sudo passwd "$username"
    if [ $? -eq 0 ]; then
        echo "Password set successfully for $username"
    else
        echo "Failed to set password for $username"
    fi
fi