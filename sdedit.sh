#!/bin/bash
################################
# Launcher for sdedit
###############################

SDEDIT=sdedit-3.1.jar
JAVA="java -jar"
PARAMS="*.sdx"

if [[ $BASH_ARGC == 1 ]]; then
    PARAMS=$1
fi

# Run sdedit
$JAVA $SDEDIT $PARAMS
