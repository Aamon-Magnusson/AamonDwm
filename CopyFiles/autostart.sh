feh --bg-fill --randomize ~/Desktop/Backgrounds/* &
/usr/bin/dunst &
picom -b &
discord &
xautolock -time 20 -locker slock &
(conky | while read LINE; do xsetroot -name "$LINE"; done) &
