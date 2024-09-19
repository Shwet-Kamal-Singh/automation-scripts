#!/bin/bash

# Function to display existing public keys
show_public_keys() {
  echo "Existing public keys:"
  if [ -d "$HOME/.ssh" ]; then
    ls -l $HOME/.ssh/*.pub 2>/dev/null
  else
    echo "No .ssh directory found."
  fi
}

# Function to add a new public key
add_public_key() {
  read -p "Enter the public key to add: " new_key
  echo $new_key >> $HOME/.ssh/authorized_keys
  echo "Public key added."
}

# Function to remove an existing public key
remove_public_key() {
  echo "Select the public key to remove:"
  select key in $HOME/.ssh/*.pub; do
    if [ -n "$key" ]; then
      rm -f "$key"
      echo "Public key $key removed."
      break
    else
      echo "Invalid selection."
    fi
  done
}

# Function to generate a new SSH key pair
generate_ssh_key() {
  read -p "Enter the email for the new SSH key: " email
  ssh-keygen -t rsa -b 4096 -C "$email"
  echo "New SSH key pair generated."
}

# Main script logic
echo "SSH Key Management"
echo "1) Show existing public keys"
echo "2) Add a new public key"
echo "3) Remove an existing public key"
echo "4) Generate a new SSH key pair"
echo "5) Exit"

read -p "Enter your choice (1-5): " choice

case $choice in
  1)
    show_public_keys
    ;;
  2)
    add_public_key
    ;;
  3)
    remove_public_key
    ;;
  4)
    generate_ssh_key
    ;;
  5)
    echo "Exiting."
    exit 0
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

exit 0