#!/bin/bash
set -e

# Resize Swap File to RAM size
# sudo swapoff /swapfile
# sudo rm  /swapfile
# sudo dd if=/dev/zero of=/swapfile bs=1M count=34816
# sudo chmod 600 /swapfile
# sudo mkswap /swapfile
# sudo swapon /swapfile

# Get UUID and offset
blkid
sudo filefrag -v /swapfile

#sudo update-grub
#sudo reboot
