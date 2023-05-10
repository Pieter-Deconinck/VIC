Adding the firewall logs of VIC network

Added pipeline file called syslog.conf
Started on port 8514 , for anything under 1024 root access is needed. 

input {
  syslog {
    port => 8514
    codec => plain
    syslog_field => "syslog"
  }
}
    output {
        elasticsearch {
            hosts => ["https://10.14.20.20:9200"]
            user => "logstash_internal"
            password => "Pieter"
            ssl_certificate_verification => true
            cacert => "/var/lib/logstash/certs/http_ca.crt"
            index => "syslog-%{+YYYY.MM.dd}"
        }
    }

Created additional pipeline for suricate so they dont get mashed into 1

`/etc/logstash/pipelines.yml`  

- pipeline.id: syslog

  path.config: "/etc/logstash/conf.d/syslog.conf"

- pipeline.id: suricate

  path.config: "/etc/logstash/conf.d/beats.conf"