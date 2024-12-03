#!/bin/bash

# Function to check if a domain resolves and display nameservers if it does not
check_domain_resolution() {
    if ! host "$1" > /dev/null; then
        echo "⚠️  Domain Resolution Error: $1 is not properly configured."
        echo "ℹ️  Please verify that the domain's DNS records point to this server's IP address."
        echo "📝 Current nameservers for $1:"
        dig +short NS $1
        exit 1
    else
        echo "✅ Domain verification successful: $1 is properly configured."
    fi
}

# Function to check if Certbot is installed
check_certbot_installed() {
    if ! command -v certbot > /dev/null; then
        echo "🔄 Certbot not detected. Initiating installation process..."
        if [[ "$PM" == "apt" ]]; then
            $ADD_REPO_CMD ppa:certbot/certbot
            $UPDATE_CMD
            $PKG_INSTALL certbot python3-certbot-nginx
        elif [[ "$PM" == "dnf" || "$PM" == "yum" ]]; then
            $PKG_INSTALL certbot python3-certbot-nginx
        else
            echo "❌ Error: Unsupported package manager detected. Please install Certbot manually and restart this script."
            exit 1
        fi
    else
        echo "✅ Certbot is already installed on your system."
        echo "📌 Current version:"
        certbot --version
    fi
}

# Detect Linux distribution and set package manager and update commands
if [ -f /etc/debian_version ]; then
    PM="apt"
    PKG_INSTALL="apt install -y"
    UPDATE_CMD="apt update && apt upgrade -y"
    ADD_REPO_CMD="add-apt-repository -y"
elif [ -f /etc/redhat-release ]; then
    PM="dnf"
    if command -v dnf > /dev/null; then
        PKG_INSTALL="dnf install -y"
    else
        PM="yum"
        PKG_INSTALL="yum install -y"
    fi
    UPDATE_CMD="$PM update -y"
    ADD_REPO_CMD="dnf config-manager --add-repo"
else
    echo "❌ Error: Your Linux distribution is not supported by this script."
    exit 1
fi

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "❌ Error: This script requires root privileges. Please run with sudo or as root user." 1>&2
    exit 1
fi

# Check if Nginx is installed and running
if ! command -v nginx > /dev/null; then
    echo "🔄 Installing Nginx web server..."
    $PKG_INSTALL nginx
    systemctl start nginx
    systemctl enable nginx
else
    echo "✅ Nginx is already installed on your system."
    echo "📌 Current version:"
    nginx -v
fi

# Prompt for domain and email
echo "📝 SSL Certificate Configuration"
read -p "🌐 Enter your domain name (e.g., example.com): " domain
read -p "📧 Enter your email address for SSL notifications: " email

# Check and resolve domain before proceeding
check_domain_resolution "$domain"

# Check if Certbot is installed
check_certbot_installed

# Ask if user wants to back up Nginx configurations
echo "💾 Backup Configuration"
echo "Would you like to create a backup of your current Nginx configuration? (yes/no)"
read backup_choice

if [[ "$backup_choice" == "yes" ]]; then
    echo "📦 Creating backup of Nginx configuration..."
    cp -r /etc/nginx /etc/nginx-backup
    echo "✅ Backup successfully created at /etc/nginx-backup"
elif [[ "$backup_choice" == "no" ]]; then
    echo "⚠️  Proceeding without backup. Any existing configuration will be modified directly."
else
    echo "❌ Error: Invalid response. Please run the script again and choose 'yes' or 'no'."
    exit 1
fi

# Update system packages
echo "🔄 Updating system packages..."
$UPDATE_CMD

# Install dnsutils if not installed
if [[ "$PM" == "apt" ]]; then
    echo "📦 Installing required DNS utilities..."
    $PKG_INSTALL software-properties-common dnsutils
elif [[ "$PM" == "dnf" || "$PM" == "yum" ]]; then
    echo "📦 Installing required DNS utilities..."
    $PKG_INSTALL bind-utils
fi

# Generate the SSL Certificate
echo "🔒 Generating SSL certificate for $domain..."
certbot --nginx -d "$domain" --redirect --agree-tos --email "$email"

# Confirm SSL installation
echo "🔍 Verifying SSL certificate installation..."
if nginx -t && systemctl reload nginx; then
    echo "✅ Nginx configuration validation successful!"
else
    echo "❌ Error: Nginx configuration validation failed. Please check the logs for details."
    exit 1
fi

# Test automatic renewal process
echo "🔄 Testing certificate auto-renewal system..."
if certbot renew --dry-run; then
    echo "✅ Auto-renewal test completed successfully!"
else
    echo "❌ Error: Auto-renewal test failed. Please check the Certbot configuration."
    exit 1
fi

# Setup crontab for auto-renewal
(crontab -l 2>/dev/null; echo "0 3 * * * certbot renew --quiet --renew-hook 'systemctl reload nginx'") | crontab -

# Installation and verification complete
echo "
✨ SSL Certificate Installation Complete! ✨
🔒 Domain: $domain
📧 Admin Email: $email
🔄 Auto-renewal: Configured (runs daily at 3 AM)
🌐 Your website is now secured with HTTPS!

ℹ️  Note: Your SSL certificate will automatically renew when needed.
"