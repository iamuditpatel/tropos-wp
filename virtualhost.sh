#!/bin/bash


#Creat a directory of your domain
sudo mkdir /var/www/$your_domain

#Get owner Permission
sudo chown -R $USER:$USER /var/www/$your_domain/

#Copying the virtual host content to your_domain.conf file
sudo cp ./virtual_host.txt  /etc/apache2/sites-available/$your_domain.conf

#Replacing your domain in .conf file
sudo sed -i "s/domain/$your_domain/g" /etc/apache2/sites-available/$your_domain.conf

#To enable rewrite module
sudo a2enmod rewrite

#To enable new virtual host
sudo a2ensite $your_domain

#Disable the default conf
sudo a2dissite 000-default

#To check if any error exist in configuration file
sudo apache2ctl configtest

#Reload the Apache Server
sudo systemctl reload apache2
