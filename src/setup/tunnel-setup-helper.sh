#!/bin/bash

if [ "$EUID" -e 0 ]; then
    echo "ERROR: tunnel-setup-helper.sh should not be run as root"
    exit 1
fi

# Parameters:
#     $1 : the server ip address

# generate public/private keys on node
ssh-keygen -t rsa -q -f "~/.ssh/id_rsa" -N ""

# Add the server ip to the list of known hosts on node
if [ -z "$(ssh-keygen -F $1)" ]; then
    ssh-keyscan -H $1 >> ~/.ssh/known_hosts
fi

# share the node's public key with the server and server's public key with the node so that they can ssh without password authentication
cat ~/.ssh/id_rsa.pub | ssh lasso-node@$1 'cat >> ~/.ssh/authorized_keys; cat ~/.ssh/id_rsa.pub' | cat >> ~/.ssh/authorized_keys

# enable built-in autossh logfile
echo >> ~/.bashrc
echo "export AUTOSSH_LOGFILE=\"\$HOME/autossh.log\"" >> ~/.bashrc

# add a cron job to create a reverse ssh tunnel from the node to the server on startup
{ crontab -l; echo "*/1 * * * * ${SRC}/remote/auto-ssh.sh $1 > ${SRC}/../tunnel.log 2>&1"; } | crontab -