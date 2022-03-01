#! /bin/bash

echo -e "\n#############################"
echo -e "######Starting installer#####"
echo -e "#############################\n"

suckless() {
	echo -e "#############################"
	echo -e "#Compiling Suckless programs#"
	echo -e "#############################\n"
	
	wm=$( echo -e "Yes\nNo" | dmenu -p "Would you like to install DWM?" -i )
	if [ "$sls" == "Yes" ];then
		cd AamonDwm
		sudo make -s clean install
		cd ..
	
		echo -e "DWM Compiled\n"
	fi
	
	if [ ! $(which dmenu) ];then
		sudo rm AamonDmenu -r
		git clone https://github.com/Aamon-Magnusson/AamonDmenu 
		cd AamonDmenu
		sudo make -s clean install
		cd ..
	else
		menu=$( echo -e "Yes\nNo" | dmenu -p "Would you like to install dmenu?" -i )
		if [ $menu == "Yes" ];then
			sudo rm AamonDmenu -r
			git clone https://github.com/Aamon-Magnusson/AamonDmenu 
			cd AamonDmenu
			sudo make -s clean install
			cd ..
	
			echo -e "DMENU Compiled\n"
		fi
	fi
	
	sls=$( echo -e "Yes\nNo" | dmenu -p "Would you like to install slstatus?" -i )
	if [ "$sls" == "Yes" ];then
		cd AamonSlstatus
		sudo make -s clean install
		cd ..
	
		echo -e "SLSTATUS Compiled\n"
	fi
	
	slock=$( echo -e "Yes\nNo" | dmenu -p "Would you like to install slock?" -i )
	if [ "$slock" == "Yes" ];then
		sudo rm AamonSlock -r
		git clone https://github.com/Aamon-Magnusson/AamonSlock
		cd AamonSlock
		./install.sh
	
		cd ..
	
		echo -e "SLOCK Compiled\n"
	fi
	
	echo "##########################"
	echo "#####Compile complete#####"
	echo -e "##########################\n"

}

dependencies() {
	choise=$( echo -e "Yes\nNo" | dmenu -i -p "Would you like to install all repo dependencies? (Arch only)" )
	
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
}

themes() {
	theme=$( echo -e "Yes\nNo" | dmenu -p "Would you like to change GTK theme?" -i )
	if [ $theme == "Yes" ];then
		echo "##########################"
		echo "#########Theming##########"
		echo -e "##########################\n"
	
		sudo rm ~/.themes/Dracula -r
		git clone https://github.com/dracula/gtk.git ~/.themes/Dracula
		cp CopyFiles/Dracula ~/.icons -r
	
		cp CopyFiles/AamonGTK3 $HOME/.themes/ -r
		cp CopyFiles/AamonIcons $HOME/.icons/ -r
		echo -e "\nlxappearance has been opened to change the GTK theme and icon set.\nYou may either use AamonGTK3 or Dracula.\nOnce you are finished setting the theme press close, and the install script will continue.\n"
		lxappearance &>/dev/null
	fi
}

fileCopy() {
	copy=$( echo -e "Yes\nNo" | dmenu -p "Would you like to copy all files?" -i )
	if [ $copy == "Yes" ];then
	
		echo "##########################"
		echo "######Copying files#######"
		echo -e "##########################\n"
		
		sudo cp CopyFiles/dwm.desktop /usr/share/xsessions/
		mkdir -p $HOME/.dwm
		cp CopyFiles/autostart.sh $HOME/.dwm/
		mkdir -p $HOME/.config/dunst
		cp CopyFiles/dunstrc $HOME/.config/dunst/
		cp CopyFiles/Backgrounds $HOME/Desktop/ -r
		sudo rm -r /usr/AamonDwmScripts
		sudo cp Scripts /usr/AamonDwmScripts -r
		mkdir -p $HOME/.weather
	
	fi
}

helpMenu() {
	echo "usage: ./install.sh [option]"
	echo "options:"
	echo -e "\tnone:\t Run all functions"
	echo -e "\t-c:\t Run CopyFiles function"
	echo -e "\t-s:\t Run Suckless function"
	echo -e "\t-t:\t Run themes function"
	echo -e "\t-d:\t Run dependencies function"
	echo -e "\t-h:\t Show this menu\n"
}

if [ $1 == "-c" ];then
	fileCopy
elif [ $1 == "-s" ];then
	suckless
elif [ $1 == "-t" ];then
	themes
elif [ $1 == "-d" ];then
	dependencies
elif [ $1 == "-h" ];then
	helpMenu
else
	suckless
	dependencies
	themes
	fileCopy
fi

echo "##########################"
echo "#####Install complete#####"
echo -e "##########################\n"

choices="Show me keybindings\nTake me to the menu\nQuit"

action=$( echo -e $choices | dmenu -p "Welcome to AamonDwm" )

case $action in
	"Show me keybindings") /usr/AamonDwmScripts/dmenu-keybindings & ;;
	"Take me to the menu") /usr/AamonDwmScripts/menu-dmenu & ;;
esac
