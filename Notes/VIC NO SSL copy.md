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

Open kibana and go to check indexmanagement for suricate  
then go to discover where you can create your own view
for testing I used name: `test`  
and the current date: `*3.14`

I then also made a view in the dasboard that with agent.type.keyword
And that's it your all done and can explore your ELK stack now

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



# Extra extra
input {
  beats {
    port => "5044"
  }
}
filter {
  if [type] == "syslog" {
     grok {
        match => { "message" => "%{SYSLOGLINE}" }
  }
     date {
        match => [ "timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
     }
  }
}
output {
  elasticsearch {
    hosts => ["https://127.0.0.1:9200"]
    user => "elastic"
    password => "Ae=52Dc2nUH7ORXPA6ZX"
    cacert => "/etc/elasticsearch/certs/http_ca.crt"
    ssl_certificate_verification => false
    index => "suricate-%{+YYYY.MM.dd}"
  }
}