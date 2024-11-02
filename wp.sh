#!/bin/bash

# Download and extract the latest version of WordPress
cd /var/www/$your_domain
sudo curl -O https://wordpress.org/latest.tar.gz
sudo tar xzvf latest.tar.gz
sudo rm latest.tar.gz

# Move WordPress files to root directory
sudo mv wordpress/* /var/www/$your_domain/
sudo rm -r wordpress

# Set up MySQL database and user for WordPress
dbname="wordpress_$(date +%s)"
dbuser="wpuser_$(date +%s)"
sudo mysql -u root -p$rootpass << EOF
CREATE DATABASE $dbname;
CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$rootpass';
GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Configure WordPress
sudo mv /var/www/$your_domain/wp-config-sample.php /var/www/$your_domain/wp-config.php
sudo sed -i "s/database_name_here/$dbname/g" /var/www/$your_domain/wp-config.php
sudo sed -i "s/username_here/$dbuser/g" /var/www/$your_domain/wp-config.php
sudo sed -i "s/password_here/$rootpass/g" /var/www/$your_domain/wp-config.php

# Set permissions
sudo find /var/www/$your_domain/ -type d -exec chmod 755 {} \;
sudo find /var/www/$your_domain/ -type f -exec chmod 644 {} \;
sudo chown -R www-data:www-data /var/www/$your_domain/

