#!/usr/bin/env bash
sudo nano /etc/apt/sources.list
sudo apt -y update && upgrade 
sudo apt -y install fonts-terminuscd ..
sudo dpkg-reconfigure console-setup

# determine processor type and install microcode
# 
proc_type=$(lscpu | awk '/Vendor ID:/ {print $3}')
case "$proc_type" in
	GenuineIntel)
		print "Installing Intel microcode"
		sudo apt -y install intel-microcode
		proc_ucode=intel-ucode.img
		;;
	AuthenticAMD)
		print "Installing AMD microcode"
		sudo apt -y install amd64-microcode
		proc_amd64-ucode.img
		;;
esac	

# Graphics Drivers find and install
if lspci | grep -E "NVIDIA|GeForce"; then
    sudo apt -y install nvidia
	nvidia-xconfig
elif lspci | grep -E "Radeon"; then
    sudo apt -y install xf86-video-amdgpu --noconfirm --needed
elif lspci | grep -E "Integrated Graphics Controller"; then
    sudo apt -y install libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils --needed --noconfirm
fi