#!/bin/bash

# resource-usage-analysis.sh
# This script collects and reports on various system resource usage metrics.

echo "Starting resource usage analysis..."

# Get CPU usage
echo "Collecting CPU usage..."
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
echo "CPU Usage: $CPU_USAGE"

# Get memory usage
echo "Collecting memory usage..."
MEMORY_USAGE=$(free -m | awk 'NR==2{printf "Memory Usage: %.2f%%\n", $3*100/$2 }')
echo "$MEMORY_USAGE"

# Get disk usage
echo "Collecting disk usage..."
DISK_USAGE=$(df -h | awk '$NF=="/"{printf "Disk Usage: %s\n", $5}')
echo "$DISK_USAGE"

# Get network usage
echo "Collecting network usage..."
NETWORK_USAGE=$(ifstat -t 1 1 | awk 'NR==4{print "Network Usage: In: "$6" KB/s, Out: "$8" KB/s"}')
echo "$NETWORK_USAGE"

# Get top 5 memory-consuming processes
echo "Collecting top 5 memory-consuming processes..."
TOP_PROCESSES=$(ps aux --sort=-%mem | awk 'NR<=6{print $0}')
echo "Top 5 memory-consuming processes:"
echo "$TOP_PROCESSES"

echo "Resource usage analysis completed."

# Optionally, you can save the output to a file
OUTPUT_FILE="resource-usage-report.txt"
{
    echo "Resource Usage Report - $(date)"
    echo "---------------------------------"
    echo "CPU Usage: $CPU_USAGE"
    echo "$MEMORY_USAGE"
    echo "$DISK_USAGE"
    echo "$NETWORK_USAGE"
    echo "Top 5 memory-consuming processes:"
    echo "$TOP_PROCESSES"
} > "$OUTPUT_FILE"

echo "Report saved to $OUTPUT_FILE"