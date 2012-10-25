#!/bin/bash
############################################################################
# vboxless
# --------
# Usage:
#
#   vbox  [--no-ui|-n] [image]
#
#   --no-ui | -n    start in headless mode
#   image           name of the image to start
#
# Starts a VirtualBox image, if the image parameter *image*, is
#  not set tries to use th VIMAGE env variable.
#
# You can set the env variable $VIMAGE before calling this script with:
#
#   export VIMAGE="your value"
#
# Or unset it with:
#
#   unset $VIMAGE
# If isn't defined $VIMAGE and no the image parameter is null or empty
#  uses the DEFAULT variable of this script, customize this value to your
#  prefered virtual machine.
#
# COPYRIGHT
# ---------
# Author: Ariel https://github.com/arielvb
# Public Domain
#
############################################################################

DEFAULT="ubuntu_12.04"
ARGS="" #virtualbox args, default is empty

# The ui param options
if [[ ( "$1" == '--no-ui' ) || ( "$1" = "-n" ) ]]; then
    ARGS="$ARGS --type headless"
    shift
fi

# Detect the image, env or default
VIMAGE=${VIMAGE:=$DEFAULT}

#  or if the user has set the image parameter
if [ -n "${1:+x}" ]; then
    VIMAGE=$1
fi

# Call to VBoxManage
VBoxManage startvm "$VIMAGE" $ARGS

