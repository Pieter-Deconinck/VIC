# VIC

This repository contains my personal workspace and documentation for the [Virtual IT Company](https://vichogent.be/index.html) at [Hogent](https://hogent.be/).

This repository was made by [Pieter Deconinck](https://github.com/Pieter-Deconinck).  
I am a student at [Hogent](https://hogent.be), currently studying for a [Professional bachelor in applied informatics](https://www.hogent.be/en/future-student/bachelors/applied-information-technology/).

Feel free to connect on [linkedin](https://www.linkedin.com/in/pieter-deconinck-/)

## **Content**

I was tasked with installing and configuring a ELK-stack which we could run on the datacenter, collecting logs from the vmware machines and clients.  
Which then can visualized in Kibana.

- The installation process can be found in [Documentation](./Documentation/).  

Extra documentation can be found in seperate folders, but beware these might be outdated,  
as these were made throughout the researching and testing process.

Elasticsearch - The database/content manager.  
Kibana - The webserver application displaying the data, and configuring elasticsearch settings.  
Logstash - The pipeline handler which sends the collected data to Elasticsearch.  
Filebeat - The log collecter which gets installed on certain client machines.  


