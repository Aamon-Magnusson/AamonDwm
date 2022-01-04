# Aamon's DWM config

I am currently just getting into the world of tiling window managers, so here we are, my dwm config!!!

This is the very beginning of this config, so as for setup it's pretty simple:

```
git clone https://github.com/Aamon-Magnusson/AamonDwm.git
cd AamonDwm # or whatever you named the directory
sudo make istall
sudo cp CopyFiles/dwm.desktop /usr/share/xsessions/
cp CopyFiles/conky.conf ~/.config/conky/
chmod +x CopyFiles/sutostart.sh
cp CopyFiles/autostart.sh ~/.dwm/
cp CopyFiles/dunstrc ~/.config/dunst/
```

This is very much a work in progress so check in frequently as lots may change.

For a basic display of the keybindings hit SUPER + o. (It'll show in dmenu)

## Dependencies

For the most part it is pretty easy to change the default programs, like the terminal, but here are the dependencies:

- alacritty
- google-chrome-stable
- dolphin
- dmenu (My [Dmenu config](https://github.com/Aamon-Magnusson/AamonDmenu) can and should be used with this config)
- networkmanager_dmenu ([Here's the github](https://github.com/firecat53/networkmanager-dmenu))
- scrot
- flameshot
- nm-connection-editor
- blueman
- conky
- discord
- feh
- picom
- pamixer
- dunst

- xlsclients
- xdotool
