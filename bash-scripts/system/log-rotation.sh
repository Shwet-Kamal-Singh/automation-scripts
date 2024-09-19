#!/bin/bash

# Configuration
LOG_FILE="/var/log/myapp.log"
ARCHIVE_DIR="/var/log/archive"
MAX_LOG_SIZE=10485760  # 10 MB

# Function to rotate logs
rotate_log() {
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    ARCHIVE_FILE="$ARCHIVE_DIR/myapp.log.$TIMESTAMP"

    # Create archive directory if it doesn't exist
    mkdir -p $ARCHIVE_DIR

    # Move the log file to the archive directory
    mv $LOG_FILE $ARCHIVE_FILE

    # Create a new empty log file
    touch $LOG_FILE

    # Set appropriate permissions
    chmod 644 $LOG_FILE

    echo "Log rotated: $ARCHIVE_FILE"
}

# Check if log file exists and its size
if [ -f $LOG_FILE ]; then
    LOG_SIZE=$(stat -c%s "$LOG_FILE")
    if [ $LOG_SIZE -ge $MAX_LOG_SIZE ]; then
        rotate_log
    else
        echo "Log file size is under the limit. No rotation needed."
    fi
else
    echo "Log file does not exist: $LOG_FILE"
fi