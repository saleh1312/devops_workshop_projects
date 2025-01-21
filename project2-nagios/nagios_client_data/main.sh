sudo yum install epel-release -y

sudo yum install nrpe nagios-plugins-all --skip-broken -y
sudo sed -i 's/^allowed_hosts=.*/allowed_hosts=127.0.0.1,::1,192.168.56.125/' /etc/nagios/nrpe.cfg
sudo systemctl start nrpe.service
sudo systemctl enable nrpe.service