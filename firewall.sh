#!/bin/bash

#***************FIREWALL ENABLE***************
#To check list of ufw(firewall)
sudo ufw app list

#To allow Apache ufw
sudo ufw allow in "Apache"

#To check status of ufw
sudo ufw status

#If Ufw is disable then to enable it
sudo ufw enable

#Again To check status of ufw
sudo ufw status
