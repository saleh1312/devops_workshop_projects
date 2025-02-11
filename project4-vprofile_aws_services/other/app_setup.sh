#!/bin/bash

CONFIG_FILE="src/main/resources/application.properties"  # Change this to your actual file name

# Code build & deploy
# Download source code
echo "Downloading source code..."
cd /home/
git clone -b main https://github.com/hkhcoder/vprofile-project.git

# Update configuration
echo "Updating configuration..."
cd vprofile-project

sed -i 's|backend.server.url=.*|backend.server.url=http://db01:3306|' "$CONFIG_FILE"

# Replace jdbc.url
sed -i 's|jdbc:mysql://db01:3306|jdbc:mysql://db01.vprof:3306|g' "$CONFIG_FILE"

# Replace memcached.active.host
sed -i 's|memcached.active.host=mc01|memcached.active.host=mc01.vprof|g' "$CONFIG_FILE"

# Replace rabbitmq.address
sed -i 's|rabbitmq.address=rmq01|rabbitmq.address=rmq01.vprof|g' "$CONFIG_FILE"

echo "Configuration file updated successfully!"


# Build code
echo "Building code..."
mvn clean install

# Deploy artifact
echo "Deploying artifact..."
systemctl stop tomcat
rm -rf /usr/local/tomcat/webapps/ROOT*
cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
chown -R tomcat:tomcat /usr/local/tomcat/webapps
systemctl start tomcat
systemctl enable tomcat
echo "Tomcat setup and deployment is complete."

