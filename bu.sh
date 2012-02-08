#!/bin/bash
#######################################################################
# bu.sh B(ack)U(p)
# arielvb - http://www.arielvb.com
# Simple backup comand line tool for files/folders on any *nix
# version: 0.1
# Changelog:
#	0.1 first version
#######################################################################
#######################################################################
# Config
#######################################################################
BUDIR="$HOME/backups/"			# Backup dir
BUHISTORY=$BUDIR".bu_history"	# history file
USAGE="Usage: bu [-t] [file|dir]";
USAGET="Usage: bu -t file|dir";
#######################################################################
# end Config
#######################################################################
if [[ $BASH_ARGC < 0 ]]; then
	echo 'B(ack)U(p) History'
	echo '__________________'
	cat $BUHISTORY;
	echo '__________________'
	exit;
fi

isfile=1;
isdir=1;
utar=0;
FILE=$1
if [[ $1 ==  '-t' ]]; then 
	# tar enabled
	if [[ $BASH_ARGC < 2 ]]; then
		echo $USAGET; 
		exit;
	fi
	utar=1;
	
	FILE=$2
fi
######################
# File check
######################
dir=`dirname $FILE`;
base=`basename $FILE`;
cd $dir;
FILE=`pwd`/$base; # absolute route 

test -f "$FILE"; # Check if is file
if [[ $? == 1 ]]; then 
	isfile=0;
fi
test -d "$FILE"; # Check if is dir
if [[ $? == 1 ]]; then 
	isdir=0;
fi
if [[ ($isfile == 0) && ($isdir == 0) ]]; then
	echo "Error: directory or file required"
	exit;
fi
firstchar=`echo $base | cut -c1`;
if [[ $firstchar == '.' ]]; then
	NEW=`echo $base | cut -c2-`
else
	NEW=$base;
fi
###################
# BACKUP
###################
DATE=`date "+%Y_%m_%d_%H_%M_%S"`

	if [[ $utar == 1 ]]; then
		# use tar
		tar -cf $BUDIR$NEW.$DATE.tar.bu "$FILE"
	elif [[ $isdir == 1 ]]; then
			cp -r $FILE $BUDIR$NEW.$DATE.bu
	else
		cp $FILE "$BUDIR$NEW.$DATE.bu"	
	fi

if [[ $? == 0 ]]; then
	printf "$NEW\t$FILE\t$DATE\n" >> $BUHISTORY
fi
