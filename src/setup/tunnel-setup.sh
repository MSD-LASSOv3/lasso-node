#!/bin/bash

systemctl enable ssh
systemctl start ssh

sudo -u pi ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
sudo -u pi cat ~/.ssh/id_rsa.pub | ssh lasso-node@lasso.rit.edu 'cat >> ~/.ssh/authorized_keys'

sudo -u pi { crontab -l -u pi; echo "*/1 * * * * \"$LASSO/src/remote/auto-ssh.sh $1\" > $LASSO/tunnel.log 2>&1"; } | crontab -u pi -
