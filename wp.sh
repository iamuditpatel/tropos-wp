#!/bin/bash


#***************WORDPRESS INSTALLATION***************
#Change the directory
cd /var/www/

#Download the latest version of Wordpress
sudo curl -O https://wordpress.org/latest.tar.gz

#Extract the downloaded file of Wordpress
sudo tar xzvf latest.tar.gz

#SetUp the Permission
chown -R www-data:www-data /var/www/wordpress/

#Database Creation
sudo mysql -u root -p '$rootpass' -Bse 'Show databases; 
CREATE DATABASE '$dbname'; 
Show databases; 
CREATE USER '$dbuser'@'localhost' IDENTIFIED WITH mysql_native_password BY '$dbpass'; 
GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;'

#Changing Directory
cd /var/www/wordpress

#Changing in Config File
sudo mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

    	sudo perl -pi -e "s/database_name_here/$dbname/g" /var/www/wordpress/wp-config.php
	sudo perl -pi -e "s/username_here/$dbuser/g" /var/www/wordpress/wp-config.php
	sudo perl -pi -e "s/password_here/$pass/g" /var/www/wordpress/wp-config.php
	
#Setting up Salt Keys	
SITE_PATH="/var/www/wordpress/wp-config.php"
	
fct_update_salts() {
    # Requires website name as target

    curl http://api.wordpress.org/secret-key/1.1/salt/ > ~/SALTS.txt

    var_initial_path1=`pwd`
    cd ~ #going to home directory

    # This scripts eliminates successively all SALT entries, replaces the last one by XXX as a marker, places SALTS.txt, below XXX and deletes XXX
    sudo sed -i "/SECURE_AUTH_KEY/d" $1
    sudo sed -i "/LOGGED_IN_KEY/d" $1
    sudo sed -i "/NONCE_KEY/d" $1
    sudo sed -i "/AUTH_SALT/d" $1
    sudo sed -i "/SECURE_AUTH_SALT/d" $1
    sudo sed -i "/LOGGED_IN_SALT/d" $1
    sudo sed -i "/NONCE_SALT/d" $1
    sudo sed -i "/AUTH_KEY/cXXX" $1
    sudo sed -i '/XXX/r SALTS.txt' $1
    sudo sed -i "/XXX/d" $1
    echo "SALTS REPLACED BY:"
    echo "====================="
    cat ~/SALTS.txt
    sudo rm -rf ~/SALTS.txt
    cd $var_initial_path1
}

fct_update_salts $SITE_PATH

#inserting in index.php
sudo sed -i '13 a $DB_NAME = "'$dbname'";\n $DB_HOST = "'localhost'";\n $DB_USER = "'$dbuser'";\n $DB_PASSWORD = "'$dbpass'";\n $conn = mysqli_connect($DB_NAME, $DB_HOST, $DB_USER, $DB_PASSWORD); ' /var/www/wordpress/index.php

#moving all files from wordpress to your domain folder
sudo mv /var/www/wordpress/* /var/www/$your_domain

#remove wordpress folder
sudo rm -r /var/www/wordpress

#SettingUp Permission
sudo chown -R www-data:www-data /var/www/$your_domain
sudo mkdir /var/www/$your_domain/wp-content/upgrade
sudo chmod 775 /var/www/$your_domain/wp-content/upgrade
#sudo find /var/www/$your_domain/ -type d -exec chmod 750 {} \;
#sudo find /var/www/$your_domain/ -type f -exec chmod 640 {} \;


