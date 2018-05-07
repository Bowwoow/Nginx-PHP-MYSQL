#!/bin/bash

echo "Enter the www domain name: \c "
read domain


if [ -z $domain ]; then
    echo 'Domain name empty!'
    exit
fi

if ! [ -f /etc/nginx/site-avaible/${domain}.conf ]; then
    echo ${domain}' is not a found!'
    exit
fi

ln -s /etc/nginx/site-avaible/${domain}.conf /etc/nginx/conf.d/${domain}.conf

docker restart nginx-proxy

echo 'Domain name '${domain}' was enabled!'
exit 0