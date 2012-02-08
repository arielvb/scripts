#!/bin/bash
# Overwrites a defualt theme of LibreOffice whit a Faenza Theme
# Making a back(up) of the original theme
# Based on http://www.taringa.net/posts/linux/12769036/Hacer-que-Libreoffice-use-Faenza.html

LIBRE=/Applications/LibreOffice.app/Contents/basis-link/share/config
REPLACES=images_crystal.zip

DATE=`date "+%Y_%m_%d_%H_%M_%S"`

mv $LIBRE/$REPLACES $LIBRE/$REPLACES.$DATE.back
cp images_faenza.zip $LIBRE/$REPLACES
