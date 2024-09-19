#!/bin/bash

# ssh-brute-force-monitor.sh
# This script monitors SSH login attempts and blocks IP addresses with multiple failed login attempts using fail2ban.

# Function to install fail2ban if not already installed
install_fail2ban() {
    if ! command -v fail2ban-server &> /dev/null; then
        echo "fail2ban is not installed. Installing fail2ban..."
        sudo apt-get update -y
        sudo apt-get install fail2ban -y
    else
        echo "fail2ban is already installed."
    fi
}

# Function to configure fail2ban for SSH
configure_fail2ban() {
    echo "Configuring fail2ban for SSH..."
    sudo bash -c 'cat > /etc/fail2ban/jail.local <<EOF
[sshd]
enabled = true
port    = ssh
logpath = /var/log/auth.log
maxretry = 5
bantime = 3600
EOF'
    sudo systemctl restart fail2ban
}

# Function to monitor SSH login attempts
monitor_ssh_attempts() {
    echo "Monitoring SSH login attempts..."
    sudo tail -f /var/log/auth.log | grep --line-buffered "sshd"
}

# Main script execution
echo "Starting SSH brute force monitor script..."

install_fail2ban
configure_fail2ban
monitor_ssh_attempts

echo "SSH brute force monitor script is running."

# End of script