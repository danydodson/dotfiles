#!/usr/bin/env bash

# Install luarocks

wget --output-document /tmp/luarocks.tar.gz https://luarocks.org/releases/luarocks-3.11.0.tar.gz

tar zxpf /tmp/luarocks.tar.gz -C /tmp

cd /tmp/luarocks-3.11.0 || exit

./configure && make && sudo make install
