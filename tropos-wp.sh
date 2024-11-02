#!/bin/bash

# Prompt for domain name
read -p "Enter Your Domain: " your_domain

# Prompt for MySQL root password
read -sp "Enter MySQL Root Password: " rootpass

# Update system packages
sudo apt-get update
sudo apt-get -y upgrade

# Install Apache
sudo apt-get -y install apache2

# Install MySQL and secure installation
sudo apt-get -y install mysql-server
sudo mysql_secure_installation << EOF

$rootpass
$rootpass
n
n
n
n
EOF

# Install PHP and necessary modules
sudo apt-get -y install php libapache2-mod-php php-mysql

# Create a directory for the domain
sudo mkdir /var/www/$your_domain
sudo chown -R www-data:www-data /var/www/$your_domain

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

# Configure Virtual Host
sudo tee /etc/apache2/sites-available/$your_domain.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@$your_domain
    ServerName $your_domain
    DocumentRoot /var/www/$your_domain

    ErrorLog ${APACHE_LOG_DIR}/$your_domain-error.log
    CustomLog ${APACHE_LOG_DIR}/$your_domain-access.log combined

    <Directory /var/www/$your_domain/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

</VirtualHost>
EOF

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
