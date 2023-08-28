#!/bin/bash
#add fix to exercise4-server2 here

# Edit /etc/hosts file
echo "192.168.60.10 server1" >> /etc/hosts

sudo systemctl restart systemd-resolved.service

