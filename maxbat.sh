#!/bin/bash
#######################################################################
# maxbat.sh (Max)imize(Bat)tery
# arielvb - http://www.arielvb.com
# Turns on/off aplications, services or devices
# version: 0.2
# Changelog:
#	0.1 First relase
#   0.2 Added MySQL
#       - Condition service return status changed to -ge, not == 0
#
# //TODO add dashboard
# //TODO easy way to add services, create function to add to each array
# //TODO profile management.
#######################################################################

DIC=( 'on' 'off' 'start' 'stop')  # Arg dictionary
ONOFF=0 #Define for 'on off'
STST=2  #Define for 'start stop'

# APPS to kill
# The APP must be located inside /Applications
APPS=( 'Dropbox' 'DropboxAVB' 'Google Notifier' 'CapsSee' )
# Services to stop
COMM=( 'sudo apachectl' '/usr/local/mysql/support-files/mysql.server' 'networksetup -setairportpower Airport' 'blueutil')
COMM_NAM=( 'Apache' 'MySQL' 'Airport' 'Bluetooth')
COMM_ARG=( $STST $STST $ONOFF $ONOFF)

# Process name of each service for check if are running (unused)
COMM_PRC=( 'httpd' '' '' '' )

getDicStart(){
	echo ${DIC[$1]};
}
getDicStop(){
	echo ${DIC[`expr $1 + 1`]};
}

killproces(){
	local a;
	printf "Killing $1... "
	a=`killall "$1"`
	if [[ $? == 0 ]]; then
		echo 'done'
	fi
}
startproces(){
	local a
	printf "Opening $1..."
	a=`open "/Applications/$1.app/" ` &
	if [[ $? == 0 ]]; then
		echo 'done'
	fi
}
runcmd(){
	printf "$1..."
	$2 > /dev/null
	if [[ $? -ge 0 ]]; then 
		echo 'done'
	else
		echo 'Return Code:' $?
		echo 'error'
	fi
}
############################
echo "START"
STOP=true
if [[ $BASH_ARGC > 0 ]]; then
	if [[ $1 == 'on' ]]; then
		STOP=true
	fi
	if [[ $1 == 'off' ]]; then
		STOP=false
	fi
fi
for (( i = 0 ; i < ${#APPS[@]}; i++ )) do
	if ($STOP) then
		killproces "${APPS[$i]}"
	else
		startproces "${APPS[$i]}"
		
	fi
done
for (( i = 0 ; i < ${#COMM[@]}; i++ )) do
	if ($STOP) then
		args=`getDicStop ${COMM_ARG[$i]}`
	else
		args=`getDicStart ${COMM_ARG[$i]}`
	fi
	runcmd "${COMM_NAM[$i]}" "${COMM[$i]} $args"
done
echo "END"
