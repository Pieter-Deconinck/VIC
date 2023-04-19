root@DebianELKClient:/etc/logstash/certs# history
    1  clear
    2  cd /etc/logstash/certs/
    3  clear
    4  ls
    5  ls
    6  exit
    7  echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
    8  apt-get update
    9  apt-get install elasticsearch -y > installationE.log
   10  clear
   11  cat installationE.log
   12  sudo apt remove elasticsearch
   13  clear
   14  sudo rm installationE.log
   15  clear
   16  sudo apt install logstash -y
   17  apt-get install filebeat metricbeat -y
   18  clear
   19  sudo nano /etc/logstash/conf.d/beats.conf
   20  sudo mdkir /etc/logstash/certs
   21  sudo mkdir /etc/logstash/certs
   22  ls
   23  mv http_ca.crt /etc/logstash/certs/
   24  cd /etc/logstash/certs/
   25  ls
   26  clear
   27  ls -lh
   28  sudo chmod 666 http_ca.crt
   29  ls
   30  ls -lh
   31  sudo sed -i 's/^output.elasticsearch:/#output.elasticsearch:/' /etc/filebeat/filebeat.yml
   32  sudo sed -i '/hosts: \["localhost:9200"\]/s/^/#/' /etc/filebeat/filebeat.yml
   33  sudo sed -i 's/#output.logstash/output.logstash/g' /etc/filebeat/filebeat.yml
   34  sudo sed -i 's/#hosts: \["localhost:5044"\]/hosts: \["localhost:5044"\]/' /etc/filebeat/filebeat.yml
   35  sudo sed -i '/^\- type: filestream/,/^\s*paths:/ s/enabled: false/enabled: true/' /etc/filebeat/filebeat.yml
   36  sudo sed -i 's/^output.elasticsearch:/#output.elasticsearch:/' /etc/metricbeat/metricbeat.yml
   37  sudo sed -i '/hosts: \["localhost:9200"\]/s/^/#/' /etc/metricbeat/metricbeat.yml
   38  sudo sed -i 's/#output.logstash/output.logstash/g' /etc/metricbeat/metricbeat.yml
   39  sudo sed -i 's/#hosts: \["localhost:5044"\]/hosts: \["localhost:5044"\]/' /etc/metricbeat/metricbeat.yml
   40  sudo filebeat modules enable logstash
   41  sudo metricbeat modules enable logstash
   42  clear
   43  sudo systemctl enable --now logstash
   44  sudo systemctl enable --now filebeat
   45  sudo systemctl enable --now metricbeat
   46  clear
   47  sudo systemctl status logstash
   48  sudo systemctl status filebeat
   49  sudo systemctl status metricbeat
   50  sudo nano /etc/filebeat/modules.d/logstash.yml
   51  sudo systemctl restart filebeat
   52  sudo systemctl restart metricbeat
   53  sudo systemctl status filebeat
   54  clear
   55  sudo systemctl status logstash
   56  sudo curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   57  sudo curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   58  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   59  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   60  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   61  sudo nano /etc/logstash/conf.d/beats.conf
   62  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   63  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic http://192.168.50.5:9200
   64  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic http://192.168.50.5:9200
   65  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   66  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:920
   67  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   68  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   69  sudo nano /etc/logstash/conf.d/beats.conf
   70  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.5:9200
   71  sudo nano /etc/logstash/conf.d/beats.conf
   72  sudo systemctl restart logstash
   73  sudo curl --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.10:9200
   74  sudo curl --insecure --cacert /etc/logstash/certs/http_ca.crt -u elastic https://192.168.50.10:9200
   75  clear
   76  cd
   77  ls
   78  history
   79  clear
   80  sudo systemctl status logstash
   81  clear
   82  exit
   83  history
   84  clear
   85  history
root@DebianELKClient:/etc/logstash/certs#


vagrant@DebianELKClient:/etc/logstash/certs$ history
    1  cat installationE.log
    2  clear
    3  sudo su
    4  exitù
    5  exit
    6  sudo apt install elasticsearch -y > log
    7  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
    8  apt-get install apt-transport-https
    9  sudo apt-get install apt-transport-https
   10  sudo su
   11  exit
   12  cat in
   13  ssh vagrant@192.168.50.10
   14  exit
   15  sudo nano /etc/elasticsearch/elasticsearch.yml
   16  sudo apt remove elasticsearch
   17  sudo apt remove --purge elasticsearch
   18  sudo systemctl restart logstash
   19  sudo systemctl status logstash
   20  clear
   21  exit
   22  clear
   23  sudo systemctl restart logstash
   24  sudo systemctl status logstash
   25  sudo nano /etc/logstash/conf.d/beats.conf
   26  history
   27  sudo systemctl status logstash
   28  clear
   29  sudo systemctl status logstash
   30  clear
   31  sudo systemctl status logstash
   32  clear
   33  history
   34  sudo nano /etc/logstash/conf.d/beats.conf
   35  cd /etc/logstash/
   36  ls
   37  cd certs/
   38  ls
   39  ls-lh
   40  ls -lh
   41  sudo su
   42  history

   vagrant@DebianELKClient:/etc/logstash$ ls -lh
total 48K
drwxr-xr-x 2 root root 4.0K Mar 15 14:11 certs
drwxr-xr-x 2 root root 4.0K Mar 22 13:00 conf.d
-rw-r--r-- 1 root root 1.8K Feb 12 05:39 jvm.options
-rw-r--r-- 1 root root 7.3K Feb 12 05:39 log4j2.properties
-rw-r--r-- 1 root root  342 Feb 12 05:39 logstash-sample.conf
-rw-r--r-- 1 root root  15K Mar 15 14:05 logstash.yml
-rw-r--r-- 1 root root  285 Feb 12 05:39 pipelines.yml
-rw------- 1 root root 1.7K Feb 12 05:39 startup.options
vagrant@DebianELKClient:/etc/logstash$

vagrant@DebianELKClient:/etc/logstash/certs$ ls -lh
total 4.0K
-rw-rw-rw- 1 vagrant vagrant 1.9K Mar 15 14:11 http_ca.crt
vagrant@DebianELKClient:/etc/logstash/certs$