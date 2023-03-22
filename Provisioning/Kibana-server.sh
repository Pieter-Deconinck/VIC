#! /bin/sh
#
# Author: Pieter deconinck <pieter.deconinck@outlook.com>
#
# This script installs a the Elasticsearch VM. 

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

 # Install Elasticsearch logstash and filebeat
apt install kibana logstash filebeat -y > installation.log

