feh --bg-fill --randomize ~/Desktop/Backgrounds/* &
/usr/bin/dunst &
picom -b &
discord &
xautolock -time 5 -locker slock &
(conky | while read LINE; do xsetroot -name "$LINE"; done) &
