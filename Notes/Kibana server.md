Kibana server provision script installeert kibana.

Nu moet de configuration erin nog juist gezet worden zoals bij de autoconfiguration als je alles op 1 vm installeert.

Kibana config aanpassen met settings hieronder  
token genereren op elasticsearch server en copy pasten in kibana config
certs dir aanmaken  /var/lib/kibana/certs
met roots:kibana
en 770 als permissions

dan certs kopieren van elastic en kopieren naar die dir
en dan owner veranderen naar kibana:kibana
en 644 rechten


# Kibana server
server.port: 5601
server.host: 0.0.0.0

# Logstash server
elasticsearch.hosts: ['https://192.168.50.20:9200']

# Logging file type 
logging.appenders.file.type: file
# Kibana logs location and name
logging.appenders.file.fileName: /var/log/kibana/kibana.log
# Log file format
logging.appenders.file.layout.type: json
# Default appender
logging.root.appenders: [default, file]

# Path Kibana process id
pid.file: /run/kibana/kibana.pid

# Elasticsearch account token
elasticsearch.serviceAccountToken: eyJ2ZXIiOiI4LjYuMiIsImFkciI6WyIxMC4wLjIuMTU6OTIwMCJdLCJmZ3IiOiI3YjBjN2QzMGRiYmZkNDU5MDRhYThkZWZlZDI4MzdjODEyZmM2ZDJjYjUzZDkyZTRmMjA0Y2Q3YTRkNmMwNWE2Iiwia2V5IjoiSkYxZ0xZY0JBTGtsZEdmWGExUmo6WU9WYkZRaHdUYjZ6S0kzRGlPZnppUSJ9

# Path for elasticsearch certificate kibana uses to verify authenticity
elasticsearch.ssl.certificateAuthorities: [/var/lib/kibana/certs/ca_elastic.crt]
