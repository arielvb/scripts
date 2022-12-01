#!/bin/bash
# Prints all network IP and the public IP (MACOS only)
for i in $(seq 0 $(ipconfig ifcount)); do
	echo "en$i: $(ipconfig getifaddr en$i)"
done
echo "Public IP: $(dig +short myip.opendns.com @resolver1.opendns.com)"
