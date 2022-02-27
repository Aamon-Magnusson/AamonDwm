#! /bin/bash

echo -e "\n#############################"
echo -e "######Starting installer#####"
echo -e "#############################\n"

echo -e "#############################"
echo -e "#Compiling Suckless programs#"
echo -e "#############################\n"

cd AamonDwm
sudo make -s clean install
cd ..

echo -e "DWM Compiled\n"

cd AamonDmenu
sudo make -s clean install
cd ..

echo -e "DMENU Compiled\n"

sls=$( echo -e "Yes\nNo" | dmenu -p "Would you like to install slstatus?" -i )
if [ "$sls" == "Yes" ];then
	cd AamonSlstatus
	sudo make -s clean install
	cd ..

	echo -e "SLSTATUS Compiled\n"
fi

slock=$( echo -e "Yes\nNo" | dmenu -p "Would you like to install slock?" -i )
if [ "$slock" == "Yes" ];then
	cd AamonSlock
	name=$(echo -e "aamonm\nIf your group does not match your user exit" | dmenu -p "Enter your user/group name" -l 2 )
	if [ "$name" == "If your group does not match your user exit" ] || [ "$name" == "" ];then
		echo "SLOCK skipped!!!"
		echo -e "Slock should be manually installed\n"
	else
		sed -i "s/aamonm/$name/g" config.h
		sudo make -s clean install
	fi

	cd ..
fi

echo -e "SLOCK Compiled\n"

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
		sudo pacman -S --needed - < ArchPackageListPacman.txt
	else
		echo -e "Pacman is not installed\n"
	fi
	if [ $(which yay) ];then
		yay -Sua
		yay -S - < ArchPackageListYay.txt
	else
		echo -e "Yay is not installed\n"
	fi
	echo "###############################"
	echo "#####Dependencies installed#####"
	echo -e "###############################\n"
fi

echo "##########################"
echo "######Copying files#######"
echo -e "##########################\n"

sudo cp CopyFiles/dwm.desktop /usr/share/xsessions/
mkdir -p $HOME/.dwm
cp CopyFiles/autostart.sh $HOME/.dwm/
mkdir -p $HOME/.config/dunst
cp CopyFiles/dunstrc $HOME/.config/dunst/
cp CopyFiles/AamonGTK3 $HOME/.themes/ -r
cp CopyFiles/AamonIcons $HOME/.icons/ -r
gsettings set org.gnome.desktop.interface gtk-theme "AamonGTK3"
gsettings set org.gnome.desktop.interface icon-theme "AamonIcons"
cp CopyFiles/Backgrounds $HOME/Desktop/ -r
sudo rm -r /usr/AamonDwmScripts
sudo cp Scripts /usr/AamonDwmScripts -r
mkdir -p $HOME/.weather

echo "##########################"
echo "#####Install complete#####"
echo -e "##########################\n"

choices="Show me keybindings\nTake me to the menu\nQuit"

action=$( echo -e $choices | dmenu -p "Welcome to AamonDwm" )

case $action in
	"Show me keybindings") /usr/AamonDwmScripts/dmenu-keybindings & ;;
	"Take me to the menu") /usr/AamonDwmScripts/menu-dmenu & ;;
esac
