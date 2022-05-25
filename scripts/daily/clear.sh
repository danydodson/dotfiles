#!/bin/bash

# Keeps home folder clean

date

dir=/Users/Dany

cd $dir || exit

sudo rm -rfv $dir/.Trash 2>&1
sudo rm -rfv $dir/.wakatime 2>&1
sudo rm -rfv $dir/.wakatime-internal.cfg 2>&1
sudo rm -rfv $dir/.yarnrc 2>&1
sudo rm -rfv $dir/Music 2>&1
sudo rm -rfv $dir/Movies 2>&1
sudo rm -rfv $dir/Music 2>&1
sudo rm -rfv $dir/Pictures 2>&1
