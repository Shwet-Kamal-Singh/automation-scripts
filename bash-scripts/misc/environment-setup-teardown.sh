#!/bin/bash

# Function to set up the environment
setup_environment() {
  echo "Setting up the environment..."

  # Update package lists
  sudo apt-get update

  # Install necessary packages
  sudo apt-get install -y git curl vim

  # Set up Python environment
  sudo apt-get install -y python3 python3-venv python3-pip
  python3 -m venv myenv
  source myenv/bin/activate

  # Install Python packages
  pip install requests flask

  echo "Environment setup complete."
}

# Function to tear down the environment
teardown_environment() {
  echo "Tearing down the environment..."

  # Deactivate Python virtual environment
  deactivate

  # Remove Python virtual environment
  rm -rf myenv

  # Remove installed packages (optional)
  sudo apt-get remove --purge -y git curl vim python3-venv python3-pip
  sudo apt-get autoremove -y

  echo "Environment teardown complete."
}

# Main script logic
if [ "$1" == "setup" ]; then
  setup_environment
elif [ "$1" == "teardown" ]; then
  teardown_environment
else
  echo "Usage: $0 {setup|teardown}"
  exit 1
fi

exit 0