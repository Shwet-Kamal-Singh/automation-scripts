#!/bin/bash

# Define the output file for the report
OUTPUT_FILE="/var/log/disk_usage_report.txt"

# Get the current date and time
current_date=$(date +"%Y-%m-%d %H:%M:%S")

# Generate the disk usage report
disk_usage=$(df -h)

# Write the report to the output file
{
  echo "Disk Usage Report - $current_date"
  echo "---------------------------------"
  echo "$disk_usage"
} > $OUTPUT_FILE

# Display a message indicating where the report has been saved
echo "Disk usage report saved to $OUTPUT_FILE"

# Exit the script
exit 0