#! /bin/bash

working_dir="$HOME/Programming/AamonDwm"

sudo make install

sudo cp $working_dir/CopyFiles/dwm.desktop /usr/share/xsessions/
mkdir -p $HOME/.dwm
cp $working_dir/CopyFiles/autostart.sh $HOME/.dwm/
mkdir -p $HOME/.config/dunst
cp $working_dir/CopyFiles/dunstrc $HOME/.config/dunst
cp $working_dir/CopyFiles/AamonGTK3 $HOME/.themes/ -r
cp $working_dir/CopyFiles/AamonIcons $HOME/.icons/ -r
cp $working_dir/Backgrounds $HOME/Desktop/ -r

choices="Show me keybindings\nTake me to the menu\nQuit"

action=$( echo -e $choices | dmenu -p "Welcome to AamonDwm" )

case $action in
	"Show me keybindings") $working_dir/dmenu-keybindings ;;
	"Take me to the menu") $working_dir/menu-dmenu ;;
esac
