# Aamon's DWM config

I am currently just getting into the world of tiling window managers, so here we are, my dwm config!!!

This is the very beginning of this config, so as for setup it's pretty simple:

```
git clone https://github.com/Aamon-Magnusson/AamonDwm.git
cd AamonDwm # or whatever you named the directory
sudo make istall
sudo cp CopyFiles/dwm.desktop /usr/share/xsessions/
chmod +x CopyFiles/sutostart.sh
cp CopyFiles/autostart.sh ~/.dwm/
cp CopyFiles/dunstrc ~/.config/dunst/
# the following two lines must also be applied in an aplication like lxappearance
cp CopyFiles/AamonGTK3 ~/.themes/ -r
cp CopyFiles/AamonIcons ~/.icons/ -r
cp CopyFiles/Backgrounds ~/Desktop/ -r
```

This is very much a work in progress so check in frequently as lots may change.

For a basic display of the keybindings hit SUPER + O. (It'll show in dmenu)

When putting this config on to a system make sure to change the directories in the config.h defines. This is also a good time to change any programs that one would like to use.

A list of patches remains inside the Patches folder.

## Dependencies

For the most part it is pretty easy to change the default programs, like the terminal, but here are the dependencies:


### From Pacman

- alacritty
- pcmanfm 
- ranger
- xautolock
- flameshot (or scrot)
- discord
- feh
- picom
- pamixer
- dunst
- gtop
- xorg-xrandr
- arandr
- lxappearance
- wmctrl

- nm-connection-editor
- blueman

### From AUR

- google-chrome (google-chrome-stable)
- networkmanager-dmenu-git ([Here's the github](https://github.com/firecat53/networkmanager-dmenu))

### From git

- dmenu (My [Dmenu config](https://github.com/Aamon-Magnusson/AamonDmenu) can and should be used with this config)
- slock (My [slock config](https://github.com/Aamon-Magnusson/AamonSlock))
- slstatus (My [slstatus config] (https://github.com/Aamon-Magnusson/AamonSlstatus))
- surf (and tabbed) (My [surf and tabbed config](https://github.com/Aamon-Magnusson/AamonSurf))

### Not yet implemented

