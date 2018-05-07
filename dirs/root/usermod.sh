#!/bin/bash

echo "Enter user name: \c "
read username

while true; do
    echo "SSH access? Y/N: \c "
    read yn
    case $yn in
        [Yy]* ) group=$username; break;;
        [Nn]* ) group=nossh; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

sudo usermod -G $group $username

groups $username
exit 0
