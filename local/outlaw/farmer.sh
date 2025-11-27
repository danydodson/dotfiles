#!/bin/bash

# Insomnia 24/7 farmer shell script.
# Call a specified URL using a list of proxies.

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    <http://www.gnu.org/licenses/>

#local RED="\033[31m"
#local GREEN="\033[32m"
#local YELLOW="\033[33m"
#local BLUE="\033[35m"
#local END="\033[0m"

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[35m"
END="\033[0m"

# Ending and Ctrl+C out
trap ctrl_c INT

ctrl_c() {
    echo -e ""
    echo -e "${YELLOW}[*]${END}\tCompleted ${BLUE}${SUC}${END} verified proxied requests"
    echo -e "${YELLOW}[*]${END}\tTried ${BLUE}${TOT}${END} proxies"
    echo -e "${YELLOW}[*]${END}\tDone."

    exit 0
}

USAGE="Insomnia 24/7 farmer\n\
\nUsage: sh `basename $0` [-hdtmo] [-p proxyfile.txt] [-u \"http://url.domain.tld/?page=hit_this_page\"]\n\
Expected proxy list format: ip.ip.ip.ip:port the rest of the line is ignored.\n\
Use UNIX file format, DOS file format causes problems.\n\n\
\tGeneric options\n\
\t-l list.txt\tProxy list (Required)\n\
\t-h\t\tPrint this help\n\
\t-o out.txt\tOutput file (Default: /dev/null) (Use -o - for STDOUT)\n\
\t-s\t\tShow count on failed requests too (Useful for unreliable lists)\n\n\
\tTiming options\n\
\t-d sec\t\tSeconds to delay after sucessful proxy (Default: 2)\n\
\t-t sec\t\tHow long to wait for a proxy to respond (Default: 5)\n\
\t-m n\t\tStop after n verified successful hits\n\n\
\tRequest options\n\
\t-u URL\t\tUrl to hit via proxy (Required)\n\
\t-r \"str\"\tSet referer\n\
\t-p \"str\"\tSet POST data\n\
\t-a \"str\"\tSet user-agent"

DELAY="2"
TOUT="5"
OUTP="/dev/null"
SUC="0"
TOT="0"
POST=""
REF=""
AGENT=""

# Parse cmdline opts
while getopts shd:l:t:p:r:u:a:o:m: OPT; do
	case "$OPT" in
		h)
			echo -e $USAGE
			exit 0
			;;
		s)	CNT="Y";;
		d)	DELAY=$OPTARG;;
		t)	TOUT=$OPTARG;;
		p)	POST=$OPTARG;;
		r)	REF=$OPTARG;;
		a)	AGENT=$OPTARG;;
		l)	PLIST=$OPTARG;;
		o)	OUTP=$OPTARG;;
		u)	URL=$OPTARG;;
		m)	MAX=$OPTARG;;
		\?)
			echo -e $USAGE >&2
			exit 1
			;;
	esac
done

if [ ! -n "$PLIST" ]; then
		echo -e $USAGE >&2
		echo -e "${RED}-l is required!${END}" >&2
		exit 1
fi

if [ ! -n "$URL" ]; then
		echo -e $USAGE >&2
		echo -e "${RED}-u is required!${END}" >&2
		exit 1
fi

# Print config
echo -e ""
echo -e "${YELLOW}[*]${END}\tUsing proxy list ${BLUE}${PLIST}${END}"
echo -e "${YELLOW}[*]${END}\tHitting url ${BLUE}${URL}${END}"
if [ -n "$POST" ]; then
	echo -e "${YELLOW}[*]${END}\tSending POST-data ${BLUE}${POST}${END}"
fi
if [ -n "$REF" ]; then
	echo -e "${YELLOW}[*]${END}\tSpoofing referer ${BLUE}${REF}${END}"
fi
if [ -n "$AGENT" ]; then
	echo -e "${YELLOW}[*]${END}\tSpoofing user-agent ${BLUE}${AGENT}${END}"
fi
echo -e "${YELLOW}[*]${END}\tOutput file ${BLUE}${OUTP}${END}"
echo -e "${YELLOW}[*]${END}\tDelay ${BLUE}${DELAY}${END} seconds after succesful attempt"
echo -e "${YELLOW}[*]${END}\tHTTP timeout ${BLUE}${TOUT}${END} seconds"
if [ -n "$MAX" ]; then
	echo -e "${YELLOW}[*]${END}\tStopping after ${BLUE}${MAX}${END} verified proxied requests"
fi
echo -e ""
echo -e "${YELLOW}[*]${END}\tStarting"
echo -e ""

#Grab first column
LIST=`cat $PLIST | awk '{print $1}'`

# Walk trough proxy list
for PROXY in $LIST
do
	# Separation, though not strictly needed under this impelementation
	IP=`echo -e $PROXY | cut -d: -f 1`
	PORT=`echo -e $PROXY | cut -d: -f 2`

	# Set proxy variable for wget
	export http_proxy="http://${IP}:${PORT}"

	# Build request string
	REQ="wget --proxy=on -q -T ${TOUT} -t 1 -O ${OUTP}"

	if [ -n "$POST" ]; then
		REQ="${REQ} --post-data=${POST}"
	fi

	if [ -n "$AGENT" ]; then
		REQ="${REQ} --user-agent=${AGENT}"
	fi

	if [ -n "$REF" ]; then
		REQ="${REQ} --referer=${REF}"
	fi

	echo -en "${YELLOW}[ ]${END}\t${IP}:${PORT}\t"

	REQ="${REQ} ${URL}"

	# Try to grab page
	if $REQ; then
		# Some record keeping
		: $((SUC = SUC + 1))

		SHOW="${YELLOW}[$SUC]${END}\t${IP}:${PORT}\t"
		if [ "${#PROXY}" -lt "16" ]; then
			SHOW="${SHOW}\t"
		fi
		SHOW="${SHOW}${GREEN}Successful${END}"
		echo -en "\r${SHOW}\n"
		# Throttle the succesful hits
		echo -ne "${YELLOW}[.]${END}\tWaiting..."
		sleep $DELAY
		echo -en "\r"
	else
		if [ -n "$CNT" ]; then
			SHOW="${YELLOW}[${SUC}]${END}\t${IP}:${PORT}\t"
			if [ "${#PROXY}" -lt "16" ]; then
				SHOW="${SHOW}\t"
			fi
			SHOW="${SHOW}${RED}Failed${END}"
		else
			SHOW="${YELLOW}[*]${END}\t${IP}:${PORT}\t"
			if [ "${#PROXY}" -lt "16" ]; then
				SHOW="${SHOW}\t"
			fi
			SHOW="${SHOW}${RED}Failed${END}"
		fi
		echo -ne "\r${SHOW}\n"
	fi

	# More record keeping
	: $((TOT = TOT + 1))

	if [ -n "$MAX" ]; then
		if [ "$SUC" -eq "$MAX" ]; then
			ctrl_c
		fi
	fi
done

ctrl_c