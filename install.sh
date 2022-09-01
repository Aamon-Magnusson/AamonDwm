#! /bin/bash

update () {
	pull=$(echo -e "Yes\nNo" | fzf --height=10 --border=rounded --prompt=">" --header="Would you like to update AamonDWM?" --header-first --reverse )
	[[ "$pull" == "" ]] && pull="No"
	if [ "$pull" == "Yes" ] || [ "$pull" == "y" ] || [ "$pull" == "Y" ];then
		git pull
	fi
}

selectColor () {
	color=$(echo -e "pink\ndracula\nwhite\nblue" | fzf --height=10 --border=rounded --prompt=">" --header="What color scheme would you like dwm to follow?" --header-first --reverse )
	[[ "$color" == "" ]] && color="pink"
	echo "$color"
}

dwmFun () {
	ex=".h"
	header="$colorScheme$ex"
	cd AamonDwm
	cd colors
	currentColor=$(awk 'NR==1{print $2}' current.h)
	mv current.h $currentColor.h
	mv $header current.h
	cd ..
	sudo make -s install clean
	cd ..
	echo -e "DWM Compiled\n"
}

stFun () {
	git clone https://github.com/Aamon-Magnusson/AamonSt
	cd AamonSt
	./install.sh
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
	if [ -z $1 ];then
		./install.sh
	else
		./install.sh -cli
	fi
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
	res=$(xrandr | grep "*" | awk '{print $1}' | awk -Fx '{print $2}')
	if [ $(expr $res) -lt 1000 ];then
		sed -i "s|dmenu -l 45 -i -p \"Keybindings:\"|dmenu -l 30 -i -p \"Keybindings:\"|g" Scripts/dmenu-keybindings
	fi
	sudo cp Scripts /usr/AamonDwmScripts -r
	if [ $(expr $res) -lt 1000 ];then
		sed -i "s|dmenu -l 30 -i -p \"Keybindings:\"|dmenu -l 45 -i -p \"Keybindings:\"|g" Scripts/dmenu-keybindings
	fi
	cp CopyFiles/networkmanager-dmenu $HOME/.config/ -r
	mkdir -p $HOME/.weather
	cd CopyFiles
	case $colorScheme in
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
	if [ "$colorScheme" == "dracula" ];then
		sed -i "s/ff0000/ff5555/g" dunstrc
		sed -i "s/222222/282a36/g" dunstrc
		sed -i "s/bbbbbb/f8f8f2/g" dunstrc
	fi
	sed -i "s/ff00ff/$changeTo/g" dunstrc
	mkdir -p $HOME/.config/dunst
	cp dunstrc $HOME/.config/dunst/
	killall dunst
	dunst &
	sed -i "s/$changeTo/ff00ff/g" dunstrc
	if [ "$colorScheme" == "dracula" ];then
		sed -i "s/ff5555/ff0000/g" dunstrc
		sed -i "s/282a36/222222/g" dunstrc
		sed -i "s/f8f8f2/bbbbbb/g" dunstrc
	fi
	cd ..
}

fzfPrompt () {
	var=$( echo -e "Yes\nNo" | fzf --height=10 --border=rounded --prompt=">" --header="Would you like to install $1?" --header-first --reverse )
	if [ "$var" == "Yes" ];then
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
	action=$( echo -e $choices | fzf --height=10 --border=rounded --prompt=">" --header="Welcome to AamonDWM" --header-first --reverse )
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
	update
	colorScheme=$(selectColor)
	echo -e "#############################"
	echo -e "#Compiling Suckless programs#"
	echo -e "#############################\n"
	fzfPrompt "dwm" dwmFun
	fzfPrompt "dmenu" dmenuFun
	fzfPrompt "slock" slockFun
	fzfPrompt "slstatus" slsFun
	fzfPrompt "st" stFun
	echo "##########################"
	echo "#####Compile complete#####"
	echo -e "##########################\n"
	fzfPrompt "all dependencies" dependencies
	fzfPrompt "gtk themes" themes
	fzfPrompt "all files" fileCopy
	endInstall
else
	if [ $1 == "-c" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"
		update
		colorScheme=$(selectColor)
		fzfPrompt "all files" fileCopy
		endInstall
	elif [ $1 == "-s" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"
		update
		colorScheme=$(selectColor)
		echo -e "#############################"
		echo -e "#Compiling Suckless programs#"
		echo -e "#############################\n"
		fzfPrompt "dwm" dwmFun
		fzfPrompt "dmenu" dmenuFun
		fzfPrompt "slock" slockFun
		fzfPrompt "slstatus" slsFun
		fzfPrompt "st" stFun
		echo "##########################"
		echo "#####Compile complete#####"
		echo -e "##########################\n"
		endInstall
	elif [ $1 == "-t" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"
		update
		fzfPrompt "gtk themes" themes
		endInstall
	elif [ $1 == "-d" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"
		update
		fzfPrompt "all dependencies" dependencies
		endInstall
	elif [ $1 == "-h" ];then
		helpMenu
	elif [ $1 == "-cli" ];then
		echo -e "\n#############################"
		echo -e "######Starting installer#####"
		echo -e "#############################\n"
		update
		colorScheme=$(selectColor)
		echo -e "#############################"
		echo -e "#Compiling Suckless programs#"
		dwmFun
		dmenuFun
		slockFun
		slsFun
		stFun
		echo -e "#############################\n"
		echo "##########################"
		echo "#####Compile complete#####"
		echo -e "##########################\n"
		dependencies
		fileCopy -cli
		themes -cli
		endInstall
	else
		helpMenu
	fi
fi

