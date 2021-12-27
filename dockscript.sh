#! /bin/bash

if xrandr | grep "HDMI-1 connected" 
then
		echo "Yes"
else
		echo "No"
fi
