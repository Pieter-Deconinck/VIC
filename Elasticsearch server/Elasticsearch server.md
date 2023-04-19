Elasticsearch installeren
Wachtwoord van default kibana user instellen

curl -k -XPUT -u elastic:ELASTICUSERPASSWORDHERE "https://localhost:9200/_security/user/kibana_system/_password" -H "Content-Type: application/json" -d'
{
  "password": "Pieter"
}'

curl -k -XPUT -u elastic:ELASTICUSERPASSWORDHERE "https://localhost:9200/_security/user/beats_system/_password" -H "Content-Type: application/json" -d'
{
  "password": "Pieter"
}'




