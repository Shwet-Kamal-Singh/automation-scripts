#!/bin/bash

# Function to clone the repository
clone_repo() {
    local repo_url="$1"
    local repo_name=$(basename "$repo_url" .git)
    git clone "$repo_url"
    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository."
        exit 1
    fi
    echo "Repository cloned successfully."
    cd "$repo_name" || exit
}

# Function to run a script from the cloned repository
run_script() {
    local script_name="$1"
    if [ -f "$script_name" ]; then
        chmod +x "$script_name"
        ./"$script_name"
        if [ $? -ne 0 ]; then
            echo "Failed to run the script."
            exit 1
        fi
        echo "Script executed successfully."
    else
        echo "Script not found in the repository."
        exit 1
    fi
}

# Ask for the Git repository address
read -p "Enter the Git repository address: " repo_url

# Clone the repository
clone_repo "$repo_url"

# Ask for the script name to run
read -p "Enter the script name to run (with extension, e.g., deploy.sh): " script_name

# Run the specified script
run_script "$script_name"