sudo yum update -y
sudo yum install nginx -y

sudo cp /vagrant/web02_data/vproapp.conf /etc/nginx/conf.d/vproapp.conf

sudo systemctl restart nginx