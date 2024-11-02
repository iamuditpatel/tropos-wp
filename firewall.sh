#!/bin/bash

#To check list of ufw(firewall)
sudo ufw app list

#To allow Apache ufw
sudo ufw allow in "Apache"

#To allow Apache Full ufw
sudo ufw allow in "Apache Full"

#If Ufw is disable then to enable it
sudo ufw enable

#Check Ufw status
sudo ufw status


