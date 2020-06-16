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
DEVICENAME=en0
CURRENT=`networksetup -getairportpower $DEVICENAME | grep On`;
if [[ $BASH_ARGC < 0 ]]; then
	if [[ $CURRENT ]]; then
		echo 'Status: on'
	else
		echo 'Status: off'
	fi
	exit
fi
if [[ ($1 == 'on') && ($CURRENT == "") ]]; then
	networksetup -setairportpower $DEVICENAME on
	echo 'Wifi on'
elif [[ ($1 == 'off') && ($CURRENT) ]]; then
	networksetup -setairportpower $DEVICENAME off
	echo 'Wifi off'
elif [[ ($1 == 'reset') ]]; then
	networksetup -setairportpower $DEVICENAME off
        networksetup -setairportpower $DEVICENAME on
	echo 'Wifi reset'
fi
