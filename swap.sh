#!/bin/sh
echo "creating directory for swapfile, /var/swap"
mkdir -p /var/swap
echo "creating 4GB swapfile..."
dd if=/dev/zero of=/var/swap/swapfile bs=1M count=4096
mkswap /var/swap/swapfile
swapon /var/swap/swapfile
echo "/var/swap/swapfile swap swap defaults 0 0" >> /etc/fstab
free -h
