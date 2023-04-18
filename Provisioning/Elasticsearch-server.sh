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
apt install elasticsearch kibana logstash filebeat -y > installation.log

## CONFIGURING ELASTICSEARCH
# Starting elasticsearch
systemctl daemon-reload
systemctl enable --now elasticsearch

# Change elasticsearch config
sudo sed -i 's/#cluster.name: my-application/cluster.name: elkcluster-1/g' /etc/elasticsearch/elasticsearch.yml

# Restart elasticsearch
systemctl restart elasticsearch

## CONFIGURING LOGSTASH
# Create certs folder
sudo mkdir /etc/logstash/certs

# Copy cert 
cp /etc/elasticsearch/certs/http_ca.crt /etc/logstash/certs/http_ca.crt

# Make cert readable
sudo chmod 666 /etc/logstash/certs/http_ca.crt

# Configure beats.conf
cat <<EOT >> /etc/logstash/conf.d/beats.conf
input {
  beats {
    port => "5044"
  }
}
output {
  elasticsearch {
    hosts => ["https://127.0.0.1:9200"]
    user => "elastic"
    password => "REPLACE THIS"
    ssl => true
    cacert => "/etc/logstash/certs/http_ca.crt"
    ssl_certificate_verification => false
    index => "suricate-%{+YYYY.MM.dd}"
  }
}
EOT

# Start and enable logstash
sudo systemctl enable --now logstash

## CONFIGURING KIBANA
# Configuration happens automatically
sudo systemctl enable --now kibana

## CONFIGURING FILEBEATS
# Configure filebeat.yml
sudo sed -i 's/^output.elasticsearch:/#output.elasticsearch:/' /etc/filebeat/filebeat.yml
sudo sed -i '/hosts: \["localhost:9200"\]/s/^/#/' /etc/filebeat/filebeat.yml

sudo sed -i 's/#output.logstash/output.logstash/g' /etc/filebeat/filebeat.yml
sudo sed -i 's/#hosts: \["localhost:5044"\]/hosts: \["localhost:5044"\]/' /etc/filebeat/filebeat.yml

sudo sed -i '/^\- type: filestream/,/^\s*paths:/ s/enabled: false/enabled: true/' /etc/filebeat/filebeat.yml

# Enable Logstash module
filebeat modules enable logstash

# Start and enable filebeat
systemctl enable --now filebeat

