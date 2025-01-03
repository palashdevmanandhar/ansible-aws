#!/bin/bash

# Ensure the script is run with sudo or root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must b e run as root or with sudo" 
   exit 1
fi

# Define the username
NEW_USER = "ansible"

# Create the new user
if id "$NEW_USER" &>/dev/null; then
    echo "User $NEW_USER already exists."
else
    useradd -m -s /bin/bash "$NEW_USER"
    echo "User $NEW_USER created."
fi

# Add the new user to the sudo group
usermod -aG sudo "$NEW_USER"
echo "User $NEW_USER added to the sudo group."

# Set the password for the new user
USER_PASS = "9849"
echo
echo "$NEW_USER:$USER_PASS" | chpasswd
echo "Password for $NEW_USER has been set."

# Grant the user passwordless sudo privileges
echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "Passwordless sudo privileges granted to $NEW_USER."

echo "Done! User $NEW_USER is created with passwordless sudo privileges."
