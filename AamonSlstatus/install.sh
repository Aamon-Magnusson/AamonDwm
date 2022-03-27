#! /bin/bash

wired=$(ip a | grep "BROADCAST" | awk -F: '{print $2}' | grep 'en' | awk 'NR==1{print $1}')
wireless=$(ip a | grep "BROADCAST" | awk -F: '{print $2}' | grep 'wl' | awk 'NR==1{print $1}')

echo -e $wired
echo -e $wireless

sed -i "s/wlp4s0/$wireless/g" config.h
sed -i "s/eno1/$wired/g" config.h

sudo make -s install clean

sed -i "s/$wireless/wlp4s0/g" config.h
sed -i "s/$wired/eno1/g" config.h
