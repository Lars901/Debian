#!/usr/bin/env bash
echo "Installing Kde-plasma minimal,fonts and Brave-browser dependencies"
sudo apt -y install kde-plasma-desktop plasma-nm apt install fonts-terminus neofetch apt-transport-https curl wget git gdebi-core python3-pip
echo "Importing keyring"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
echo "Installing Brave-browser"
sudo apt install brave-browser
echo "Adding VSCodium GPG key of the repository"
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo "Adding VSCodium repository & installing"
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt install codium
echo "Changing console font & size"
sudo dpkg-reconfigure console-setup

