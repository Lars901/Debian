#!/usr/bin/env bash

# Change Debian to SID Branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list 

# Graphics Drivers find and install
if lspci | grep -E "NVIDIA|GeForce"; then
    sudo apt -y install nvidia
	nvidia-xconfig
elif lspci | grep -E "Radeon"; then
    sudo apt -y install xserver-xorg-video-amdgpu firmware-amd-graphics
elif lspci | grep -E "Integrated Graphics Controller"; then
    sudo apt -y install libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils --needed --noconfirm
fi

PKGS=(
'apt-transport-https' #Dependecy for Brave
'autoconf' # build
'automake' # build
'make' #build
'bluedevil'
'bluez'
'btrfs-progs'
'celluloid' # video players
'dosfstools'
'vulkan-tools
'mesa-vulkan-drivers'
#'linux-firmware'
#'linux-headers'
'celluloid' # video players
'cups'
'curl'
'fonts-terminus'
'gcc'
'nano'
'neofetch'
'print-manager'
'python3-pip'
'qemu'
'flameshot'
'telegram-desktop'
'usbutils'
'wget'
'ktorrent'
'zip'
'unzip' 

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt -y install "$PKG"
done

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git