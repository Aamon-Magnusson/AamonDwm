#! /bin/bash

selectColor () {
	if [ -z $1 ];then
		color=$(echo -e "pink\ndracula\nwhite\nblue" | dmenu -p "What color scheme would you like dwm to follow?" -i )
		[[ "$color" == "" ]] && color="pink"
	fi
	echo "$color"
}

dwmFun () {	
	ex=".h"
	header="$colorScheme$ex"
	cd AamonDwm
	sed -i "s/pink.h/$header/g" config.h
	sudo make -s install clean 
	sed -i "s/$header/pink.h/g" config.h
	cd ..
	echo -e "DWM Compiled\n"
}

stFun () {
	git clone https://github.com/Aamon-Magnusson/AamonSt
	cd AamonSt
	sudo make -s install clean
	cd ..
	sudo rm -r AamonSt
	echo -e "ST Compiled\n"
}
	
dmenuFun () {
	git clone https://github.com/Aamon-Magnusson/AamonDmenu 
	cd AamonDmenu
	if [ -z $1 ];then
		./install.sh $colorScheme
	else
		./install.sh $colorScheme -cli
	fi
	cd ..
	sudo rm -r AamonDmenu
	echo -e "DMENU Compiled\n"
}
	
slsFun () {
	cd AamonSlstatus
	sudo make -s install clean 
	cd ..
	echo -e "SLSTATUS Compiled\n"
}
	
slockFun () {
	git clone https://github.com/Aamon-Magnusson/AamonSlock
	cd AamonSlock
	if [ -z $1 ];then
		./install.sh $colorScheme
	else
		./install.sh $colorScheme -cli
	fi
	cd ..
	sudo rm AamonSlock -r
	echo -e "SLOCK Compiled\n"
}

dependencies () {
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

themes () {
	echo "##########################"
	echo "#########Theming##########"
	echo -e "##########################\n"
	sudo rm ~/.themes/Dracula -r
	git clone https://github.com/dracula/gtk.git ~/.themes/Dracula
	cp CopyFiles/Dracula ~/.icons -r
	cp CopyFiles/AamonGTK3 $HOME/.themes/ -r
	cp CopyFiles/AamonIcons $HOME/.icons/ -r
	if [ -z $1 ];then
		echo -e "\nlxappearance has been opened to change the GTK theme and icon set.\nYou may either use AamonGTK3/AamonIcons or Dracula.\nOnce you are finished setting the theme press close, and the install script will continue.\n"
		lxappearance &>/dev/null
	else
		echo -e "\nlxappearance should be used to set the GTK theme and icon set\nYou may either use AamonGTK3/AamonIcons or Dracula."
	fi
}

fileCopy () {
	echo "##########################"
	echo "######Copying files#######"
	echo -e "##########################\n"
	sudo cp CopyFiles/dwm.desktop /usr/share/xsessions/
	mkdir -p $HOME/.dwm
	cp CopyFiles/autostart.sh $HOME/.dwm/
	cp CopyFiles/Backgrounds $HOME/Desktop/ -r
	sudo rm -r /usr/AamonDwmScripts
	sudo cp Scripts /usr/AamonDwmScripts -r
	mkdir -p $HOME/.weather
	cd CopyFiles
	case $colorTheme in
		"pink")
			changeTo="ff00ff" ;;
		"dracula")
			changeTo="bd93f9" ;;
		"white")
			changeTo="ffffff" ;;
		"blue")
			changeTo="82eefd" ;;
		*)
			changeTo="ff00ff" ;;
	esac
	if [ "$colorTheme" == "dracula" ];then
		sed -i "s/ff0000/ff5555/g" dunstrc
	fi
	sed -i "s/ff00ff/$changeTo/g" dunstrc
	mkdir -p $HOME/.config/dunst
	cp dunstrc $HOME/.config/dunst/
	killall dunst
	dunst &
	sed -i "s/$changeTo/ff00ff/g" dunstrc
	if [ "$colorTheme" == "dracula" ];then
		sed -i "s/ff5555/ff0000/g" dunstrc
	fi
	cd ..
}

dmenuPrompt () {
	var=$( echo -e "Yes\nNo" | dmenu -p "Would you like to install $1?" -i )
	if [ $var == "Yes" ];then
		$2 
	fi
}

helpMenu () {
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

endInstall () {
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
	dmenuFun -cli
fi

if [ -z $1 ];then
	echo -e "\n#############################"
	echo -e "######Starting installer#####"
	echo -e "#############################\n"
	colorScheme=$(selectColor)
	echo -e "#############################"
	echo -e "#Compiling Suckless programs#"
	echo -e "#############################\n"
	dmenuPrompt "dwm" dwmFun
	dmenuPrompt "st" stFun
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
		colorScheme=$(selectColor)
		dmenuPrompt "all files" fileCopy
		endInstall
	elif [ $1 == "-s" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"
		colorScheme=$(selectColor)
		echo -e "#############################"
		echo -e "#Compiling Suckless programs#"
		echo -e "#############################\n"
		dmenuPrompt "dwm" dwmFun
		dmenuPrompt "st" stFun
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
		echo "1) pink"
		echo "2) dracula"
		echo "3) white"
		echo "4) blue"
		echo "From the color schemes above select the number you would like to use."
		read index
		case $index in
			1)
				color="pink" ;;
			2)
				color="dracula" ;;
			3)
				color="white" ;;
			4)
				color="blue" ;;
			*)
				color="pink" ;;
		esac
		colorScheme=$color
		echo -e "#############################"
		echo -e "#Compiling Suckless programs#"
		echo -e "#############################\n"
		dwmFun -cli
		stFun
		dmenuFun -cli
		slsFun
		slockFun -cli
		echo "##########################"
		echo "#####Compile complete#####"
		echo -e "##########################\n"
		dependencies
		themes -cli
		fileCopy
		echo "##########################"
		echo "#####Install complete#####"
		echo -e "##########################\n"
	else
		helpMenu
	fi
fi

