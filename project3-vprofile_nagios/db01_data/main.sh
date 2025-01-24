sudo -i

yum update -y
yum install epel-release -y
yum install git mariadb-server expect -y


systemctl start mariadb
systemctl enable mariadb

mysql -u root < /vagrant/db01_data/set_db_pass.sql

expect /vagrant/db01_data/mysql_secure_install.exp

mysql -u root -padmin123 < /vagrant/db01_data/accounts.sql

git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql

systemctl restart mariadb

systemctl start firewalld
systemctl enable firewalld
firewall-cmd --get-active-zones
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --reload
systemctl restart mariadb