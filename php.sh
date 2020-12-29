#!/bin/bash

#PHP Install
sudo apt-get -y update && sudo apt-get -y install php libapache2-mod-php php-mysql

#PHP MyAdmin Installation
sudo apt-get -y update && sudo apt-get -y install phpmyadmin php-mbstring

sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf

sudo a2enconf phpmyadmin.conf

sudo service apache2 reload
