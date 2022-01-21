# Aamon's DWM config

I am currently just getting into the world of tiling window managers, so here we are, my dwm config!!!

This config includes a dmenu based menu system, which holds several dmenu scripts. To use it hit SUPER + X.

Set up is pretty simple:

```
git clone https://github.com/Aamon-Magnusson/AamonDwm.git
cd AamonDwm # or whatever you named the directory
./setup.sh
#after that I would recommend going into lxappearence to apply the themeing
```

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

