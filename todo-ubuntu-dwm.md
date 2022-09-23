# Special installations

## How to install specific programs

* Signal
```bash
# NOTE: These instructions only work for 64 bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
sudo apt update && sudo apt install signal-desktop
```
* Discord
	* [https://discord.com/](https://discord.com/)
* Picom
	* compton
* bluez-utils
```bash
sudo apt install bluez
```
* networkmanager-dmenu-git
	* [https://github.com/firecat53/networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)
```bash
sudo apt install ibnm-util-dev gir1.2-nm-1.0 pygobject
```
* libxft-bgra
	* [https://github.com/uditkarode/libxft-bgra](https://github.com/uditkarode/libxft-bgra)
* DWM
```bash
sudo apt-get install build-essential libx11-dev libxinerama-dev sharutils suckless-tools libxft-dev
```
