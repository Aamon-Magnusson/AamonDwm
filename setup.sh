#! /bin/bash

if [ ! $(which dmenu) ];then
	printf "dmenu is not installed, do that first"
	exit 0
fi

working_dir=$( echo -e "/home/aamonm/Programming/AamonDwm" | dmenu -p "What is the current dir?" )

sudo make -s install

sudo cp $working_dir/CopyFiles/dwm.desktop /usr/share/xsessions/
mkdir -p $HOME/.dwm
cp $working_dir/CopyFiles/autostart.sh $HOME/.dwm/
mkdir -p $HOME/.config/dunst
cp $working_dir/CopyFiles/dunstrc $HOME/.config/dunst
cp $working_dir/CopyFiles/AamonGTK3 $HOME/.themes/ -r
cp $working_dir/CopyFiles/AamonIcons $HOME/.icons/ -r
cp $working_dir/Backgrounds $HOME/Desktop/ -r
sudo cp $working_dir/AamonDwmScripts /usr/ -r

choices="Show me keybindings\nTake me to the menu\nQuit"

action=$( echo -e $choices | dmenu -p "Welcome to AamonDwm" )

case $action in
	"Show me keybindings") $working_dir/dmenu-keybindings ;;
	"Take me to the menu") $working_dir/menu-dmenu ;;
esac
