#!/bin/bash

sudo apt-get -y install python-software-properties 

sudo add-apt-repository ppa:ondrej/php 

sudo apt-get -y update 

sudo apt-get install -y php7.0

sudo apt-get -y install php7.0-mysql php7.0-curl php7.0-json php7.0-cgi php7.0-xsl

apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-mbstring php7.0-gd php7.0-xml php7.0-xmlrpc php7.0-intl php7.0-soap php7.0-zip

sudo apt install php libapache2-mod-php php-mysql
