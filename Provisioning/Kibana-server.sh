#! /bin/sh
#
# Author: Pieter deconinck <pieter.deconinck@outlook.com>
#
# This script installs a the Kibana VM. 

set -o errexit # abort on nonzero exitstatus
set -o nounset # abort on unbound variable

# Vagrant gebruikt en bentubox debian 11
# geinstalleerd

# Download and install the public signing key:
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

# You may need to install the apt-transport-https package on Debian before proceeding:
apt-get install apt-transport-https

# Save the repository definition to /etc/apt/sources.list.d/elastic-8.x.list:
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

# Update debian packagemanger
 apt-get update

 # Install Kibana logstash and filebeat
apt install kibana logstash filebeat -y > installation.log

## CONFIGURING KIBANA
# Configure kibana.yml
# Allow connection from other then localhost
#sudo sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/' /etc/kibana/kibana.yml
# uncomment server port
#sed -i 's/#server.port:/server.port:/g' /etc/kibana/kibana.yml
# uncomment and change elasticsearch host location
#sudo sed -i 's/^#elasticsearch.hosts:/elasticsearch.hosts:/' /etc/kibana/kibana.yml
#sed -i 's/http:\/\/localhost:9200/http:\/\/192.168.50.20:9200/g' /etc/kibana/kibana.yml

# Start and enable kibana
systemctl enable --now kibana



