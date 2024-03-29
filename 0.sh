#!/usr/bin/env bash
sudo apt -y install fonts-terminuscd ..
sudo dpkg-reconfigure console-setup
sudo apt-install libplasma-geolocation-interface5 plasma-desktop plasma-nm sddm konsole dolphin
# determine processor type and install microcode
# 
proc_type=$(lscpu | awk '/Vendor ID:/ {print $3}')
case "$proc_type" in
	GenuineIntel)
		echo "Installing Intel microcode"
		sudo apt -y install intel-microcode
		;;
	AuthenticAMD)
		echo "Installing AMD microcode"
		sudo apt -y install amd64-microcode
		;;
esac	

# Graphics Drivers find and install
if lspci | grep -E "NVIDIA|GeForce"; then
    sudo apt -y install nvidia
	nvidia-xconfig
elif lspci | grep -E "Radeon"; then
    sudo apt -y install xserver-xorg-video-amdgpu firmware-amd-graphics
elif lspci | grep -E "Integrated Graphics Controller"; then
    sudo apt -y install libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils --needed --noconfirm
fi