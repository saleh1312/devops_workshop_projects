
## db
1- create private rds databse (user root , password admin123)
2- update security group of the rds database 
3- OPTIONAL create private hosted zone on route53 and route domain in rds 
    (domain = db01.vprof)
4- create ec2
5- run config.sh from ec2 to the rds 
6- chekck by
     mysql -h (db01.vprof or rds endpoint) -u root -padmin123
     show databases;