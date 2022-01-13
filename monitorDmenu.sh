#! /bin/bash

options="Laptop Only\nHDMI Only\nVGA Only\nType C Only\nHDMI and Laptop\nVGA and Laptop\nType C and Laptop\nManual Config"

choice=$(echo -e "$options" | dmenu -i)

case "$choice" in
		"Laptop Only") xrandr --output eDP-1 --auto --output HDMI-2 --off --output HDMI-1 --off --output DP-1i --off;;
		"HDMI Only") xrandr --output eDP-1 --off --output HDMI-2 --off --output HDMI-1 --auto --output DP-1 --off;;
		"VGA Only") xrandr --output eDP-1 --off --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --auto;;
		"Type C Only") xrandr --output eDP-1 --off --output HDMI-2 --auto --output HDMI-1 --off --output DP-1 --off;;
		"HDMI and Laptop") xrandr --output eDP-1 --auto --output HDMI-2 --off --output HDMI-1 --auto --output DP-1 --off && arandr &;;
		"VGA and Laptop") xrandr --output eDP-1 --auto --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --auto && arandr &;;
		"Type C and Laptop") xrandr --output eDP-1 --auto --output HDMI-2 --auto --output HDMI-1 --off --output DP-1 --off && arandr &;;
		"Manual Config") arandr &;;
esac

feh --bg-fill --randomize ~/Desktop/Backgrounds/* &
