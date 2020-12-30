#!/bin/bash

#***************APACHE INSTALLATION***************
#To update and upgrade the system
sudo apt-get -y update && sudo apt-get -y upgrade

#To install Apache Server
sudo apt-get -y install apache2 

#Adding default server name to surpass the message
#sudo sed -i '$ a ServerName 127.0.0.1' /etc/apache2/apache2.conf

#To start, enable and check the status of Apache
sudo systemctl start apache2
sudo systemctl enable apache2


