#!/bin/bash

# network-monitor.sh
# A script to monitor network interfaces and log their status

# Log file to record network status
LOG_FILE="/var/log/network_status.log"

# Function to get the status of network interfaces
get_network_status() {
    echo "Getting network status..."
    ip -br addr
}

# Function to log network status
log_network_status() {
    local status=$1
    echo "$(date): Network status" >> $LOG_FILE
    echo "$status" >> $LOG_FILE
    echo "----------------------------------------" >> $LOG_FILE
}

# Main function
main() {
    # Get the current network status
    network_status=$(get_network_status)

    # Log the network status
    log_network_status "$network_status"

    echo "Network status logged."
}

# Execute main function
main