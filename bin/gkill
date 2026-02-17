#!/bin/bash

# Uses a grep search on your process list and kills the matching pid's

# If you rename this to gkill (without the .sh), make it executable (chmod +x gkill)
# and place it in your /bin directory, you can use this as you would any other Linux command.

# Syntax:
# sh gkill.sh someapp OR gkill someapp

RESULT=$(ps auwwwx | grep -i $1 | grep -v grep | grep -v $0 | awk '{print $2}')

for PID in $RESULT; do
    kill -9 $PID
done
