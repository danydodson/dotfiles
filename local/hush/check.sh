#!/bin/bash

# Apache stray processes

APACHE="$(ps aux | grep -i apache | grep -v www-data | grep -v root | grep -v grep | awk '{printf("%s/%s\n",$1,$2)}')"
for LINE in $APACHE; do
	echo "Apache: ${LINE}"
done

# Sendmail stray processes

SENDMAIL="$(ps aux | grep -i sendmail | grep -v root | grep -v grep | awk '{printf("%s/%s\n",$1,$2)}')"
for LINE in $SENDMAIL; do
	echo "Sendmail: ${LINE}"
done

# SHOUTcast servers

SHOUTCAST="$(ps aux | grep -i sc_serv | grep -v root | grep -v grep | awk '{printf("%s/%s\n",$1,$2)}')"
for LINE in $SHOUTCAST; do
	echo "SHOUTcast: ${LINE}"
done

# Half-life / CS servers

HALFLIFE="$(ps aux | grep -i hlds | grep -v root | grep -v grep | awk '{printf("%s/%s\n",$1,$2)}')"
for LINE in $HALFLIFE; do
	echo "Half-life: ${LINE}"
done
