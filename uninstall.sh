#! /bin/bash

options="No\nYes\nRemove All"

selection=$( echo -e "$options" | dmenu -i -p "Would you like to uninstall?")
[[ "$selection" = "" || "$selection" = "No" ]] && exit 0

sudo make uninstall

sudo rm /usr/share/xsessions/dwm.desktop
sudo rm $HOME/.dwm -r
sudo rm -r /usr/AamonDwmScripts

[[ "$selection" = "Yes"]] && exit 0

sudo rm $HOME/.config/dunst -r
sudo rm $HOME/.themes/AamonGTK3 -r
sudo rm $HOME/.icons/AamonGTK3 -r
sudo rm $HOME/Desktop/Backgrounds -r
sudo rm $HOME/.weather -r
