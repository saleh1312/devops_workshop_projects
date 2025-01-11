#!/bin/bash

sudo yum install epel-release -y
sudo yum install git mariadb-server expect -y


systemctl start mariadb
systemctl enable mariadb

sudo mysql -u root < /vagrant/db01_data/set_db_pass.sql

sudo expect /vagrant/db01_data/mysql_secure_install.exp

sudo mysql -u root -padmin123 < /vagrant/db01_data/accounts.sql

git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
sudo mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql

sudo systemctl restart mariadb