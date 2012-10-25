#!/bin/bash
#######################################################################
# wifi.sh
# arielvb - http://www.arielvb.com
# Enable or Disable Airport (Macbook's Wifi)
# version: 0.1
# Usage: wifi [on|off]
# Changelog:
#	0.1 first version
#######################################################################
CURRENT=`networksetup -getairportpower Airport | grep On`;
if [[ $BASH_ARGC < 0 ]]; then
	if [[ $CURRENT ]]; then
		echo 'Status: on'
	else
		echo 'Status: off'
	fi
	exit
fi
if [[ ($1 == 'on') && ($CURRENT == "") ]]; then
	networksetup -setairportpower Airport on
	echo 'Wifi on'
elif [[ ($1 == 'off') && ($CURRENT) ]]; then
	networksetup -setairportpower Airport off
	echo 'Wifi off'
elif [[ ($1 == 'reset') ]]; then
	networksetup -setairportpower Airport off
        networksetup -setairportpower Airport on
	echo 'Wifi reset'
fi
