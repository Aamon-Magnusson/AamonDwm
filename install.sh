#! /bin/bash

dwmFun() {	
	cd AamonDwm
	sudo make -s clean install
	cd ..

	echo -e "DWM Compiled\n"
}
	
dmenuFun() {
	sudo rm -r AamonDmenu
	git clone https://github.com/Aamon-Magnusson/AamonDmenu 
	cd AamonDmenu
	sudo make -s clean install
	cd ..

	echo -e "DMENU Compiled\n"
}
	
slsFun() {
	cd AamonSlstatus
	sudo make -s clean install
	cd ..

	echo -e "SLSTATUS Compiled\n"
}
	
slockFun() {
	echo $2
	sudo rm AamonSlock -r
	git clone https://github.com/Aamon-Magnusson/AamonSlock
	cd AamonSlock
	if [ -z $1 ];then
		./install.sh
	else
		./install.sh -cli
	fi
	cd ..

	echo -e "SLOCK Compiled\n"
}

dependencies() {
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
	echo "#####Dependencies installed####"
	echo -e "###############################\n"
}

themes() {
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
}

cliTheme() {
	echo "##########################"
	echo "#########Theming##########"
	echo -e "##########################\n"

	sudo rm ~/.themes/Dracula -r
	git clone https://github.com/dracula/gtk.git ~/.themes/Dracula
	cp CopyFiles/Dracula ~/.icons -r

	cp CopyFiles/AamonGTK3 $HOME/.themes/ -r
	cp CopyFiles/AamonIcons $HOME/.icons/ -r
	echo -e "\nlxappearance should be used to set the GTK theme and icon set\nYou may either use AamonGTK3 or Dracula."
}
	
fileCopy() {
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
}

dmenuPrompt() {
	var=$( echo -e "Yes\nNo" | dmenu -p "Would you like to install $1?" -i )
	if [ $var == "Yes" ];then
		$2 
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
	echo -e "\t-cli:\tTerminal only install"
}

endInstall() {
	echo "##########################"
	echo "#####Install complete#####"
	echo -e "##########################\n"
	
	choices="Show me keybindings\nTake me to the menu\nQuit"
	
	action=$( echo -e $choices | dmenu -p "Welcome to AamonDwm" )
	
	case $action in
		"Show me keybindings") /usr/AamonDwmScripts/dmenu-keybindings & ;;
		"Take me to the menu") /usr/AamonDwmScripts/menu-dmenu & ;;
	esac
}

if [ ! $(which dmenu) ];then
	dmenuFun
fi

if [ -z $1 ];then
	echo -e "\n#############################"
	echo -e "######Starting installer#####"
	echo -e "#############################\n"

	echo -e "#############################"
	echo -e "#Compiling Suckless programs#"
	echo -e "#############################\n"

	dmenuPrompt "dwm" dwmFun
	dmenuPrompt "dmenu" dmenuFun
	dmenuPrompt "slstatus" slsFun
	dmenuPrompt "slock" slockFun 

	echo "##########################"
	echo "#####Compile complete#####"
	echo -e "##########################\n"

	dmenuPrompt "all dependencies" dependencies
	dmenuPrompt "gtk themes" themes
	dmenuPrompt "all files" fileCopy
	endInstall
else
	if [ $1 == "-c" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"

		dmenuPrompt "all files" fileCopy
		endInstall
	elif [ $1 == "-s" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"

		echo -e "#############################"
		echo -e "#Compiling Suckless programs#"
		echo -e "#############################\n"
	
		dmenuPrompt "dwm" dwmFun
		dmenuPrompt "dmenu" dmenuFun
		dmenuPrompt "slstatus" slsFun
		dmenuPrompt "slock" slockFun 
	
		echo "##########################"
		echo "#####Compile complete#####"
		echo -e "##########################\n"
		endInstall
	elif [ $1 == "-t" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"

		dmenuPrompt "gtk themes" themes
		endInstall
	elif [ $1 == "-d" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"

		dmenuPrompt "all dependencies" dependencies
		endInstall
	elif [ $1 == "-h" ];then
		helpMenu
	elif [ $1 == "-cli" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"

		echo -e "#############################"
		echo -e "#Compiling Suckless programs#"
		echo -e "#############################\n"

		dwmFun
		dmenuFun
		slsFun
		slockFun -cli

		echo "##########################"
		echo "#####Compile complete#####"
		echo -e "##########################\n"

		dependencies
		cliIheme
		fileCopy

		echo "##########################"
		echo "#####Install complete#####"
		echo -e "##########################\n"
	else
		helpMenu
	fi
fi

