#!/bin/bash
createTunnel() {
	autossh -M 10984 -N -f -o "PubkeyAuthentication=yes" -o "PasswordAuthentication=no" -i /home/pi/.ssh/id_rsa -R 6666:localhost lasso-node@lasso.rit.edu -p 22 &
	if [[ $? -eq 0 ]]; then
		echo Tunnel to Server created successfully
	else
		echo An error occured creating a tunnel to server. RC was $?
	fi
}
/usr/bin/pidof ssh
if [[ $? -ne 0 ]]; then
	echo Creating a new tunnel connection
	createTunnel
fi