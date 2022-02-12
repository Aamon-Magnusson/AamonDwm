#! /bin/bash

echo -e "\n#############################"
echo "######Starting installer#####"
echo -e "#############################\n"

if [ ! $(which dmenu) ];then
	printf "dmenu is not installed, do that first"
	exit 0
fi

working_dir=$( echo -e "/home/aamonm/Programming/AamonDwm" | dmenu -p "What is the current dir?" )
[[ "$working_dir" = "" ]] && echo "Install failed" && exit 0

sudo make -s clean install

echo "##########################"
echo "#####Compile complete#####"
echo -e "##########################\n"

choise=$( echo -e "No\nYes" | dmenu -i -p "Would you like to install all repo dependencies? (Arch only)" )

if [ $choise == "Yes" ];then
	echo "#################################"
	echo "#####Installing dependencies#####"
	echo -e "#################################\n"
	if [ $(which pacman) ]; then
		sudo pacman -Suy
		sudo pacman -S alacritty qutebrowser pcmanfm ranger xautolock flameshot discord feh picom pamixer dunst gtop xorg-xrandr arandr lxappearance bluez-utils wmctrl clipmenu
	else
		echo -e "Pacman is not installed\n"
	fi
	if [ $(which yay) ];then
		yay -Syu
		yay -S google-chrome networkmanager-dmenu-git
	else
		echo -e "Yay is not installed\n"
	fi
	echo "###############################"
	echo "#####Dependencies installed#####"
	echo -e "###############################\n"
fi

sudo cp $working_dir/CopyFiles/dwm.desktop /usr/share/xsessions/
mkdir -p $HOME/.dwm
cp $working_dir/CopyFiles/autostart.sh $HOME/.dwm/
mkdir -p $HOME/.config/dunst
cp $working_dir/CopyFiles/dunstrc $HOME/.config/dunst/
cp $working_dir/CopyFiles/AamonGTK3 $HOME/.themes/ -r
cp $working_dir/CopyFiles/AamonIcons $HOME/.icons/ -r
cp $working_dir/CopyFiles/Backgrounds $HOME/Desktop/ -r
sudo rm -r /usr/AamonDwmScripts
sudo cp $working_dir/AamonDwmScripts /usr/ -r
mkdir -p $HOME/.weather

echo "##########################"
echo "#####Install complete#####"
echo -e "##########################\n"

if [ ! $(which slock) ]; then
	echo "Remeber to install slock"
fi

if [ ! $(which slstatus) ]; then
	echo "Remember to install slstatus"
fi

choices="Show me keybindings\nTake me to the menu\nQuit"

action=$( echo -e $choices | dmenu -p "Welcome to AamonDwm" )

case $action in
	"Show me keybindings") /usr/AamonDwmScripts/dmenu-keybindings & ;;
	"Take me to the menu") /usr/AamonDwmScripts/menu-dmenu & ;;
esac
