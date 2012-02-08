#!/bin/bash
#######################################################################
# dashboard.sh
# arielvb - http://www.arielvb.com
# Enables or disables MacOS X Dashboard
# version: 0.2
# Usage: dashboard [on|off]
# Changelog:
#	0.1 first version
#	0.2 On/off style
#######################################################################
dashboardwriter(){
	defaults write com.apple.dashboard mcx-disabled -boolean $1
	killall Dock
}
CURRENT=`defaults read com.apple.dashboard mcx-disabled`;
if [[ $BASH_ARGC < 0 ]]; then
	if [[ $CURRENT == '1' ]]; then
		echo 'off'
	else
		echo 'on'
	fi
	exit
fi
if [[ ($1 == 'on') && ($CURRENT == '1')]]; then
	dashboardwriter NO
	echo 'Dashboard activado'
elif [[ ($1 == 'off') && ($CURRENT == '0')]]; then
	dashboardwriter YES
	echo 'Dashboard desactivado'
fi
