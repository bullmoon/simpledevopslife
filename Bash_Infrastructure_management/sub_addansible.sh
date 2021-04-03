#!/bin/bash

# Functions
run_command()
  for container in $(lxc list volatile.last_state.power=RUNNING -c n --format csv); do
    lxc exec "$container" "$@"
  done

push_command()
   for container in $(lxc list volatile.last_state.power=RUNNING -c n --format csv); do
	   echo "push_command copy file to" $container
	   lxc file push $keyfile $container/home/ansible/.ssh/authorized_keys
	   echo "File was copied."
  done

# Variables
username="ansible"
password="0i@CB#U$"
keyfile="ssh/id_rsa.pub"

run_command -- useradd --create-home --password $password $username

# Check if ssh key file exists
if [ -f $keyfile ]; then
	push_command
else
	echo "Key file does not exist."
fi

exit 0
