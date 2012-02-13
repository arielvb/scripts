#!/bin/bash
#######################################################################
# Jenkins.sh - Turns on/off jenkins
# arielvb - http://www.arielvb.com
# version: 1.0
# Usage: jenkins.sh [on|off]
# Changelog:
#	1.0 first version
#######################################################################
CURRENT=`sudo launchctl list | grep jenkins`;
if [[ $BASH_ARGC < 0 ]]; then
	if [[ $CURRENT ]]; then
		echo 'Status: on'
	else
		echo 'Status: off'
	fi
	exit
fi
if [[ ($1 == 'on') && ($CURRENT == "") ]]; then
	sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist
	echo 'Jenkins on'
elif [[ ($1 == 'off') && ($CURRENT) ]]; then
	sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist
	echo 'Jenkins off'
fi

