#!/bin/bash
#######################################################################
# proxy.sh B(ack)U(p)
# arielvb - http://www.arielvb.com
# Cambia la ubicación y la configuración de subversion
# para usar los proxies de gorgs | fontrubi | Sin proxy
# -----------------------
# First version: 2010-10-5
###########################################################
#--------------------------
# ----- CONFIGURATION -----
#--------------------------
# Destination file name
FILE="servers"
# Places
DEST=("$HOME/.subversion/" "$HOME/.netbeans/6.9/config/svn/config/")
# alternatives path
ALT_PATH=$HOME/.subversion/
# alternatives names
ALT_NAMES=('auto' 'alzinar' 'gorgs')
# alternatives file name (location file name) 
ALT=('serversAutomatic' 'serversGuardiola' 'serversSebastia');
# default alternative (desactivated alternative)
DEFAULT=0;

#-------------------------------
# --- CODE - don't touch :-) ---
#-------------------------------
altnames(){
	local sep='';
	for (( i = 0 ; i < ${#ALT_NAMES[@]} ; i++ )) do
			printf "$sep${ALT_NAMES[$i]}"
		sep=' | '
	done
}
usage(){
	echo "`basename $0` -a | d [`altnames`]"
	exit -1;
}
if [[ $BASH_ARGC < 0 ]]; then
	actual=`cat ${DEST[$DEFAULT]}/$FILE | grep http-proxy-host | tail -1 | awk -F"= " '{ print $2}'`
	if [[ $actual == '' ]]; then
		echo 'Sin proxy';
	else
		echo $actual;
	fi
	exit;
fi
if [[ $1 == '-d' ]]; then
	printf 'Desactivando proxy...       '
	for (( j = 0 ; j < ${#DEST[@]}; j++ )) do
		cp -f $ALT_PATH${ALT[$DEFAULT]} ${DEST[$j]}$FILE		
	done	
	echo 'done';	
elif [[ $1 == '-a' ]]; then
	if [[ $BASH_ARGC < 2 ]]; then 
		usage
	fi 
	continue=1
	for (( i = 0 ; i < ${#ALT_NAMES[@]}  && $continue==1; i++ )) do
		if [[ ${ALT_NAMES[$i]} == $2 ]]; then
			continue=0
		fi
	done
	if [[ $continue == 0 ]]; then
		printf 'Activando proxy...       '
		for (( j = 0 ; j < ${#DEST[@]}; j++ )) do
			cp -f $ALT_PATH${ALT[$i-1]} ${DEST[$j]}$FILE		
		done
		echo 'done'
	else
		usage
	fi
else
	usage
fi
