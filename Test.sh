#!/usr/bin/env bash

PKGS=(
#'mesa' # Essential Xorg First
#'xorg'
#'xorg-server'
#'xorg-apps'
#'xorg-drivers'
#'xorg-xkill'
#'xorg-xinit'
'xterm'
'plasma-desktop' # KDE Load second
#'alsa-plugins' # audio plugins
'alsa-utils' # audio utils
'ark' # compression
'apt-transport-https' #Dependecy for Brave
'kio-audiocd' 
'autoconf' # build
'automake' # build
'base'
'bash-completion'
'bind9'
'bind9utils'
'binutils'
'bison'
'bluedevil'
'bluez'
'breeze'
'breeze-gtk-theme'
'bridge-utils'
'btrfs-progs'
'celluloid' # video players
'cmatrix'
#'code' # Visual Studio code
'cups'
'curl'
'dialog'
'discover'
'dolphin'
'dosfstools'
'libnvidia-egl-wayland1'
'exfat-utils'
'fonts-terminus'
'flex'
'fuse3'
'fuseiso'
'gamemode'
'gdebi-core'
'gcc'
'gimp' # Photo editing
'git'
'gparted' # partition management
'gdisk'
'grub-customizer'
'haveged'
'htop'
'iptables-nft'
'jdk-openjdk' # Java 17
'kate'
'kvantum-qt5'
'kde-gtk-config'
'konsole'
'layer-shell-qt'
'libnewt'
'libtool'
#'linux'
#'linux-firmware'
#'linux-headers'
'lsof'
'lutris'
'lzop'
'm4'
'make'
'milou'
'nano'
'neofetch'
'networkmanager'
'ntfs-3g'
'ntp'
'okular'
'openbsd-netcat'
'openssh'
'os-prober'
'oxygen'
'p7zip'
'patch'
'pkgconf'
'plasma-nm'
'print-manager'
'pulseaudio'
'pulseaudio-alsa'
'pulseaudio-bluetooth'
'python3-pip'
'qemu'
'rsync'
#'sddm'
#'sddm-kcm'
'snapper'
#'steam'
'systemsettings'
'terminus-font'
'telegram-desktop'
'traceroute'
'ufw'
'unrar'
'unzip'
'usbutils'
'virt-manager'
'virt-viewer'
'wget'
'winetricks'
'xdg-desktop-portal-kde'
'xdg-user-dirs'
'kde-zeroconf'
'ktorrent'
'zip'
#'zsh'
#'zsh-syntax-highlighting'
#'zsh-autosuggestions'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt -y install "$PKG"
done