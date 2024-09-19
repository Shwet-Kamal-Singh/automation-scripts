#!/bin/bash

# Get current date and time for the report filename
current_date_time=$(date +"%Y-%m-%d_%H-%M-%S")
report_file="compliance_report_$current_date_time.txt"

# Function to append a section to the report
append_section() {
    echo -e "\n\n$1\n" >> $report_file
    echo "====================" >> $report_file
    $2 >> $report_file
}

# Create a new report file
echo "System Compliance Report - $current_date_time" > $report_file
echo "=============================================" >> $report_file

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

# Check for password policies
append_section "Password Policies" "cat /etc/login.defs | grep -E 'PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE'"

# Check for SSH configuration
append_section "SSH Configuration" "cat /etc/ssh/sshd_config | grep -E 'PermitRootLogin|PasswordAuthentication'"

# Check for firewall status
append_section "Firewall Status" "ufw status"

# Check for system updates
append_section "System Updates" "apt list --upgradable"

# Check for file integrity (example using AIDE if installed)
if command -v aide > /dev/null; then
    append_section "File Integrity Check" "aide --check"
else
    echo -e "\n\nFile Integrity Check\n" >> $report_file
    echo "====================" >> $report_file
    echo "AIDE is not installed." >> $report_file
fi

# Print completion message
echo "Compliance report generated: $report_file"