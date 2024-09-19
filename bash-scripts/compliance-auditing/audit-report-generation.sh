#!/bin/bash

# Get current date and time for the report filename
current_date_time=$(date +"%Y-%m-%d_%H-%M-%S")
report_file="audit_report_$current_date_time.txt"

# Function to append a section to the report
append_section() {
    echo -e "\n\n$1\n" >> $report_file
    echo "====================" >> $report_file
    $2 >> $report_file
}

# Create a new report file
echo "System Audit Report - $current_date_time" > $report_file
echo "========================================" >> $report_file

# User activity
append_section "User Activity" "last"

# System information
append_section "System Information" "uname -a"

# Disk usage
append_section "Disk Usage" "df -h"

# Memory usage
append_section "Memory Usage" "free -h"

# CPU information
append_section "CPU Information" "lscpu"

# Running processes
append_section "Running Processes" "ps aux"

# Installed applications and packages
append_section "Installed Applications and Packages" "dpkg -l"

# User login history
append_section "User Login History" "lastlog"

# Additional system logs (e.g., auth.log, syslog)
append_section "Authentication Log" "cat /var/log/auth.log"
append_section "System Log" "cat /var/log/syslog"

# Print completion message
echo "Audit report generated: $report_file"