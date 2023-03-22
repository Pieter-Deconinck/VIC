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


