#! /bin/sh

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

# Install Elastic Logstash Kibana Filebeat and Metricbeat
# And make sure you can access the generated password
 apt-get install elasticsearch logstash kibana -y > installationELK.log
 apt-get install filebeat metricbeat -y


## CONFIGURING ELASTICSEARCH
# Starting elasticsearch
systemctl daemon-reload
systemctl enable --now elasticsearch

# Change elasticsearch config
sudo sed -i 's/#cluster.name: my-application/cluster.name: elkcluster-1/g' /etc/elasticsearch/elasticsearch.yml

# Restart elasticsearch
systemctl restart elasticsearch

## CONFIGURING LOGSTASH
# Configure beats.conf
cat <<EOT >> /etc/logstash/conf.d/beats.conf
input {
  beats {
    port => "5044"
  }
}
output {
  elasticsearch {
    hosts => ["http://127.0.0.1:9200"]
    user => "elastic"
    password => ""
    index => "suricate-%{+YYYY.MM.dd}"
  }
}
EOT

# Start and enable logstash
sudo systemctl enable --now logstash

## CONFIGURING KIBANA
# Configure kibana.yml
sudo sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/' /etc/kibana/kibana.yml
sed -i 's/#server.port:/server.port:/g' /etc/kibana/kibana.yml
sudo sed -i 's/^#elasticsearch.hosts:/elasticsearch.hosts:/' /etc/kibana/kibana.yml


# Start and enable kibana
systemctl enable --now kibana

## CONFIGURING FILEBEATS
# Configure filebeat.yml
sudo sed -i 's/^output.elasticsearch:/#output.elasticsearch:/' /etc/filebeat/filebeat.yml
sudo sed -i '/hosts: \["localhost:9200"\]/s/^/#/' /etc/filebeat/filebeat.yml

sudo sed -i 's/#output.logstash/output.logstash/g' /etc/filebeat/filebeat.yml
sudo sed -i 's/#hosts: \["localhost:5044"\]/hosts: \["localhost:5044"\]/' /etc/filebeat/filebeat.yml

sudo sed -i '/^\- type: filestream/,/^\s*paths:/ s/enabled: false/enabled: true/' /etc/filebeat/filebeat.yml

# Start and enable filebeat
systemctl enable --now filebeat

## CONFIGURING METRICBEATS
# Configure metricbeat.yml
sudo sed -i 's/^output.elasticsearch:/#output.elasticsearch:/' /etc/metricbeat/metricbeat.yml
sudo sed -i '/hosts: \["localhost:9200"\]/s/^/#/' /etc/metricbeat/metricbeat.yml

sudo sed -i 's/#output.logstash/output.logstash/g' /etc/metricbeat/metricbeat.yml
sudo sed -i 's/#hosts: \["localhost:5044"\]/hosts: \["localhost:5044"\]/' /etc/metricbeat/metricbeat.yml

# Start and enable metricbeat
systemctl enable --now metricbeat




