#!/bin/bash
 
# Simple shell script to keep track of the number of users that are currently tunneling. (Users with no pts attached to their ssh sessions)
# Use option -t to get the total only (useful for graphing)
 
# Total users
function total {
	ps auwwwx | grep ssh | grep -v @pts | grep -v root | wc -l
}
 
# Normal output
function normal {
	echo "User/PID"
	ps auwwwx | grep ssh | grep -v @pts | grep -v root | awk '{print $1,$2}'
 
	echo -ne "\nTotal: "
	total
}
 
 
if [ "$1" == "-t" ]; then
	total
else
	normal
fi