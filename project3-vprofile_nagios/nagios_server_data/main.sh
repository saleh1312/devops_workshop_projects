# sudo apt update && sudo apt upgrade -y
# sudo apt install expect -y
# sudo apt install -y wget build-essential apache2 php openssl perl make php-gd libgd-dev libapache2-mod-php libperl-dev libssl-dev daemon autoconf libc6-dev libmcrypt-dev libssl-dev libnet-snmp-perl gettext unzip
# cd /tmp
# wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
# sudo useradd nagios
# sudo groupadd nagcmd
# sudo usermod -a -G nagcmd nagios
# tar -xzf nagios-4.4.6.tar.gz
# cd nagios-4.4.6
# sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
# sudo make all
# sudo make install
# sudo make install-init
# sudo make install-commandmode
# sudo make install-config
# sudo /usr/bin/install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-enabled/nagios.conf
# sudo a2enmod rewrite
# sudo a2enmod cgi
# sudo systemctl restart apache2
# cd /tmp
# wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
# tar -xzf nagios-plugins-2.3.3.tar.gz
# cd nagios-plugins-2.3.3
# sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
# sudo make
# sudo make install
# sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
# sudo systemctl enable --now nagios.service
# sudo systemctl restart apache2.service

# expect <<EOF
# spawn sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
# expect "New password:"
# send "12345\r"
# expect "Re-type new password:"
# send "12345\r"
# expect eof
# EOF


# sudo cp -r /vagrant/nagios_server_data/servers /usr/local/nagios/etc/
# sudo sed -i 's/^#cfg_dir=\/usr\/local\/nagios\/etc\/servers/cfg_dir=\/usr\/local\/nagios\/etc\/servers/' /usr/local/nagios/etc/nagios.cfg
# sudo systemctl reload nagios.service



#!/bin/bash

sudo -i

# Install prerequisites and update system
yum install -y epel-release
yum update -y

yum install -y nagios nagios-plugins-all nrpe httpd --skip-broken

# Enable and start required services
systemctl enable httpd && systemctl start httpd
systemctl enable nagios && systemctl start nagios
systemctl start firewalld.service

# Configure firewall
firewall-cmd --add-service=http --permanent
firewall-cmd --add-port=5666/tcp --permanent
firewall-cmd --reload

cat <<EOL >> /etc/nagios/objects/clients.cfg
define host {
    use             linux-server
    host_name       db01
    address         192.168.56.15
}

define host {
    use             linux-server
    host_name       mc01
    address         192.168.56.14
}

define host {
    use             linux-server
    host_name       rmq01
    address         192.168.56.13
}

define host {
    use             linux-server
    host_name       app01
    address         192.168.56.12
}

define host {
    use             linux-server
    host_name       web02
    address         192.168.56.11
}
EOL


# Add service definitions
cat <<EOL >> /etc/nagios/objects/services.cfg
define service{
    use                     generic-service
    host_name               db01
    service_description     Ping Check
    check_command           check_ping!100.0,20%!500.0,60%
    max_check_attempts      4
    check_interval          5
    retry_interval          1
    check_period            24x7
    notification_interval   30
    notification_period     24x7
}

define service{
    use                     generic-service
    host_name               mc01
    service_description     Ping Check
    check_command           check_ping!100.0,20%!500.0,60%
    max_check_attempts      4
    check_interval          5
    retry_interval          1
    check_period            24x7
    notification_interval   30
    notification_period     24x7
}

define service{
    use                     generic-service
    host_name               rmq01
    service_description     Ping Check
    check_command           check_ping!100.0,20%!500.0,60%
    max_check_attempts      4
    check_interval          5
    retry_interval          1
    check_period            24x7
    notification_interval   30
    notification_period     24x7
}

define service{
    use                     generic-service
    host_name               app01
    service_description     Ping Check
    check_command           check_ping!100.0,20%!500.0,60%
    max_check_attempts      4
    check_interval          5
    retry_interval          1
    check_period            24x7
    notification_interval   30
    notification_period     24x7
}

define service{
    use                     generic-service
    host_name               web02
    service_description     Ping Check
    check_command           check_ping!100.0,20%!500.0,60%
    max_check_attempts      4
    check_interval          5
    retry_interval          1
    check_period            24x7
    notification_interval   30
    notification_period     24x7
}
EOL

# Add NRPE command definition
cat <<EOL >> /etc/nagios/objects/commands.cfg
define command {
    command_name    check_nrpe
    command_line    $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}
EOL

# Update Nagios configuration
sed -i '/cfg_file=\/etc\/nagios\/objects\/services.cfg/d' /etc/nagios/nagios.cfg
echo "cfg_file=/etc/nagios/objects/services.cfg" >> /etc/nagios/nagios.cfg

# Restart Nagios to apply changes
systemctl restart nagios

# Confirmation message
echo "Nagios services and commands configuration updated successfully."

