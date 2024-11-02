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

# Enable the virtual host
sudo a2ensite $your_domain.conf

# Reload Apache
sudo systemctl reload apache2

# Install phpMyAdmin
sudo apt-get install -y phpmyadmin

# Create symbolic link for Apache configuration
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf

# Enable phpMyAdmin configuration in Apache
sudo a2enconf phpmyadmin.conf

# Restart Apache to apply changes
sudo systemctl restart apache2

echo "WordPress installation and virtual host setup completed successfully."
echo "Your Domain: $your_domain"
echo "MySQL Root Password: $rootpass"
echo "Database Name: $dbname"
echo "Database User Name: $dbuser"
echo "Database Password: $rootpass"
