#!/bin/bash

# Function to list available services
list_services() {
    echo "Available services:"
    systemctl list-units --type=service --all | awk '{print $1}' | grep ".service"
}

# Function to show the status of a selected service
show_service_status() {
    local service_name=$1
    echo "Status of $service_name:"
    systemctl status $service_name
}

# Main script
list_services

echo "Enter the name of the service you want to check (e.g., ssh.service):"
read service_name

if systemctl list-units --type=service --all | grep -q "^$service_name"; then
    show_service_status $service_name
else
    echo "Service $service_name not found."
fi