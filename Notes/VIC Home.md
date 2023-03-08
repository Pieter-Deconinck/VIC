# INSTALLATION GUIDE


Let the setup.sh script do its thing with vagrant up  
Then vagrant ssh into the vm and input
`sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana`

Then copy this token into kibana on localhost:5601  
And then get the verification code with  
`sudo /usr/share/kibana/bin/kibana-verification-code`

Now just enable Filebeat and Metricbeats with
`sudo filebeat modules enable system`
`sudo metricbeat modules enable logstash`

And that's it your all done and can explore your ELK stack now

extra: You can find the elasticsearch superuser password in /home/vagrant/installationELK.log 
       Also needed to add more Ram power



Many thanks to:

https://techviewleo.com/install-elastic-stack-elk-on-debian/ (followed from step 4)

And the official documentation:

https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html
https://www.elastic.co/guide/en/logstash/current/installing-logstash.html
ttps://www.elastic.co/guide/en/kibana/current/deb.html


login: elastic
ww: qe=OsH_+UIdvbJq3MFsa






