#!/bin/bash

# The desired user to run the lasso-node
USER=pi

# The IP of the centralized lasso-server
IP=lasso.rit.edu



SRC=$(dirname "$0")/..

# enable the ssh services
systemctl enable ssh
systemctl start ssh

# Run the user_setup as the desired lasso-node user
sudo -u $USER tunnel-setup-helper.sh $IP
