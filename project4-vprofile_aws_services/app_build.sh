# Update configuration
echo "Updating configuration..."
cd /home/vprofile-project

######################################
######### DO NOT FORGET TO REPLACE PROPERTIES
#######################################

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

echo "Tomcat setup and deployment is complete."