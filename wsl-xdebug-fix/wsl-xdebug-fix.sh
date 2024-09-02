IP=$(ip route show | grep -i default | awk '{ print $3 }')

sed -i "s/xdebug.client_host=.*/xdebug.client_host=$IP/g" /etc/php/8.2/apache2/php.ini
