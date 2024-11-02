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

#Mysql Installation
source ./mysql.sh

#PHP Installation
source ./php.sh

# Create a directory for the domain
sudo mkdir /var/www/$your_domain
sudo chown -R www-data:www-data /var/www/$your_domain

#Wordpress Installation
source ./wp.sh

#Virtual Host Installation
source ./virtualhost.sh

#Database Name Generate
dbname=`hexdump -n 8 -v -e '/1 "%02X"' /dev/urandom`

#Database User Generator
user='user'
pass=`hexdump -n 8 -v -e '/1 "%02X"' /dev/urandom`
dbuser="${user}${pass}"

#Restart the Apache
sudo systemctl restart apache2

#Restart the Mysql
sudo systemctl restart mysql

echo "Your Domain is: $your_domain"
echo "Your Mysql Password is: $rootpass"
echo "Your Database Name is: $dbname"
echo "Your Database User Name is: $dbuser"
echo "Your Database Password is: $rootpass"
