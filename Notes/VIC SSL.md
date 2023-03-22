# INSTALLATION GUIDE


Let the setup.sh script do its thing with vagrant up  
Then vagrant ssh into the vm and input  
`sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana`

Then copy this token into kibana on localhost:5601  
And then get the verification code with  
`sudo /usr/share/kibana/bin/kibana-verification-code`

Open `/etc/kibana/kibana.yml`  
remove https -> http

open `/etc/elasticsearch/elasticsearch.yml`  
Change http.ssl and transport.ssl to false  

Add the password to `/etc/logstash/conf.d/beats.conf`

reboot the vm

Now just enable Filebeat and Metricbeats with  
`sudo filebeat modules enable logstash`  
`sudo metricbeat modules enable logstash`

Create certs folder  
`sudo mkdir /etc/logstash/certs`  

copy cert file from elasticsearch  
`sudo su`  
`cp /etc/elasticsearch/certs/http_ca.crt /etc/logstash/certs/http_ca.crt`  

Link correctly in beats to the cert  
`sudo nano /etc/logstash/conf.d/beats.conf`  
`cacert => "/etc/logstash/certs/http_ca.crt"`  
`ssl_certificate_verification => false`  
`sudo chmod 666 /etc/logstash/conf.d/beats.conf`  

Stop metricbeat and filebeat  
`sudo systemctl stop filebeat`  
`sudo systemctl stop metricbeat`  

Change filebeat settings  
`sudo nano /etc/filebeat/modules.d/logstash.yml`  
change both false to true  

input {
  beats {
    port => "5044"
  }
}
output {
  elasticsearch {
    hosts => ["https://127.0.0.1:9200"]
    user => "elastic"
    password => "X6mUKpqN7VxJKqCh6OML"
    ssl => true
    cacert => "/etc/logstash/certs/http_ca.crt"
    ssl_certificate_verification => false
    index => "suricate-%{+YYYY.MM.dd}"
  }
}

# EXTRA EXTRA

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

# Extra

You can find the elasticsearch superuser password in /home/vagrant/installationELK.log

Kibana login
user: elastic
ww: found in installlog

usefull command for logstash logs
`sudo journalctl -u logstash | tail -n 100`


Many thanks to:

https://techviewleo.com/install-elastic-stack-elk-on-debian/ (followed from step 4)

And the official documentation:

https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html
https://www.elastic.co/guide/en/logstash/current/installing-logstash.html
ttps://www.elastic.co/guide/en/kibana/current/deb.html


