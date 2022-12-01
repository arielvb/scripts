#!/bin/bash
# muuu.sh (Mac OS)
# ================
# cowsay and say together in an infinite loop.

function VACA() { local a; while True; read a; do if [ ! -z $a ]; then say $a & cowsay $a; wait; fi; done }

VACA
