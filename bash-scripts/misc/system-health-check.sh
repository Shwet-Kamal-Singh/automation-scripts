#!/bin/bash

# Function to check CPU usage
check_cpu_usage() {
  echo "Checking CPU usage..."
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
  echo "CPU Usage: $cpu_usage"
}

# Function to check memory usage
check_memory_usage() {
  echo "Checking memory usage..."
  memory_usage=$(free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
  echo "$memory_usage"
}

# Function to check disk usage
check_disk_usage() {
  echo "Checking disk usage..."
  disk_usage=$(df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}')
  echo "$disk_usage"
}

# Function to check system uptime
check_system_uptime() {
  echo "Checking system uptime..."
  uptime=$(uptime -p)
  echo "System Uptime: $uptime"
}

# Main script logic
echo "Starting system health check..."
check_cpu_usage
check_memory_usage
check_disk_usage
check_system_uptime
echo "System health check complete."

exit 0