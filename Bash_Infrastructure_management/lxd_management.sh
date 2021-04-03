#!/bin/bash

HEIGHT=15
WIDTH=50
CHOICE_HEIGHT=4
BACKTITLE="http://www.home.lab"
TITLE="LXD management"
MENU="Choose one of the following options:"

OPTIONS=(1 "List of containers"
	 2 "Install ip for all containers"
         3 "Add Ansible user")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "List of deployed contayners"
	    lxc list
            ;;
        2)
	    echo "Changing ip-addresses according to dns-records"
            ./sub_ip.sh
            ;;
        3)
	    echo "Add ansible user to all hosts and copy ssh-key"
            ./sub_addansible.sh
            ;;
esac
