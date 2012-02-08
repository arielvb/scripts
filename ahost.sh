#!/bin/bash
#######################################################################
# ahost.sh B(ack)U(p)
# arielvb - http://www.arielvb.com
# Creates a new Apache virtualhost and a host entry
# version: 0.1
# Changelog:
#	0.1 first version
#	0.2 Clean virtualhost declaration and add allow override
#######################################################################
###########################
# CONFIG
###########################
# String messages
USAGE="Usage: ahost subdomain path"
PERMISION="Root is needed"
# CONFIG VARS
VHOSTFILE="/etc/apache2/extra/httpd-vhosts.conf"
HOSTSFILE="/etc/hosts"
# PARAMETERS
SERVERNAME=$1
DOCUMENTROOT=$2

###########################
# CHECK CALL
###########################
if [[ $BASH_ARGC < 2 ]]; then
	echo $USAGE
	exit;
fi
if [[ $UID != 0 ]]; then 
	echo $PERMISION
	exit;
fi
#TODO will be better do something like realpath(3)
if [[ $DOCUMENTROOT == './' || $DOCUMENTROOT == '.' ]]; then
	DOCUMENTROOT=`pwd`
	DOCUMENTROOT=$DOCUMENTROOT"/"
fi

# Modifying hosts file
echo "Adding server $SERVERNAME to hosts"
echo "127.0.0.1 $SERVERNAME" >> $HOSTSFILE

# Modifying virtualhost file
echo "Generating virtualhost config: $SERVERNAME"
echo "###################################
# virtualhost generated with avhost
###################################

<VirtualHost *:80>
	ServerName $SERVERNAME
	DocumentRoot \"$DOCUMENTROOT\"
	<Directory \"$DOCUMENTROOT\">
		AllowOverride All
		Allow from All
	</Directory>
</VirtualHost>

###################################
# end virtualhost
###################################
" >> $VHOSTFILE

# Restarting apache
echo -n "Restarting apache..."
apachectl graceful
echo "done"