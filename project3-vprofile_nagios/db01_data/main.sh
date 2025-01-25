#!/bin/bash

sudo -i

# installing epel , maria, git, expect
echo "Installing EPEL release..."
yum update -y
yum install epel-release -y
yum install git mariadb-server expect -y

# start and enable mariadb
echo "Starting and enabling MariaDB service..."
systemctl start mariadb
systemctl enable mariadb

# Run mysql_secure_installation script automatically
echo "Securing MariaDB..."
expect /vagrant/db01_data/mysql_secure_install.exp

# mysql -u root < /vagrant/db01_data/set_db_pass.sql

# Configure MariaDB: Create database and user
echo "Configuring MariaDB database and user..."
mysql -u root -padmin123 < /vagrant/db01_data/accounts.sql

# Download source code and initialize database
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql

# Restart MariaDB service
echo "Restarting MariaDB service..."
systemctl restart mariadb

# Start and configure the firewall to allow access to MariaDB on port 3306
echo "Configuring firewall..."
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --get-active-zones
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --reload

echo "MariaDB setup is complete."