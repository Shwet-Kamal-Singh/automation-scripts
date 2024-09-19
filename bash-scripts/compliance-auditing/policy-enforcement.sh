#!/bin/bash

# Function to enforce a policy and log the action
enforce_policy() {
    echo "Enforcing policy: $1"
    $2
    echo "Policy enforced: $1" >> $log_file
}

# Get current date and time for the log filename
current_date_time=$(date +"%Y-%m-%d_%H-%M-%S")
log_file="policy_enforcement_$current_date_time.log"

# Create a new log file
echo "Policy Enforcement Log - $current_date_time" > $log_file
echo "==========================================" >> $log_file

# Enforce password policies
enforce_policy "Set maximum password age to 90 days" "sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs"
enforce_policy "Set minimum password age to 7 days" "sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   7/' /etc/login.defs"
enforce_policy "Set password warning age to 7 days" "sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE   7/' /etc/login.defs"

# Enforce SSH configuration
enforce_policy "Disable root login via SSH" "sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config"
enforce_policy "Disable password authentication via SSH" "sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config"
enforce_policy "Restart SSH service" "systemctl restart sshd"

# Enforce firewall rules
enforce_policy "Enable UFW firewall" "ufw enable"
enforce_policy "Allow SSH connections" "ufw allow ssh"
enforce_policy "Allow HTTP connections" "ufw allow http"
enforce_policy "Allow HTTPS connections" "ufw allow https"
enforce_policy "Deny all other incoming connections" "ufw default deny incoming"
enforce_policy "Allow all outgoing connections" "ufw default allow outgoing"

# Enforce system updates
enforce_policy "Update package list" "apt-get update"
enforce_policy "Upgrade all packages" "apt-get upgrade -y"

# Print completion message
echo "Policy enforcement completed. Log file: $log_file"