#!/bin/bash
##################################
# Export sdedit files (sdx) to png
##################################

SDEDIT=sdedit-3.1.jar
mkdir -p png
for i in `ls *.sdx`; do
	out=`basename -s .sdx "$i"`
	java -jar "$SDEDIT" --font Courier -t png -o "png/$out.png" $i &
done

wait
