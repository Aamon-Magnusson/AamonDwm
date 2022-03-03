#! /bin/bash

echo -e "Please enter your user/group name.\nIf your user and group names do not match please select n.\n\nName: "

read name

if [ "$name" == "n" ] || [ "$name" == "N" ] || [ "$name" == "" ];then
	echo "SLOCK install skipped!!!"
	echo -e "Slock should be manually installed\n"
	sleep 10
else
	sed -i "s/string/$name/g" config.h
	sudo make -s clean install
	sed -i "s/$name/string/g" config.h
fi
