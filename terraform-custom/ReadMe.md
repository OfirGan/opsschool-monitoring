## Task 0 (pre session)
* ssh to monitor server
* run commands:
```
cd /home/ubuntu/opsschool/compose/
docker-compose up -d  
```
    
* This will spin up 2 containers, one with prometheus and one with grafana.
* Varify you can access grafana at:
    http://you-host-ip-address:3000
    http://you-host-ip-address:9090
* Initial user and password are admin\admin

---
## Task 1

* ssh to monitor server
*  Try and understand the code In:
    /home/ubuntu/opsschool/instrument/mock_python.py

* run commands:
```
cd /home/ubuntu/opsschool/instrument/
docker-compose build
docker-compose up -d  
```
* try and curl the metrics at port 9200