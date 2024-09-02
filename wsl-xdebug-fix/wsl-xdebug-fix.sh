#!/bin/bash

# Ask the user for the PHP version
read -p "Enter the PHP version you want to fix (e.g., 7.4, 8.0): " php_version

# Verify PHP is installed
if command -v php"$php_version" >/dev/null 2>&1; then
    echo "✓ PHP version $php_version is installed."
else
    echo "PHP version $php_version is not installed."
    echo "Exiting"
    exit 1
fi

# Obtain Windows IP address
IP=$(ip route show | grep -i default | awk '{ print $3 }')

# Set Windows IP address to Xdebug configurtaion
sed -i "s/xdebug.client_host=.*/xdebug.client_host=$IP/g" /etc/php/$php_version/apache2/php.ini

# Restart Apache service
echo "Restarting Apache service ..."
systemctl restart apache2

