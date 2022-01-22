#!/bin/bash
# Parameters:
#     $1 : IP of the centralized lasso-server
#     $2 : port to create tunnel on server


if [[ "$EUID" -eq "0" ]]; then
    echo "ERROR: tunnel-setup-helper.sh should not be run as root"
    exit 1
fi

SRC=$(dirname "$0")/..

# generate public/private keys on node
if [ ! -f "~/.ssh/id_rsa" ]; then
    ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
fi

# Add the server ip to the list of known hosts on node
if [ -z "$(ssh-keygen -F $1)" ]; then
    ssh-keyscan -H $1 >> "$HOME/.ssh/known_hosts"
fi

# share the node's public key with the server and server's public key with the node so that they can ssh without password authentication
touch ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub | ssh lasso-node@$1 'cat >> ~/.ssh/authorized_keys; cat ~/.ssh/id_rsa.pub' | cat >> ~/.ssh/authorized_keys

# enable built-in autossh logfile
if [ -n "$(printenv | grep 'AUTOSSH_LOGFILE')" ]; then
    echo >> ~/.bashrc
    echo "export AUTOSSH_LOGFILE=\"\$HOME/autossh.log\"" >> ~/.bashrc
fi

# add a cron job to create a reverse ssh tunnel from the node to the server on startup
{ crontab -l; echo "*/1 * * * * ${SRC}/remote/auto-ssh.sh $2 > ${SRC}/../tunnel.log 2>&1"; } | crontab -
