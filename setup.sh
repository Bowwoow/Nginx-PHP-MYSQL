#!/bin/bash

#sudo groupadd nossh

cp -r ./dirs/etc/* /etc

cp -r ./dirs/root/* /root

mkdir /home/docker/

cp docker-compose.yml /home/docker