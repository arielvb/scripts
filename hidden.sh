#!/bin/bash
#######################################################################
# hidden.sh
# arielvb - http://www.arielvb.com
# Shows or hiddes hidden files on MacOS X Finder 
# Version: 0.2
# Usage: hidden [on|off]
# Changelog:
#	0.1 first version
#	0.2 On/off style
#######################################################################
hiddenwriter(){
	defaults write com.apple.finder AppleShowAllFiles $1
	killall Finder
}
CURRENT=`defaults read com.apple.finder AppleShowAllFiles`;
if [[ $BASH_ARGC < 0 ]]; then
	if [[ $CURRENT == '1' ]]; then
		echo 'off'
	else
		echo 'on'
	fi
	exit
fi
if [[ ($1 == 'off') && ($CURRENT == 'FALSE')]]; then
	hiddenwriter TRUE
	echo 'Hidden files are now visible'
elif [[ ($1 == 'on') && ($CURRENT == 'TRUE')]]; then
	hiddenwriter FALSE
	echo 'Hidden files not visible'
fi
