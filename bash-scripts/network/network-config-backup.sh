#!/bin/bash

# network-config-backup.sh
# A script to back up network configuration files

# Directory to store backups
BACKUP_DIR="/var/backups/network-config"
# List of network configuration files to back up
CONFIG_FILES=(
    "/etc/network/interfaces"
    "/etc/netplan/*.yaml"
    "/etc/hosts"
    "/etc/hostname"
    "/etc/resolv.conf"
)

# Function to create backup directory if it doesn't exist
create_backup_dir() {
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Creating backup directory..."
        mkdir -p "$BACKUP_DIR"
    fi
}

# Function to back up configuration files
backup_configs() {
    echo "Backing up network configuration files..."
    for file in "${CONFIG_FILES[@]}"; do
        if [ -f $file ] || [ -d $file ]; then
            cp -r $file "$BACKUP_DIR"
            echo "Backed up $file to $BACKUP_DIR"
        else
            echo "File $file does not exist, skipping..."
        fi
    done
}

# Function to create a compressed archive of the backup
compress_backup() {
    echo "Creating compressed archive of the backup..."
    tar -czf "$BACKUP_DIR/network-config-backup-$(date +%Y%m%d%H%M%S).tar.gz" -C "$BACKUP_DIR" .
    echo "Compressed archive created."
}

# Main function
main() {
    create_backup_dir
    backup_configs
    compress_backup
    echo "Network configuration backup completed."
}

# Execute main function
main