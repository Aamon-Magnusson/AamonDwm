# Aamon's DWM config

Here is my DWM config.
Included are other Suckless pieces of software:

- Dmenu
- Slstatus
- Slock

![Screen shot of config](GeneralView.png)

My config is meant to be simple and functional.

If you would like exactly what I use us my [Dot files](https://github.com/Aamon-Magnusson/Dotfiles)

## Menu

This config includes a dmenu based menu system, which holds several dmenu scripts. To use it hit SUPER + X.

![Screen shot of menu](dmenuMenu.png)

The scripts included in the menu will be added to frequently.

## Installation

Set up is pretty simple:

```
git clone https://github.com/Aamon-Magnusson/AamonDwm.git
cd AamonDwm # or whatever you named the directory
./install.sh
```

For a basic display of the keybindings hit SUPER + O.

A list of patches remains inside the Patches folder of each Suckless programs folder.

## Removal

If for any reason you would like to uninstall AamonDwm the following command can be ran:

```
./uninstall.sh
```

Selecting "Yes" will keep some files that are used in other WMs that I have configured. Selecting "Remove All" will remove them as well.

## Dependencies

The setup only currently works for Arch based distros.
All dependencies can be seen within the PackageList files. 
They can also be installed automatically with the install script.

## TODO

- Make the setup work on Debian based distros
- Have dynamic color theming for Suckless programs (header file)
