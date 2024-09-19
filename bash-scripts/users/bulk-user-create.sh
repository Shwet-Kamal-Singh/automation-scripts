#!/bin/bash

# Check if the input file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <usernames_file>"
    exit 1
fi

USERNAMES_FILE=$1

# Check if the file exists
if [ ! -f "$USERNAMES_FILE" ]; then
    echo "File not found: $USERNAMES_FILE"
    exit 1
fi

# Read the file and create users
while IFS= read -r username; do
    if id "$username" &>/dev/null; then
        echo "User $username already exists"
    else
        sudo useradd "$username"
        if [ $? -eq 0 ]; then
            echo "User $username created successfully"
        else
            echo "Failed to create user $username"
        fi
    fi
done < "$USERNAMES_FILE"