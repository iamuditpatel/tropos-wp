Certainly! Here's a step-by-step guide based on your script:

---

# Manual WordPress Installation Guide on Ubuntu

This guide will walk you through manually installing WordPress, setting up a MySQL database, configuring Apache, and installing phpMyAdmin.

---

### Prerequisites

- A VPS or server running Ubuntu
- Root or sudo access

---

### Step 1: Update System Packages

1. Update and upgrade system packages:
    ```bash
    sudo apt-get update
    sudo apt-get -y upgrade
    ```

---

### Step 2: Install Apache

1. Install Apache web server:
    ```bash
    sudo apt-get -y install apache2
    ```

---

### Step 3: Install MySQL and Secure Installation

1. Install MySQL server:
    ```bash
    sudo apt-get -y install mysql-server
    ```

2. Run MySQL secure installation and set a root password when prompted:
    ```bash
    sudo mysql_secure_installation
    ```

   Follow the prompts to configure MySQL security options.

---

### Step 4: Install PHP and Required Modules

1. Install PHP and necessary modules:
    ```bash
    sudo apt-get -y install php libapache2-mod-php php-mysql
    ```

---

### Step 5: Create Directory for Domain

1. **Replace `<your_domain>` with your actual domain.**
2. Create a directory for your domain:
    ```bash
    sudo mkdir /var/www/<your_domain>
    sudo chown -R www-data:www-data /var/www/<your_domain>
    ```

---

### Step 6: Download and Install WordPress

1. Navigate to the domain directory:
    ```bash
    cd /var/www/<your_domain>
    ```

2. Download the latest version of WordPress:
    ```bash
    sudo curl -O https://wordpress.org/latest.tar.gz
    ```

3. Extract WordPress files:
    ```bash
    sudo tar xzvf latest.tar.gz
    ```

4. Move the files to the domain root and remove the downloaded and extracted folders:
    ```bash
    sudo mv wordpress/* /var/www/<your_domain>/
    sudo rm latest.tar.gz
    sudo rm -r wordpress
    ```

---

### Step 7: Set Up MySQL Database and User

1. **Replace `<rootpass>` with your MySQL root password.**
2. Create a database and user for WordPress:
    ```bash
    dbname="wordpress_$(date +%s)"
    dbuser="wpuser_$(date +%s)"
    ```

3. Run the following MySQL commands to create a database, user, and grant privileges:
    ```bash
    sudo mysql -u root -p<rootpass> << EOF
    CREATE DATABASE $dbname;
    CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '<rootpass>';
    GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'localhost' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    EOF
    ```

---

### Step 8: Configure WordPress

1. Copy the sample WordPress config file:
    ```bash
    sudo mv /var/www/<your_domain>/wp-config-sample.php /var/www/<your_domain>/wp-config.php
    ```

2. Edit the configuration file with the database details:
    ```bash
    sudo sed -i "s/database_name_here/$dbname/g" /var/www/<your_domain>/wp-config.php
    sudo sed -i "s/username_here/$dbuser/g" /var/www/<your_domain>/wp-config.php
    sudo sed -i "s/password_here/<rootpass>/g" /var/www/<your_domain>/wp-config.php
    ```

---

### Step 9: Set Permissions

1. Set permissions for the WordPress files and directories:
    ```bash
    sudo find /var/www/<your_domain>/ -type d -exec chmod 755 {} \;
    sudo find /var/www/<your_domain>/ -type f -exec chmod 644 {} \;
    sudo chown -R www-data:www-data /var/www/<your_domain>/
    ```

---

### Step 10: Configure Apache Virtual Host

1. Create an Apache configuration file for your domain:
    ```bash
    sudo tee /etc/apache2/sites-available/<your_domain>.conf > /dev/null <<EOF
    <VirtualHost *:80>
        ServerAdmin webmaster@<your_domain>
        ServerName <your_domain>
        DocumentRoot /var/www/<your_domain>

        ErrorLog ${APACHE_LOG_DIR}/<your_domain>-error.log
        CustomLog ${APACHE_LOG_DIR}/<your_domain>-access.log combined

        <Directory /var/www/<your_domain>/>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>

    </VirtualHost>
    EOF
    ```

2. Enable the virtual host:
    ```bash
    sudo a2ensite <your_domain>.conf
    ```

3. Reload Apache to apply the changes:
    ```bash
    sudo systemctl reload apache2
    ```

---

### Step 11: Install phpMyAdmin

1. Install phpMyAdmin:
    ```bash
    sudo apt-get install -y phpmyadmin
    ```

2. Create a symbolic link for phpMyAdmin in Apache configuration:
    ```bash
    sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
    ```

3. Enable phpMyAdmin configuration in Apache:
    ```bash
    sudo a2enconf phpmyadmin.conf
    ```

4. Restart Apache to apply the changes:
    ```bash
    sudo systemctl restart apache2
    ```

---

### Final Step: Completion Message

After completing all the steps, your WordPress installation and virtual host setup should be ready!
