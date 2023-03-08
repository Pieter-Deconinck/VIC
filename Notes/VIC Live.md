VIC NOTES
----------
ELK elastic logstash kibana 
- ssl/tsl hoe werkt

exsi os 
vcenter voor clusters

mgmt 10.13.0.0/16
data 10.14.0.O/16

Idrac voor remote bios management

links op switch blijven

Exsi leren


----------
AlmaLinux_PieterDC
----------
VIC VM maken

Naar website gaan 
ISO kiezen en connect on power up
Dan user account maken

name: pdeconinck
WW: Pieter

Netwerk settings aanpassen op almalinux: NMTUI

----------
ELK Stack Debian
----------

Vagrant gebruikt en bentubox debian 11
geinstalleerd

Nu Elasticsearch installeren

Download and install the public signing key:
``wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg``

You may need to install the apt-transport-https package on Debian before proceeding:
``sudo apt-get install apt-transport-https``

Save the repository definition to /etc/apt/sources.list.d/elastic-8.x.list:

``echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list``

You can install the Elasticsearch Debian package with:
``sudo apt-get update && sudo apt-get install elasticsearch``

https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html


Logstash installeren

Run sudo apt-get update and the repository is ready for use. You can install it with:
``sudo apt-get update && sudo apt-get install logstash``

https://www.elastic.co/guide/en/logstash/current/installing-logstash.html

Kibana installeren

You may need to install the apt-transport-https package on Debian before proceeding:
``sudo apt-get install apt-transport-https``

Save the repository definition to /etc/apt/sources.list.d/elastic-8.x.list:

``echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list``

You can install the Kibana Debian package with:
``sudo apt-get update && sudo apt-get install kibana``

https://www.elastic.co/guide/en/kibana/current/deb.html




ELK stack configuren

https://techviewleo.com/install-elastic-stack-elk-on-debian/

elasticsearch step 4 gevolgd

elasticsearch wachtwoord: vCEJMjH5FQRxoo*1TehC



