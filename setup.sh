#!/bin/bash

sudo groupadd nossh

cp -r ./dirs/etc/* /etc

cp -r ./dirs/root/* /root

mkdir /home/docker/

mkdir /var/www/

cp docker-compose.yml /home/docker

rm -R ../setup