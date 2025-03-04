#!/bin/bash

sudo -i 

# updating Install EPEL release and Memcached
echo "updating  and Installing EPEL release and Memcached..."
yum update -y
dnf install epel-release -y
dnf install memcached -y

# Start and enable Memcached service
echo "Starting and enabling Memcached service..."
systemctl start memcached
systemctl enable memcached
systemctl status memcached

# Configure Memcached to listen on all interfaces
echo "Configuring Memcached to listen on all interfaces..."
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached

# Restart Memcached service to apply changes
echo "Restarting Memcached service..."
systemctl restart memcached

# Start and configure the firewall to allow access to Memcached on ports 11211 and 11111
echo "Configuring firewall for Memcached..."
firewall-cmd --add-port=11211/tcp
firewall-cmd --runtime-to-permanent
firewall-cmd --add-port=11111/udp
firewall-cmd --runtime-to-permanent
memcached -p 11211 -U 11111 -u memcached -d