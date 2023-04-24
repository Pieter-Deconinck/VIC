# Introduction

This is my documentation for installing a seperated ELK stack.  
What you will need:  
Vagrant  
Debian  


VM's structure:  

1 Elasticsearch VM: 192.168.50.20  
1 Kibana VM: 192.168.50.21  
1 Logstash VM: 192.168.50.22  
1 Elkclient VM: 192.168.50.23

Filebeat will be used to log logs on client and send them to Logstash  

## Elasticsearch Server  

**Install Elasticsearch**  
Download and install the public signing key:  
`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`  

You may need to install the apt-transport-https package on Debian before proceeding:  
`apt-get install apt-transport-https`  

Save the repository definition to /etc/apt/sources.list.d/elastic-8.x.list:  
`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list`  

Update debian packagemanger:  
 `apt-get update`  

Install Elasticsearch logstash and filebeat:  
`apt install elasticsearch -y > installationElasticsearch.log`  

Starting elasticsearch:  
`systemctl daemon-reload`  
`systemctl enable --now elasticsearch`  

Restart elasticsearch:  
`systemctl restart elasticsearch`  

**Configure Elasticsearch**
Configure the default Kibana user:  

    curl -k -XPUT -u elastic:pq6JrYuQJPKokRFcPnhO "https://localhost:9200/_security/user/kibana_system/_password" -H "Content-Type: application/json" -d'
    {
    "password": "Pieter"
    }'



## Kibana Server

**Install Kibana**  
Download and install the public signing key:  
`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`  

You may need to install the apt-transport-https package on Debian before proceeding:  
`apt-get install apt-transport-https`  

Save the repository definition to /etc/apt/sources.list.d/elastic-8.x.list:  
`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list`  

Update debian packagemanger:  
`apt-get update`  

Install Kibana:  
`apt install kibana -y > installationKibana.log`  

Start and enable kibana:  
`systemctl enable --now kibana`  

**Configuring Kibana**

Delete content of /etc/kibana/kibana.yml and replace with:  

---START--- (dont copy this line)

logging:
  appenders:
    file:
      type: file
      fileName: /var/log/kibana/kibana.log
      layout:
        type: json
  root:
    appenders:
      - default
      - file


-# Kibana server
server.port: 5601
server.host: 0.0.0.0

-# Elasticsearch server
elasticsearch.hosts: ['https://192.168.50.20:9200']

-# Path Kibana process id
pid.file: /run/kibana/kibana.pid

elasticsearch.username: "kibana_system"
elasticsearch.password: "Pieter"

-# Path for elasticsearch certificate kibana uses to verify authenticity
-# elasticsearch.ssl.certificateAuthorities: [/var/lib/kibana/certs/ca_elastic.crt]

-# Path for elasticsearch certificate kibana uses to verify authenticity
elasticsearch.ssl.verificationMode: "none"

--- END --- (dont copy this line)

**Optional: Use cert to confirm ssl**  

Create cert directory:  
`sudo mkdir /var/lib/kibana/certs`  
`sudo chown vagrant:kibana /var/lib/kibana/certs`  
`sudo chmod 770 /var/lib/kibana/certs`  

Now copy the http_ca.crt from Elastichsearch to Kibana  
`scp /etc/elasticsearch/certs/http_ca.crt vagrant@192.168.50.21:/var/lib/kibana/certs/`  

Back in Kibana:  
`sudo chown kibana:kibana /var/lib/kibana/certs/http_ca.crt`  
`sudo chmod 644 /var/lib/kibana/certs/http_ca.crt`  

Change ssl verification method:  
Open `/etc/kibana/kibana.yml`  
and uncomment path for certificate  
and recomment ssl verification  

**Create Logstash_writer role and Logstash_internal user**

Navigate to the kibana website  
Go to the management tab  
navigate to security  

click on roles
Here you should create a new role
name: `logstash_writer`  
cluster privileges: `manage_index_templates`  
`monitor` `manage_ilm`  
indices: `suricate-*`  
Privileges: `write` `create` `delete`  
`create_index` `manage` `manage_ilm`  
click on create role  

click on users  
Here you should create a new user  
name: `logstash_internal`  
password: `Pieter`  
roles: `logstash_writer` `beats_system` 

Restart the service or reboot the vm

## Logstash server

**Install Logstash**  
Download and install the public signing key:  
`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`  

You may need to install the apt-transport-https package on Debian before proceeding:  
`apt-get install apt-transport-https`  

Save the repository definition to /etc/apt/sources.list.d/elastic-8.x.list:  
`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list`  

Update debian packagemanger:  
`apt-get update`  

Install Logstash:  
`apt install logstash -y > installationLogstash.log`  

Start and enable Logstash:  
`systemctl enable --now Logstash`  

**Configuring Logstash**

Create beats.conf:  
`sudo nano /etc/logstash/conf.d/beats.conf`  

    input {
        beats {
            port => "5044"
        }
    }
    output {
        elasticsearch {
            hosts => ["https://192.168.50.20:9200"]
            user => "logstash_internal"
            password => "Pieter"
            ssl_certificate_verification => false
            index => "suricate-%{+YYYY.MM.dd}"
        }
    }

Restart the service or reboot the vm

## Filebeat client

TODO: Filebeat installed on Logstash server works, but not seperately installed alone as a client

**Install Filebeat**  
Download and install the public signing key:  
`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`  

You may need to install the apt-transport-https package on Debian before proceeding:  
`apt-get install apt-transport-https`  

Save the repository definition to /etc/apt/sources.list.d/elastic-8.x.list:  
`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list`  

Update debian packagemanger:  
`apt-get update`  

Install Filebeat:  
`apt install filebeat -y > installationFilebeat.log`  

Start and enable Filebeat:  
`systemctl enable --now Logstash`  

**Configuring Filebeat**  
Enable logstash module:  
`sudo filebeat modules enable logstash`  

Change Filebeat settings:  
`sudo nano /etc/filebeat/modules.d/logstash.yml`  

Restart the service or reboot the vm
