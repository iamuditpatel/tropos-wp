#!/bin/bash

chmod u+x apache.sh
chmod u+x firewall.sh
chmod u+x mysql.sh
chmod u+x virtualhost.sh
chmod u+x php.sh
chmod u+x wp.sh

#!/bin/bash

# Prompt for domain name
read -p "Enter Your Domain: " your_domain

# Prompt for MySQL root password
read -sp "Enter MySQL Root Password: " rootpass

# Update system packages
sudo apt-get update
sudo apt-get -y upgrade

#Apache Installation
source ./apache.sh

#Enable Firewall
source ./firewall.sh

#MYsql Password Generator
PASSWORD=$(date +%s|sha256sum|base64|head -c 12)
LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 12
rootpass="${PASSWORD}${LC_ALL}"

#Mysql Installation
source ./mysql.sh

#PHP Installation
source ./php.sh

#Virtual Host Installation
source ./virtualhost.sh

#Database Name Generate
dbname=`hexdump -n 8 -v -e '/1 "%02X"' /dev/urandom`

#Database User Generator
user='user'
pass=`hexdump -n 8 -v -e '/1 "%02X"' /dev/urandom`
dbuser="${user}${pass}"

#Wordpress Installation
source ./wp.sh

#Restart the Apache
sudo systemctl restart apache2

#Restart the Mysql
sudo systemctl restart mysql

echo "Your Domain is: $your_domain"
echo "Your Mysql Password is: $rootpass"
echo "Your Database Name is: $dbname"
echo "Your Database User Name is: $dbuser"
echo "Your Database Password is: $rootpass"
