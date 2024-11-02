#!/bin/bash

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
