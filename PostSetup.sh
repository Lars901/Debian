#!/usr/bin/env bash

# Change Debian to SID Branch
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sources.list /etc/apt/sources.list 
sudo apt update

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
#'mesa' # Essential Xorg First
#'alsa-plugins' # audio plugins
'alsa-utils' # audio utils
'ark' # compression
'apt-transport-https' #Dependecy for Brave
'kio-audiocd' 
'autoconf' # build
'automake' # build
'bash-completion'
'binutils'
'bison'
'bluedevil'
'bluez'
'breeze'
'btrfs-progs'
'celluloid' # video players
#'code' # Visual Studio code
'cups'
'curl'
'dialog'
'dosfstools'
#'dxvk'
#'libnvidia-egl-wayland1'
'exfat-utils'
'fonts-terminus'
'flex'
'fuse3'
'fuseiso'
'gamemode'
'gdebi-core'
'gcc'
'gdisk'
'grub-customizer'
'haveged'
'htop'
'nftables'
#'openjdk-17-jdk' # Java 17
#'openjdk-17-jre' #Java 17 jre
'qt5-style-kvantum'
'libnewt-dev'
'libtool'
'lsof'
'lutris'
'lzop'
'm4'
'make'
'milou'
'nano'
'neofetch'
'ntfs-3g'
'ntp'
'okular'
'obs-studio'
'netcat-openbsd'
#'openssh-client'
'os-prober'
#'oxygen'
'obs-studio'
'p7zip'
'patch'
'pkgconf' 
'print-manager'
#'pulseaudio'
#'pulseaudio-alsa'
#'pulseaudio-bluetooth'
'python3-pip'
'qemu-kvm'
'libvirt-clients' #Dependecy for quemu
'libvirt-daemon-system' #Dependecy for quemu
'bridge-utils' #Dependecy for quemu
'virtinst' #Dependecy for virt-manager
'libvirt-daemon' #Dependecy for virt-manager
'virt-manager' 
'rsync'
'snapper'
#'steam'
'systemsettings'
'fonts-terminus'
'flameshot'
'telegram-desktop'
'traceroute'
'ufw'
'unrar'
'unzip'
'usbutils'
'vulkan-tools'
'virt-manager'
'virt-viewer'
'wget'
'kde-zeroconf'
'ktorrent'
'kde-baseapps'
'zip'
'g++'
'libx11-dev'
'libxext-dev'
'qtbase5-dev'
'libqt5svg5-dev'
'libqt5x11extras5-dev'
'libkf5windowsystem-dev'
'qttools5-dev-tools'
#'zsh'
#'zsh-syntax-highlighting'
#'zsh-autosuggestions'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt -y install "$PKG"
done

sudo dpkg-reconfigure console-setup
#sudo systemctl status libvirtd.service
sudo adduser larsove libvirt
sudo adduser larsove libvirt-qemu