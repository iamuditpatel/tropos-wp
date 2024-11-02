#!/bin/bash

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
