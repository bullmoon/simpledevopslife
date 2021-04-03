#!/bin/bash

intname="System eth0"
gateway="10.97.85.1"
dns="8.8.8.8"
declare -A WORKHOSTS
WORKHOSTS=( \
	[ansible]=10.97.85.120/24 \
	[nginx]=10.97.85.36/24 \
	[jenkins]=10.97.85.110/24 \
	[lab-db]=10.97.85.122/24 \
	[lab-db-test]=10.97.85.121/24 \
	[lab-www-prod]=10.97.85.115/24 \
	[lab-www-stage]=10.97.85.111/24 \
	[lab-www-test]=10.97.85.112/24 \
	[minecraft]=10.97.85.62/24 \
	[ns]=10.97.85.100/24 )

echo ${#WORKHOSTS[@]} "containers are available"; echo -----

echo "List of containers: ${!WORKHOSTS[@]}"; echo -----

for K in "${!WORKHOSTS[@]}"
do
 echo $K --- ${WORKHOSTS[$K]}

lxc exec $K -- nmcli con mod "System eth0" ipv4.addresses ${WORKHOSTS[$K]};\
lxc exec $K -- nmcli con mod "System eth0" ipv4.gateway $gateway;\
lxc exec $K -- nmcli con mod "System eth0" ipv4.method manual;\
lxc exec $K -- nmcli con mod "System eth0" ipv4.dns $dns;\
lxc exec $K -- nmcli con up "System eth0"
done

