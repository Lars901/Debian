#!/usr/bin/env bash

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Fira Code Nerd Font variant needed
cd "$HOME/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts   
fc-cache -vf

#Ms-fonts
sudo apt install ttf-mscorefonts-installer

# Layan Cursors
<<EOF cd "$HOME/build" EOF
git clone https://github.com/vinceliuice/Layan-cursors
cd Layan-cursors
sudo ./install.sh