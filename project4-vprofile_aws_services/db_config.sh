#!/bin/bash

echo "INSTALLING GIT AND MARIADB "
yum -y install git mariadb-server
systemctl enable mariadb
systemctl start mariadb

rm -rf /home/db_conf
mkdir /home/db_conf
cd /home/db_conf

# Configure MariaDB: Create database and user
echo "Configuring MariaDB database and user..."
mysql -h db01.vprof -u root -padmin123 <<MYSQL_SCRIPT
DROP DATABASE IF EXISTS accounts;
CREATE DATABASE accounts;
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Download source code and initialize database
echo "Cloning source code and initializing database..."
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mysql -h db01.vprof -u root -padmin123 accounts < src/main/resources/db_backup.sql