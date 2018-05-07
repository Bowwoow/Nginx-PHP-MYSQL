#!/bin/bash

echo "Enter user name: \c "
read username

while true; do
    echo "SSH access? Y/N: \c "
    read yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) group=nossh; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

sudo useradd -G $group -s /bin/bash -m -b /var/www $username

sudo mkdir /var/www/$username/data/
sudo mkdir /var/www/$username/data/www/

sudo chown root:$username /var/www/$username
sudo chown $username:$username /var/www/$username/data
sudo chown $username:$username /var/www/$username/data/www

sudo chmod 751 /var/www/$username
sudo chmod 751 /var/www/$username/data
sudo chmod 751 /var/www/$username/data/www

sudo passwd $username
