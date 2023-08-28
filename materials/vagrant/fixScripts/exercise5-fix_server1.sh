#!/bin/bash
#add fix to exercise5-server1 here

# Define the path to the sshd_config file
sshd_config_file="/etc/ssh/sshd_config"
ssh_config_file="/etc/ssh/ssh_config"

# Uncomment the PubkeyAuthentication line if commented
sudo sed -i '/^#PubkeyAuthentication/s/^#//' $sshd_config_file

# Replace PasswordAuthentication no with PasswordAuthentication yes
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' $sshd_config_file

# Uncomment the StrictHostKeyChecking line and change 'ask' to 'no'
sudo sed -i -e '/^\s*#*\s*StrictHostKeyChecking/s/#*\s*StrictHostKeyChecking.*/StrictHostKeyChecking no/' "$ssh_config_file"

# Restart SSH service to apply changes
sudo systemctl restart sshd
sudo systemctl restart ssh

echo "Changes made to sshd_config: PubkeyAuthentication uncommented, PasswordAuthentication set to yes"

# Set vagrant user password
sudo chpasswd <<<"vagrant:Passwd123"

# Generate ssh key pair
su vagrant -c 'ssh-keygen -t rsa -b 4096 -C "vagrant@server2" -f /home/vagrant/.ssh/id_rsa -N ""'

# Set appropriate permissions for SSH files
sudo chmod 700 /home/vagrant/.ssh
sudo chmod 600 /home/vagrant/.ssh/id_rsa
sudo chmod 644 /home/vagrant/.ssh/id_rsa.pub
