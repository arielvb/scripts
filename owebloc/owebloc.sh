#!/bin/bash
#######################################################################
# owebloc.sh
# arielvb - http://www.arielvb.com
# Open .webloc files (apple's url files) on any *nix
# version: 0.3
# Required: sed, tr, grep, awk (normally they're installed by default)
# Changelog:
#	0.1 first version
#	0.2 added option -p (print only)
#	0.3 support for binary webloc
#######################################################################

#################
# Config
#################

BROWSER='firefox' # Your favorite browser program

#################
# End Config
#################

#################
# Read args and Params
################

PRINT_ONLY=0;
TOURL=0;
if [[ $1 == '-p' ]]; then
	PRINT_ONLY=1
	FILE=$2
elif [[ $1 == '-u' ]]; then
	TOURL=1;
	FILE=$2;
else
	FILE=$1
fi
isfile=`test -f "$FILE"`; # Check if file exists
if [[ $? == 1 ]]; then
	echo "File not found"
	exit
fi

# OS Detection via OSTYPE declaration, maybe a better way is using `uname -a` 
WWW="echo (error) No browser found for:"
if [[ $OSTYPE == "darwin10.0" ]]; then # MacOsX
	WWW="open -a $BROWSER"
fi
if [[ $OSTYPE == "linux-gnu" ]]; then # Linux
	WWW="$BROWSER"
fi

# Parsing uri, the uri is in the tag "string", we need to remove tabs, the start tag and the end tag
uri=`grep string "$FILE" | tr -d '\t' | sed 's/^<.*>\([^<].*\)<.*>$/\1/'`
if [[ $uri == '' ]]; then
	#try binary webloc
	uri=`strings "$FILE" | tail -1 | awk '{ print substr($1, 2, length)}'`
fi
if [[ $PRINT_ONLY == 1 ]]; then
	echo $uri
	exit;
fi
if [[ $TOURL == 1 ]]; then #to windows url file
	echo "[InternetShortcut]" >  "$FILE.url"
	echo $uri >> "$FILE.url"
	exit;
fi
# Open uri
$WWW "$uri"
