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

A list of patches remains inside the Patches folder.

## Dependencies

For the most part it is pretty easy to change the default programs, like the terminal, but here are the dependencies:


### From Pacman

- alacritty
- qutebrowser
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
- bluez-utils
- wmctrl

### From AUR

- google-chrome (google-chrome-stable)
- networkmanager-dmenu-git ([Here's the github](https://github.com/firecat53/networkmanager-dmenu))

### From git

- dmenu (My [Dmenu config](https://github.com/Aamon-Magnusson/AamonDmenu) can and should be used with this config)
- slock (My [slock config](https://github.com/Aamon-Magnusson/AamonSlock))
- slstatus (My [slstatus config](https://github.com/Aamon-Magnusson/AamonSlstatus))

### Not yet implemented

