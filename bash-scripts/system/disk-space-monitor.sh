#!/bin/bash

# Function to get disk space usage
get_disk_usage() {
    echo "Disk Space Usage:"
    df -h | grep -E '^/dev/'
}

# Function to display the usage
display_usage() {
    echo "===================="
    get_disk_usage
    echo "===================="
}

# Main loop to monitor every 5 seconds
while true; do
    display_usage
    sleep 5
done