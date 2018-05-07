#!/bin/bash

echo "Enter the www domain name: \c "
read domain

if [ -f /etc/nginx/site-avaible/${domain}.conf ]; then
    echo 'File exists!'
    exit
fi

if [ -z $domain ]; then
    echo 'Domain name empty!'
    exit
fi

echo "Enter username: \c "
read username

if [ -z $username ]; then
    echo 'Username empty!'
    exit
fi

grep "${username}:" /etc/passwd >/dev/null
if [ $? -ne 0 ]; then
    echo ${username}' is not found!'
    exit
fi

dirname=/var/www/${username}/data/www/${domain}

if [ -d $dirname ]; then
    echo 'Dir '$dirname' exists!'
else
    mkdir $dirname
    mkdir $dirname/public
 
    echo $dirname ' add!'
fi

touch /etc/nginx/site-avaible/${domain}.conf

echo '
server {
    server_name www.'${domain}';
    return 301 $scheme://'${domain}'$request_uri;
}

server {
    index index.php index.html;
    server_name '${domain}';
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/'${username}'/data/www/'${domain}'/public;
    
    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        include fastcgi.conf;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
    
    location ~* \.(jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc|svg|woff|woff2|ttf)$ {
        expires 1M;
        access_log off;
        add_header Cache-Control "public";
    }
    
    location ~* \.(?:css|js)\$ {
      expires 7d;
      access_log off;
      add_header Cache-Control "public";
    }
    
    location ~ /\. {
        deny all; # запрет для скрытых файлов
    }
    
    location ~ /\.ht {
        deny  all;
    }
    
}' >> /etc/nginx/site-avaible/${domain}.conf

touch index.html
echo '
<!DOCTYPE html>
    <html lang="ru">

    <head>
        <meta charset="UTF-8" />
        <title>
            '${domain}'
        </title>
    </head>
    <body>
        <h1> <center> '${domain}' super domain! </center></h1>
    </body>
    </html>
' >> $dirname/public/index.html

sudo chmod -R 755 $dirname
sudo chown -R ${username}:${username} $dirname


echo "Enabled ${domain} ? (Y/[a]): \c "
read yn
if [ $yn = "y" -o $yn = "Y" ]; then
    ln -s /etc/nginx/site-avaible/${domain}.conf /etc/nginx/conf.d/${domain}.conf
    echo ${domain} 'was enabled.'
fi

docker restart nginx-proxy

echo 'Compelete!'
exit 0