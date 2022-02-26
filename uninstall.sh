#! /bin/bash

options="No\nYes\nRemove All"

selection=$( echo -e "$options" | dmenu -i -p "Would you like to uninstall?")
[[ "$selection" = "" || "$selection" = "No" ]] && echo "Uninstall cancelled" && exit 0

cd AamonDwm
sudo make uninstall
cd ..

sudo rm /usr/share/xsessions/dwm.desktop
sudo rm $HOME/.dwm -r
sudo rm -r /usr/AamonDwmScripts

[[ "$selection" = "Yes"]] && echo "Dwm config files removed" && exit 0

sudo rm $HOME/.config/dunst -r
sudo rm $HOME/.themes/AamonGTK3 -r
sudo rm $HOME/.icons/AamonGTK3 -r
sudo rm $HOME/Desktop/Backgrounds -r
sudo rm $HOME/.weather -r

echo "All Dwm config files removed"
