#!/bin/bash

echo "Enter the www domain name: \c "
read domain


if [ -z $domain ]; then
    echo 'Domain name empty!'
    exit
fi

if [ -f /etc/nginx/conf.d/${domain}.conf ]; then
    rm -R /etc/nginx/conf.d/${domain}.conf
    
fi

docker restart nginx-proxy

echo 'Domain name '${domain}' was avaibled!'
exit 0