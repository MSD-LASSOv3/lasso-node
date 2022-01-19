#!/bin/bash

src=$(dirname "$0")/..

systemctl enable ssh
systemctl start ssh

# generate public/private keys on node
sudo -u pi ssh-keygen -t rsa -q -f "/home/pi/.ssh/id_rsa" -N ""

# share the node's public key with the server and server's public key with the node
sudo -u pi cat /home/pi/.ssh/id_rsa.pub | ssh lasso-node@lasso.rit.edu 'cat >> ~/.ssh/authorized_keys; cat ~/.ssh/id_rsa.pub' | cat >> /home/pi/.ssh/authorized_keys

# add a cron job to create a reverse ssh tunnel from the node to the server on startup
{ crontab -l -u pi; echo "*/1 * * * * ${src}/remote/auto-ssh.sh $1 > ${src}/../tunnel.log 2>&1"; } | crontab -u pi -
