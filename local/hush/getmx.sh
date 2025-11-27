#!/bin/bash

# Script to retrieve the primary mailserver for a given e-mail address.

# Usage: sh getmx.sh some-user@mail.com

DOMAIN=$(echo $1 | cut -f 2 -d "@")
RESULT=$(dig +short -t MX $DOMAIN | sort -n | head -n1 | awk '{print $2}' | sed 's/\(.*\)./\1/')

echo "${RESULT}"
