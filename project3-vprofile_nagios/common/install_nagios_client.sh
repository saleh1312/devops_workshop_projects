#!/bin/bash

sudo yum install -y epel-release
sudo yum update -y
sudo yum install -y nrpe nagios-plugins-all --skip-broken
echo "allowed_hosts=127.0.0.1,192.168.56.10" >> /etc/nagios/nrpe.cfg
sudo systemctl enable nrpe && sudo systemctl start nrpe
sudo systemctl start firewalld.service
sudo firewall-cmd --add-port=5666/tcp --permanent
sudo firewall-cmd --reload
