#!/bin/bash
# get master and slave
master=$2
slave=(192.160.0.1 192.160.0.2 192.160.0.3)
rpmSourcePath='/home/jaren/test.txt'
rpmDistPath=''

#1: deploy rpms
for ip in ${slave[@]}
do
	scp $rpmSourcePath $user@$ip$rpmDistPath
done

#2:Install master

ssh root@$master "rpm -Uvh $rpmDistPath/*"
for slaveTemp in ${slave[@]}
do
   ssh root@$slaveTemp "rpm -Uvh $rpmDistPath/*"
    
done 


#3. configue master
ssh root@$master "ln -s /usr/share/ganglia /var/www/html;
  chmod -R 755 /var/www/html/ganglia;
  chown -R nobody:nobody /var/lib/ganglia/rrds;
  /etc/httpd/conf.d/ganglia.conf;
  chmod 777 /var/lib/ganglia/dwoo/compiled;
  chmod 777 /var/lib/ganglia/dwoo/cache;
"

#modify /etc/httpd/conf.d/ganglia.conf
http_ganglia="
Alias /ganglia /usr/share/ganglia \n
<Location /ganglia> \n

  Order deny,allow \n

  Allow from all \n

</Location>
"


modify_httpfile="echo -e $http_ganglia > /etc/httpd/conf.d/ganglia.conf"


ssh root@master "$modify_httpfile"

#modify /etc/ganglia/gmetad.conf
  

for temp in ${slave[@]}
do
   var=${var}$temp":8649 "
   # echo $temp
done

modify_gmetadConf='sed -i '18c data_source : "hadoopcluster" $var' /etc/ganglia/gmetad.conf'
ssh root@master "$modify_gmetadConf"

#4. configur slave
modify_gmonConf='sed -i '30c name=my cluster' /etc/ganglia/gmond.conf'


for temp in ${slave[@]}
do
   ssh root@$temp '$modify_gmonConf'
   # echo $temp
done


