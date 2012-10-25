#!/bin/bash
# Prints de current ip v4 on mac os x
# An option is:
#  networksetup -getinfo airport | grep 'IP address:' | head -1
# the shorter:
ipconfig getifaddr en1
dig +short myip.opendns.com @resolver1.opendns.com
