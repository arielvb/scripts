#!/bin/bash
#######################################################################
# hidden.sh
# Shows or hides hidden files on MacOS X Finder
# Version: 0.3
# Usage: hidden [on|off]
#     on 		to hide files
#	  off		to display hidden files.
# Changelog:
#	0.1 first version.
#	0.2 On/off style.
#	0.3 Change finder -> Finder, 0/1 -> FALSE/TRUE, improve feedback.
#######################################################################
hiddenwriter(){
	defaults write com.apple.Finder AppleShowAllFiles $1
	killall Finder
}
CURRENT=`defaults read com.apple.Finder AppleShowAllFiles`;
if [[ $BASH_ARGC < 0 ]]; then
	if [[ $CURRENT == 'FALSE' ]]; then
		echo 'on'
	else
		echo 'off'
	fi
	exit
fi
if [[ ($1 == 'off') && ($CURRENT == 'FALSE')]]; then
	hiddenwriter TRUE
	echo 'Hidden files are now visible'
elif [[ ($1 == 'on') && ($CURRENT == 'TRUE')]]; then
	hiddenwriter FALSE
	echo 'Hidden files not visible'
else
	echo "Nothing changed"
fi
