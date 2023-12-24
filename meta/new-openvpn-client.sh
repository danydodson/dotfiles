#! /bin/bash

# Script to automate creating new OpenVPN clients
# The client cert and key, along with the CA cert is
# zipped up and placed somewhere to download securely

# Usage: new-openvpn-client.sh <common-name>

# Set where we're working from
OPENVPN_RSA_DIR=/etc/openvpn/easy-rsa/2.0
OPENVPN_KEYS=$OPENVPN_RSA_DIR/keys
KEY_DOWNLOAD_PATH=/var/www/secure

# Either read the CN from $1 or prompt for it
if [ -z "$1" ]; then
  echo -n "Enter new client common name (CN): "
  read -r -e CN
else
  CN=$1
fi

# Ensure CN isn't blank
if [ -z "$CN" ]; then
  echo "You must provide a CN."
  exit
fi

# Check the CN doesn't already exist
if [ -f $OPENVPN_KEYS/"$CN".crt ]; then
  echo "Error: certificate with the CN $CN alread exists!"
  echo "    $OPENVPN_KEYS/$CN.crt"
  exit
fi

# Enter the easy-rsa directory and establish the default variables
cd $OPENVPN_RSA_DIR || return
# shellcheck disable=SC1091
source ./vars >/dev/null

# Copied from build-key script (to ensure it works!)
export EASY_RSA="${EASY_RSA:-.}"
"$EASY_RSA/pkitool" --batch "$CN"

# Take the new cert and place it somewhere it can be downloaded securely
zip -q $KEY_DOWNLOAD_PATH/"$CN"-"$(date +%d%m%y)".zip keys/"$CN".crt keys/"$CN".key keys/ca.crt

# Celebrate!
echo ""
echo "#############################################################"
echo "COMPLETE! Download the new certificate here:"
echo "https://domain.com/secure/$CN-$(date +%d%m%y).zip"
echo "#############################################################"
