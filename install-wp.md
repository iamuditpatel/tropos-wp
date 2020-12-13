# Installation of wordpress manually step by step using putty

 - login as : root
 - Update the system

    ```sh
        apt-get update
    ```
- Upgade the system

    ```sh
        apt-get upgrade
    ```
    > then press y
    
- Apache Installation
    
     ```sh
        apt-get install apache2
    ```
     > then press y
     
- Apache start and Enable
     
    ```sh
        systemctl start apache2
        systemctl enable apache2
    ```
- To check Apache Status
     
    ```sh
        systemctl status apache2
    ```
##### Copy the IP and paste in Browser you will find Apache default Ubuntu Page

- Installation of MySQL database server
     
    ```sh
        apt-get install mysql-server
    ```
    
     > then press y
     
- Secure installation of mysql
     
    ```sh
      mysql_secure_installation
    ```
    
    > then press y
    
- Choose the password policy: 
- Enter 0 for Low , Enter 1 for Medium, Enter 2 for Strong
        -you can select password according to your choice low,medium,strong.
- select your choice Yes-y or No-n (by default you can select Yes- y 5 times) 
        according to you provide security

- Start and Enable mysql
     
    ```sh
       systemctl start mysql
       systemctl enable mysql

    ```
- find mysql file under etc folder
     
    ```sh
     cd /etc
     ls
    ```
- find mysql.conf.d file under mysql folder
     
    ```sh
     cd mysql
     ls
    ```
- Edit mysql.conf.d file
     
    ```sh
     nano mysqld.cnf
    ```
- Add in mysqld.cnf file the default authentication plugin in mysqld section
     
    ```sh
     default_authentication_plugin= mysql_native_password
    ```
- Exit the editor with CTRL+X ->Y->Enter
- Back to root
- Start and Enable mysql
  
    ```sh
      systemctl start mysql
      systemctl enable mysql
    ```
#### INSTALL PHP
- Install php using following Command
     ```sh
     sudo apt-get install python-software-properties 
    ```
    ```sh
    sudo add-apt-repository ppa:ondrej/php  
    ```
    ```sh
   sudo apt-get update 
    ```
     ```sh
   sudo apt-get install -y php7.0
    ```
     ```sh
   sudo apt-get install php7.0-mysql php7.0-curl php7.0-json php7.0-cgi php7.0-xsl
    ```
     ```sh
   apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-mbstring php7.0-gd php7.0-xml php7.0-xmlrpc php7.0-intl php7.0-soap php7.0-zip
    ```
    > then press y
- Create info.php and edit it
     ```sh
        nano /var/www/html/info.php
    ```
- Copy the content
     ```sh
         <?php
            phpinfo();
        ?>
    ```
- restart apache
     ```sh
        systemctl restart apache2
    ```

- Open the Browser copy the ip and add info.php in URL bar(like 127.90.11/info.php)
#### Ready to Install Wordpress
- Change the Directory 
     ```sh
        cd /var/www/html
    ```
- Download tar file of Wordpress
     ```sh
        wget -c http://wordpress.org/latest.tar.gz
    ```
- Unzip the tar file
     ```sh
        tar -xzvf latest.tar.gz
    ```
- setup permissions
     ```sh
        chown -R www-data:www-data /var/www/html/wordpress
    ```
- Log in Mysql and Create MySQL Database
     ```sh
        mysql –u root –p
    ```
- Enter the Mysql Password
- Create Database
     ```sh
        CREATE DATABASE wordpress_db;
    ```
- Create user 
     ```sh
        CREATE USER 'wpuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
    ```
- Grant Permission to User 
     ```sh
       GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wpuser'@'localhost' WITH GRANT OPTION;
    ```
     ```sh
       FLUSH PRIVILEGES;
    ```
     ```sh
       EXIT;
    ```
- Change the directory to wordpress: 
     ```sh
       cd wordpress
    ```
- Check the wp-config-sample.php file in directory 
- Rename it with following command
     ```sh
       mv wp-config-sample.php wp-config.php
    ```
- Edit the wp-config.php file using following command
     ```sh
       nano wp-config.php
    ```
- Replace the content with your database name, user name, password set according to during creation of mysql database;
- Now edit the index.php file using nano editor
     ```sh
       nano index.php
    ```
- Add following code to it
     ```sh
       $DB_NAME = "wordpress_db":
        $DB_HOST = "localhost";
        $DB_USER = "wpuser";
        $DB_PASSWORD = "Hackos1234@#";

        $conn = mysqli_connect($DB_NAME, $DB_HOST, $DB_USER, $DB_PASSWORD);

        if ($conn->connect_error)
        {
                die("Connection failed: " . $conn->connect_error);
        }
            echo "Connected successfully";

    ```
- Change the directory with cd to root
- restart apache mysql
      ```sh
            systemctl restart apache2
            systemctl restart mysql
    ```
     
