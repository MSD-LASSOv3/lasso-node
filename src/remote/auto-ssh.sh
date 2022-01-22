#!/bin/bash
IP=lasso.rit.edu

createTunnel() {
	autossh -M 10984 -N -f -o "PubkeyAuthentication=yes" -o "PasswordAuthentication=no" -i /home/pi/.ssh/id_rsa -R $1:localhost:22 lasso-node@$IP -p 22 &
	if [[ $? -eq 0 ]]; then
		if [[ -n $(ssh lasso-node@$IP "netstat -l | grep $1") ]]; then
			echo "SUCCESS"
		else
			echo "WARNING: unable to verify connection"
		fi
	else
		echo "FAILURE: RC was $?"
	fi
}

echo -n "[$(date +%F) $(date +%T)] "
id=$(pidof sshd)
if [[ -n $id ]]; then
	echo -n "Creating a new tunnel connection using port $1... "
	createTunnel $1
else
	echo "ERROR: SSH not running. Unable to make tunnel."
fi