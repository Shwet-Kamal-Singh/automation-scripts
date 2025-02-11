#!/bin/sh

set -o errexit
set -o nounset
IFS=$(printf '\n\t')

# Helper function to print messages
log() {
    printf "[INFO] %s\n" "$1"
}

# Install Docker
install_docker() {
    log "Removing old Docker versions if any..."
    sudo apt remove --yes docker docker-engine docker.io containerd runc || true

    log "Updating package list..."
    sudo apt update

    log "Installing dependencies..."
    sudo apt --yes --no-install-recommends install apt-transport-https ca-certificates curl software-properties-common

    log "Adding Docker's official GPG key..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    log "Adding Docker repository..."
    sudo add-apt-repository --yes "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable"

    log "Updating package list again..."
    sudo apt update

    log "Installing Docker..."
    sudo apt --yes --no-install-recommends install docker-ce docker-ce-cli containerd.io

    log "Adding current user to the Docker group..."
    sudo usermod --append --groups docker "$USER"

    log "Enabling Docker to start on boot..."
    sudo systemctl enable docker

    log "Docker installed successfully!"
}

# Install Docker Compose
install_docker_compose() {
    log "Downloading Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    log "Setting executable permissions..."
    sudo chmod +x /usr/local/bin/docker-compose

    log "Verifying Docker Compose installation..."
    docker-compose --version

    log "Docker Compose installed successfully!"
}

# Adjust kernel parameters for Docker
adjust_kernel_params() {
    log "Adjusting kernel parameters..."
    sudo sysctl -w vm.max_map_count=262144
}

# Main script execution
main() {
    log "Starting Docker and Docker Compose installation..."
    install_docker
    adjust_kernel_params
    install_docker_compose

    log "Installation complete! Please log out and log back in for group changes to take effect."
}

main
