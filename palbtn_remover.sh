#!/bin/bash
#########################################
# palbtn_remover
# --------------
# Removes all the _PALbtN directoriess, this are created by Nokia phones
#  in your Camera folders
# --------------
# Author: Ariel
# License: Public Domain
#########################################  
echo -n "This action will remove all _PALbTN directories [y,N]: "
read temp_var
if [[ $temp_var == 'y' ]]; then
  find . \( -type d -and -name _PAlbTN*  -exec rm -r {\} \; \)
  echo 'Done'
else
 echo 'Aborted'
fi
