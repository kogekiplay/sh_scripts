#!/bin/bash

# Remove existing Docker-related packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  sudo apt-get remove $pkg -y
done

# Update package list
sudo apt-get update

# Install required dependencies
sudo apt-get install ca-certificates curl gnupg -y

# Create the directory for apt keyrings
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker GPG key and save it to the keyring directory
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set appropriate permissions for the GPG key
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository to sources.list.d
echo "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again
sudo apt-get update

# Install Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# rm install.sh
rm install.sh
