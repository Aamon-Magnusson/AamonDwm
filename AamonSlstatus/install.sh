#! /bin/bash

wired=$(ip a | grep "BROADCAST" | awk -F: '{print $2}' | grep 'en' | awk 'NR==1{print $1}')
wireless=$(ip a | grep "BROADCAST" | awk -F: '{print $2}' | grep 'wl' | awk 'NR==1{print $1}')
bat=$(ls /sys/class/power_supply | grep "BAT*" )
res=$(xrandr | grep "*" | awk '{print $1}' | awk -Fx '{print $2}')

#echo -e $wired
#echo -e $wireless

if [ $(expr $res) -lt 1000 ];then
	mv config.h large.h
	mv small.h config.h
fi

sed -i "s/wlp4s0/$wireless/g" config.h
sed -i "s/eno1/$wired/g" config.h
sed -i "s/BAT0/$bat/g" config.h

sudo make -s install clean
if [ -z $1 ];then
	killall slstatus
	slstatus &
fi

sed -i "s/$wireless/wlp4s0/g" config.h
sed -i "s/$wired/eno1/g" config.h
sed -i "s/$bat/BAT0/g" config.h

if [ $(expr $res) -lt 1000 ];then
	mv config.h small.h
	mv large.h config.h
fi
