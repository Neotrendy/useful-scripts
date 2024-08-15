#!/bin/bash

# Ask the user for the PHP version
read -p "Enter the PHP version you want to check (e.g., 7.4, 8.0): " php_version

# Verify PHP is installed
if command -v php"$php_version" >/dev/null 2>&1; then
    echo "✓ PHP version $php_version is installed."
else
    echo "PHP version $php_version is not installed."
    echo "Exiting"
    exit 1
fi

echo "Installing PHP extensions ..."
# Based on Magento requirements
# https://experienceleague.adobe.com/en/docs/commerce-operations/installation-guide/prerequisites/php-settings

# Required PHP extension
php_extensions=("bcmath" "ctype" "curl" "dom" "fileinfo" "filter" "gd" "hash" "iconv" "intl" "json" "xml" "mbstring" "openssl" "pcre" "pdo_mysql" "soap" "sockets" "sodium" "tokenizer" "xsl" "zip" "zlib")

for php_extension in "${php_extensions[@]}"
do
    # Verify installed PHP extensions
    if php"$php_version" -m | grep -Fq "$php_extension"; then
        echo "✓ '$php_extension' is already installed."
    else
        apt install php"$php_version"-"$php_extension" -y
    fi
done

# Restart Apache service
echo "Restarting Apache service ..."
systemctl restart apache2

# Restart PHP FastCGI Process Manager (FPM) service
if systemctl list-units --full -all | grep -Fq "php$php_version-fpm.service"; then
    echo "Restarting php$php_version-fpm service ..."
    systemctl restart php"$php_version"-fpm
fi

exit 0
