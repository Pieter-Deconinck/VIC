Kibana server provision script installeert kibana.

Nu moet de configuration erin nog juist gezet worden zoals bij de autoconfiguration als je alles op 1 vm installeert.

Kibana config aanpassen met settings hieronder  

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


# Kibana server
server.port: 5601
server.host: 0.0.0.0

# Elasticsearch server
elasticsearch.hosts: ['https://192.168.50.20:9200']

# Path Kibana process id
pid.file: /run/kibana/kibana.pid

elasticsearch.username: "kibana_system"
elasticsearch.password: "Pieter"

# Path for elasticsearch certificate kibana uses to verify authenticity
elasticsearch.ssl.verificationMode: "none"
