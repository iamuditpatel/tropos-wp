#!/bin/bash

chmod u+x apache.sh
chmod u+x firewall.sh
chmod u+x mysql.sh
chmod u+x virtualhost.sh
chmod u+x php.sh
chmod u+x wp.sh

echo "Enter Your Domain:"
read your_domain

#Apache Installation
source /home/ubuntu/environment/apache.sh

#Enable Firewall
source /home/ubuntu/environment/firewall.sh

#MYsql Password Generator
PASSWORD=$(date +%s|sha256sum|base64|head -c 12)
LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 12
rootpass="${PASSWORD} ${LC_ALL}"

#Mysql Installation
source /home/ubuntu/environment/mysql.sh

#PHP Installation
source /home/ubuntu/environment/php.sh

#Virtual Host Installation
source /home/ubuntu/environment/virtualhost.sh

#Database Name Generate
dbname=`hexdump -n 8 -v -e '/1 "%02X"' /dev/urandom`

#Database User Generator
user='dbuser'
pass=`hexdump -n 8 -v -e '/1 "%02X"' /dev/urandom`
dbuser="${user}${pass}"

#Database Paswword Generator
PASSWORD=$(date +%s|sha256sum|base64|head -c 12)
LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 12
dbpass="${PASSWORD} ${LC_ALL}"

#Wordpress Installation
source /home/ubuntu/environment/wp.sh

echo "Your Domain is: $your_domain"
echo "Your Mysql Password is: $rootpass"
echo "Your Database Name is: $dbname"
echo "Your Database User Name is: $dbuser"
echo "Your Database Password is: $dbpass"
