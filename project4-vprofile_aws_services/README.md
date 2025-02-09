## initial 
1- create ec2

## db
1- create private rds databse (user root , password admin123)
2- update security group of the rds database 
3- OPTIONAL create private hosted zone on route53 and route domain in rds 
    (domain = db01.vprof)

4- run db_config.sh from ec2 to the rds 
5- chekck by
     mysql -h (db01.vprof or rds endpoint) -u root -padmin123
     show databases;


## mc
1- create elasticache memcached 
2- assign security group and open port 11211
3- OPTIONAL create private hosted zone on route53 and route domain in rds 
    (domain = mc01.vprof)

4- run mc_config.sh from ec2 
5- run test_mem.py to test connection


## rmq
1- creat amazon mq (rappid maq) with (user = test, password=test123456789)
2- assign security group and open port 5671
3- OPTIONAL create private hosted zone on route53 and route domain in rds 
    (domain = rmq01.vprof)

4- run rmq_config.sh
5- copy rmq endpoint and remove (port -> in the end) and (amqps:// -> in the begining)
    and put it in BROKER_HOST in test_rmq.py
6- run test_rmq.py to test connection
