# ELK client 

Internal network or bridged?
trying with internal first
Adding internal network to vagrant files

# Internal network

Adding static IP to ELK server 

        Vagrant.configure("2") do |config|
            config.vm.network "private_network", ip: "192.168.50.10"
        end

Adding static IP to ELK client

        Vagrant.configure("2") do |config|
            config.vm.network "private_network", ip: "192.168.50.4"
        end


# Adding ELKstack client

Create new vm
Download and install logstash, filebeat, metricbeat

Download and install the public signing key
`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`  

You may need to install the apt-transport-https package on Debian before proceeding:  
`sudo apt-get install apt-transport-https`

Save the repository definition to /etc/apt/sources.list.d/elastic-8.x.list:  
`sudo echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list`  

Update apt  
`sudo apt update` 

Download logstash, filebeat, metricbeat  
`sudo apt install logstash filebeat metricbeat -y`  


Create cert folder  
`sudo mkdir /etc/logstash/certs`  

Go to ELK server and scp cert to ELK client
`sudo scp /etc/logstash/certs/http_ca.crt vagrant@192.168.50.15:/home/vagrant/`  

copy cert to certs folder
`sudo mv /home/vagrant/http_ca.crt /etc/logstash/certs/`  

Change read permission on cert file 
`sudo chmod 666 /etc/logstash/certs/http_ca.crt`  

configure beats.conf
`sudo nano /etc/logstash/conf.d/beats.conf`  

    input {
      beats {
        port => "5044"
      }
    }
    output {
      elasticsearch {
       hosts => ["https://192.168.50.10:9200"]
       user => "elastic"
       password => "Ho2y4dPtXVHsDwth2XWD"
       ssl => true
       cacert => "/etc/logstash/certs/http_ca.crt"
       ssl_certificate_verification => false
       index => "suricate-%{+YYYY.MM.dd}"
      }
    }

enable Filebeat and Metricbeats with  
`sudo filebeat modules enable logstash`  
`sudo metricbeat modules enable logstash`

Change filebeat settings to logstash

Change metricbeat settings to logstash

Change filebeat logstash module settings  
`sudo nano /etc/filebeat/modules.d/logstash.yml`  
change both false to true  

enable filebeat metricbeat and logstash  
`sudo systemctl enable --now logstash`  
`sudo systemctl enable --now filebeat`  
`sudo systemctl enable --now metricbeat`  

restart vm... profit?