#!/bin/bash
#######################################################################
# ofirefox - Opens a uri with firefox (only Mac)
# arielvb - http://www.arielvb.com
# version: 0.1
#######################################################################

#################
# Config
#################
BROWSER='firefox' # Your favorite browser program
#################
# End Config
#################
echo $1
if [ -f $1 ]; then # Check if file exists
	open -a $BROWSER "$1"
else
	echo "File not found"
	exit
fi

