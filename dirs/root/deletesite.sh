#!/bin/bash

echo "Enter the www domain name: \c "
read domain



if [ -z $domain ]; then
    echo 'Domain name empty!'
    exit
fi

if [ -f /etc/nginx/site-avaible/${domain}.conf ]; then
    rm -R /etc/nginx/conf.d/${domain}.conf
    rm -R /etc/nginx/site-avaible/${domain}.conf   
else
    echo 'Domain '$domain' not a found!'
    exit 0
fi

echo '\n'
echo 'Check path directory: \c'

path=$(find /var/www/ -type d -name $domain)

echo $path '\n'

echo "Delete directory $path? \nEnter (Y/[a]): \c"
read yn

if [ $yn = "y" -o $yn = "Y" ]; then
    rm -R $path
    echo $path ' was deleted.'
else
    echo $path ' is saved.'
fi

docker restart nginx-proxy

echo 'Domain name '${domain}' was deleted!'
exit 0