#!/bin/bash
 
# Check for commandline option for CPU limit, else use default
if [ "$1" == "" ]; then
        MAX_CPU=15
else
        MAX_CPU=$1
fi
 
# Check for commandline option for time limit, else use default
if [ "$2" == "" ]; then
        MAX_TIME=5
else
        MAX_TIME=$2
fi
 
# Value to renice to
NEWNCE=15
 
# Grab process list
PSLIST=`ps -eo %cpu,pid,time,user,nice,command --sort=%cpu | awk  '{printf "%s%s%s%s%s%s\n",$1,$2,$3,$4,$5,$6}' | tail -n20 | grep -v "%CPU"`
 
# Grab user lists
USERS=`grep users:x:100: /etc/group | awk -F: '{print $4}'`
POWER=`grep power-users:x:1003: /etc/group | awk -F: '{print $4}'`
 
 
for LINE in $PSLIST
do
	# Seperate variables
        CPU=`echo $LINE | cut -d "" -f 1 | cut -d "." -f 1`
        PID=`echo $LINE | cut -d "" -f 2`
        TME=`echo $LINE | cut -d "" -f 3 | awk -F : '{ printf("%d\n", $1*60+$2+($3/60)); }'`
        USR=`echo $LINE | cut -d "" -f 4`
	NCE=`echo $LINE | cut -d "" -f 5`
	CMD=`echo $LINE | cut -d "" -f 6`
 
	# If uid reported, get username instead.
	if [[ "$USR" =~ ^[0-9]+$ ]] ; then
		USR=`grep -e ":x:${USR}:" /etc/passwd | cut -d ":" -f 1`
	fi
 
	# See if user is in the power-users group
	PUSER="no"
	for USER in `echo $POWER | grep -o -e "[^,]*"`
	do
		if [ "$USER" == "$USR" ]; then
			PUSER="yes"
		fi
	done
 
	# Not a power-user member
	if [ "$PUSER" == "no" ]; then
 
		# Ignore too if a system process
		for USER in `echo $USERS | grep -o -e "[^,]*"`
		do
 
			# Is in the normal users group
			if [ "$USER" == "$USR" ]; then
				# Check if limit CPU usage is exceeded
				if [ "$CPU" -ge "$MAX_CPU" ]; then
 
					# Check if time limit is exceeded
					if [ "$TME" -ge "$MAX_TIME" ]; then
						if [ "$NCE" -lt "$NEWNCE" ]; then
							echo "$USR : $CMD"
							renice $NEWNCE $PID
							echo ""
						fi
					fi
				fi
			fi
		done
	fi
done
 