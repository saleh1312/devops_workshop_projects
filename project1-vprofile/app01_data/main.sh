sudo yum install epel-release -y
sudo dnf -y install java-11-openjdk java-11-openjdk-devel
sudo sudo dnf install git maven wget -y
cd /tmp/
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
sudo tar xzvf apache-tomcat-9.0.75.tar.gz
sudo useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat
sudo cp -r /tmp/apache-tomcat-9.0.75/* /usr/local/tomcat/
sudo chown -R tomcat.tomcat /usr/local/tomcat

sudo cp /vagrant/app01_data/tomcat.service /etc/systemd/system/tomcat.service

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable --now tomcat


git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project

mvn install

sudo systemctl stop tomcat

sudo dnf remove -y java-17-openjdk java-17-openjdk-headless java-17-openjdk-devel

sudo rm -rf /usr/local/tomcat/webapps/ROOT
sudo cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
sudo chown tomcat:tomcat /usr/local/tomcat/webapps/ROOT.war


sudo systemctl start tomcat