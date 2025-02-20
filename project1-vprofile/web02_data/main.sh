sudo dnf install nginx -y

sudo cp /vagrant/web02_data/vproapp.conf /etc/nginx/sites-available/vproapp

rm -rf /etc/nginx/sites-enabled/default

ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

sudo systemctl restart nginx

