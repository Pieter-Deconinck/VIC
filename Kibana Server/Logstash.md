input {
  beats {
    port => "5044"
  }
}
output {
  elasticsearch {
    hosts => ["https://192.168.50.20:9200"]
    user => "logstash_internal"
    password => "LOGSTASHINTERNALUSERPASSWORD"
    ssl_certificate_verification => false
    index => "suricate-%{+YYYY.MM.dd}"
  }
}