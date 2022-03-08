#! /bin/bash

fail() {
	echo "SLOCK install skipped!!!"
	echo -e "Slock should be manually installed\n"
}

helpMenu() {
	echo "usage: ./install.sh [options]"
	echo "options:"
	echo -e "\tnone:\tStandard install prompt (dmenu)"
	echo -e "\n-cli:\tCLI install"
	echo -e "\t-h:\tThis help menu\n"
}

if [ -z $1 ];then
	name=$(echo -e "aamonm" | dmenu -p "Enter your username:" -l 2 )
	
	group=$(echo -e "aamonm\nwheel" | dmenu -p "Enter your group name:" -l 3 )
elif [ $1 == "-cli" ];then
	echo -e "\nPlease enter your username:"
	read name
	
	echo -e "\nPlease enter your group name:"
	read group
elif [ $1 == "-h" ];then
	helpMenu
else
	helpMenu
fi

if [ "$name" == "" ] || [ "$group" == "" ];then
	fail
else
	sed -i "s/username/$name/g" config.h 
	sed -i "s/groupname/$group/g" config.h
	sudo make -s clean install
	sed -i "0,/$name/s//username/" config.h
	sed -i "s/$group/groupname/g" config.h
fi


