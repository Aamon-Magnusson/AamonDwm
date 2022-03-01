#! /bin/bash

name=$(echo -e "aamonm\nIf your group does not match your user exit" | dmenu -p "Enter your user/group name" -l 2 )
if [ "$name" == "If your group does not match your user exit" ] || [ "$name" == "" ];then
	echo "SLOCK install skipped!!!"
	echo -e "Slock should be manually installed\n"
else
	sed -i "s/string/$name/g" config.h
	sudo make -s clean install
	sed -i "s/$name/string/g" config.h
fi
