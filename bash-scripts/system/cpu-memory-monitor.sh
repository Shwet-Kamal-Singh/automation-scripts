#!/bin/bash

# Function to get CPU usage
get_cpu_usage() {
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | \
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
    awk '{print 100 - $1"%"}'
}

# Function to get memory usage
get_memory_usage() {
    echo "Memory Usage:"
    free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
}

# Function to display the usage
display_usage() {
    echo "===================="
    get_cpu_usage
    get_memory_usage
    echo "===================="
}

# Main loop to monitor every 5 seconds
while true; do
    display_usage
    sleep 5
done