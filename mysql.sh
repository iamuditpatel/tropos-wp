#!/bin/bash



#***************MYSQL INSTALLATION***************
sudo apt-get -y install mysql-server

#mysql secure installation - sudo mysql_secure_installation
sudo mysql -u root << EOF
UPDATE mysql.user SET authentication_string ='$rootpass', WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF

#sed command to add default_authentication_plugin
sudo sed -i '28 a default_authentication_plugin= mysql_native_password' /etc/mysql/mysql.conf.d/mysqld.cnf

#To start, enable and check the status of Mysql
sudo systemctl start mysql
sudo systemctl enable mysql
