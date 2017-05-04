#!/bin/bash

#1.deploy enviroment
cat /etc/hosts

scp /home/hadoop/.bashrc hadoop@my-cluster-2-worker-20g20u-1:/home/hadoop
scp /home/hadoop/.bashrc hadoop@my-cluster-2-worker-20g20u-2:/home/hadoop
scp /home/hadoop/.bashrc hadoop@my-cluster-2-worker-20g20u-3:/home/hadoop
scp /home/hadoop/.bashrc hadoop@my-cluster-2-worker-20g20u-4:/home/hadoop
scp /home/hadoop/.bashrc hadoop@my-cluster-2-worker-20g20u-5:/home/hadoop
scp /home/hadoop/.bashrc hadoop@my-cluster-2-worker-20g20u-6:/home/hadoop
scp /home/hadoop/.bashrc hadoop@my-cluster-2-worker-20g20u-0:/home/hadoop

