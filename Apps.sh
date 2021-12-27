#!/usr/bin/env bash

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
'bluedevil'
'bluez'
'btrfs-progs'
'celluloid' # video players
'dosfstools'
'vulkan-tools
'mesa-vulkan-drivers'
