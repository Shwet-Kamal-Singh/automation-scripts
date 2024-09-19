#!/bin/bash

# ip-monitor.sh
# A script to monitor changes to the public IP address and log any changes

# File to store the current IP address
IP_FILE="/var/log/current_ip.txt"
# Log file to record IP changes
LOG_FILE="/var/log/ip_changes.log"

# Function to get the current public IP address
get_current_ip() {
    curl -s http://ipinfo.io/ip
}

# Function to log IP changes
log_ip_change() {
    local new_ip=$1
    echo "$(date): IP changed to $new_ip" >> $LOG_FILE
}

# Main function
main() {
    # Get the current public IP address
    current_ip=$(get_current_ip)

    # Check if the IP file exists
    if [ -f $IP_FILE ]; then
        # Read the stored IP address
        stored_ip=$(cat $IP_FILE)

        # Compare the current IP with the stored IP
        if [ "$current_ip" != "$stored_ip" ]; then
            # Log the IP change
            log_ip_change $current_ip
            # Update the stored IP address
            echo $current_ip > $IP_FILE
        fi
    else
        # If the IP file doesn't exist, create it and store the current IP
        echo $current_ip > $IP_FILE
        # Log the initial IP address
        log_ip_change $current_ip
    fi
}

# Execute main function
main