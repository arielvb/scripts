#!/bin/bash
# myip.sh
# =======
# Print all network IP and the public IP
#
# On Mac it will also dsisplay the network device name.


if [[ $(uname) == 'Linux' ]]; then

	ifconfig | awk '/inet / {gsub("addr:", "", $2); print $2}'
else
	#We assume we are on Mac OS

	for i in $(seq 0 $(ipconfig ifcount)); do
		echo "en$i: $(ipconfig getifaddr en$i)"
	done
fi

echo "Public IP: $(dig +short myip.opendns.com @resolver1.opendns.com)"
