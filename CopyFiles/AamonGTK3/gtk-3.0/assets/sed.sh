#!/bin/sh
sed -i \
         -e 's/#282c34/rgb(0%,0%,0%)/g' \
         -e 's/#cdd3e0/rgb(100%,100%,100%)/g' \
    -e 's/#303842/rgb(50%,0%,0%)/g' \
     -e 's/#ff00ff/rgb(0%,50%,0%)/g' \
     -e 's/#3d434f/rgb(50%,0%,50%)/g' \
     -e 's/#d3dae3/rgb(0%,0%,50%)/g' \
	"$@"
