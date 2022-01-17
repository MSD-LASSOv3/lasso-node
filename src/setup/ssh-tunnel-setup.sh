#!/bin/bash

# if [ "$EUID" -e 0 ]; then
#     echo "ERROR: ssh-tunnel-setup.sh cannot be run as root"
#     exit(1)
# fi

sudo -u pi ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
sudo -u pi cat ~/.ssh/id_rsa.pub | ssh lasso-node@lasso.rit.edu 'cat >> ~/.ssh/authorized_keys'

sudo -u pi { crontab -l -u pi; echo '*/1 * * * * ~/start_autossh.sh > tunnel.log 2>&1'; } | crontab -u pi -
