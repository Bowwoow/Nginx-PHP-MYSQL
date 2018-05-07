#!/bin/bash

echo "Delete username: \c "
read username

passwd --lock $username

killall -9 -u $username

deluser --remove-home $username

rm -R /var/www/$username

echo "Complete!"
