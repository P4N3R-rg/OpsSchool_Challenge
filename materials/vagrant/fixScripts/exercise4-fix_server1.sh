#!/bin/bash
#add fix to exercise4-server1 here

# Edit /etc/hosts file
echo "192.168.60.11 server2" >> /etc/hosts

sudo systemctl restart systemd-resolved.service