#!/usr/bin/env bash
username=$(id -u -n 1000)
builddir=$(pwd)

# Change Debian to SID Branch
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sources.list /etc/apt/sources.list 
sudo apt update

PKGS=(
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
'cups' #Common Unix Printing System
'curl'
'dialog'
'dosfstools'
'fonts-terminus'
'flex'
'fuse3'
'fuseiso'
'gamemode'
'gdebi-core'
'gcc'
'gdisk'
'haveged'
'htop'
'nftables'
'inkscape' #Vector Graphics Editor
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
'nala' #Package manager
'nano'
'neofetch'
'ntfs-3g'
'ntp'
'okular'
'obs-studio'
'netcat-openbsd'
'os-prober'
'obs-studio'
'p7zip'
'patch'
'pkgconf' 
'print-manager'
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
'systemsettings'
'fonts-terminus'
'flatpak'
'flameshot'
'traceroute'
'telegram-desktop' #Instant messaging client
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
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt -y install "$PKG"
done

# Graphics Drivers find and install
if lspci | grep -E "NVIDIA|GeForce"; then
    sudo apt -y install nvidia
	nvidia-xconfig
elif lspci | grep -E "Radeon"; then
    sudo apt -y install xserver-xorg-video-amdgpu firmware-amd-graphics
elif lspci | grep -E "Integrated Graphics Controller"; then
    sudo apt -y install libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils --needed --noconfirm
fi

#Flatpak Requirements
sudo apt install plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Making .config and Moving config files and background to Pictures
cd "$builddir" || exit
mkdir -p "/home/$username/.config"
mkdir -p "/home/$username/.fonts"
mkdir -p "/home/$username/Pictures"
mkdir -p /usr/share/sddm/themes
#cp bg.jpg "/home/$username/Pictures/"
chown -R "$username:$username" "/home/$username"

#Nala
sudo nala fetch
#Libreoffice from Nala
sudo nala install libreoffice

# Installing fonts
cd "$builddir" || exit
sudo nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d "/home/$username/.fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d "/home/$username/.fonts"
mv dotfonts/fontawesome/otfs/*.otf "/home/$username/.fonts/"
chown "$username:$username" "/home/$username/.fonts/*"

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors || exit
chmod +x ./install.sh
./install.sh
cd "$builddir" || exit
rm -rf Nordzy-cursors

# Install  Layan Cursors
git clone https://github.com/vinceliuice/Layan-cursors
chmod +x ./install.sh
cd "$builddir" || exit
cd Layan-cursors || exit
./install.sh
cd "$builddir" || exit
rm -Layan-cursors 

# Download Nordic Theme
cd /usr/share/themes/ || exit
sudo git clone https://github.com/EliverLara/Nordic.git

#___________________________________#
#Flatpaks

#Spotify
flatpak install flathub com.spotify.Client
#Dolphin Emu
flatpak install flathub org.DolphinEmu.dolphin-emu
cd "/home/$username"
wget https://static.emulatorgames.net/static3/roms/gamecube/Legend%20of%20Zelda,%20The%20-%20The%20Wind%20Waker%20(USA).7z

#Discord
flatpak install flathub com.discordapp.Discord
#Wallpaper downloader
flatpak install flathub es.estoes.wallpaperDownloader

#Bible applications
flatpak install flathub org.xiphos.Xiphos
#_______________________________________________________________________#

#RPCS3 Emu
cd "$builddir" || exit
wget https://github.com/RPCS3/rpcs3-binaries-linux/releases/download/build-7081b89e976ad7f931c926022bd93ddd9778347c/rpcs3-v0.0.27-14845-7081b89e_linux64.AppImage
wget http://dus01.ps3.update.playstation.net/update/ps3/image/us/2023_0228_05fe32f5dc8c78acbcd84d36ee7fdc5b/PS3UPDAT.PUP
chmod a+x ./rpcs3-*_linux64.AppImage && ./rpcs3-*_linux64.AppImage

sudo dpkg-reconfigure console-setup
#sudo systemctl status libvirtd.service
sudo adduser $User libvirt
sudo adduser $User libvirt-qemu
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

#extra programs
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium -y

#Brave Browser
sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

#Fonts
cd "$builddir"
wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
sudo dpkg -i ttf-mscorefonts-installer_3.6_all.deb

sudo dpkg-reconfigure console-setup
#sudo systemctl status libvirtd.service
sudo adduser $User libvirt
sudo adduser $User libvirt-qemu
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# Download Nordic Theme
cd /usr/share/themes/
sudo git clone https://github.com/EliverLara/Nordic.git

sudo dpkg --add-architecture i386
sudo apt update
sudo apt install build-essential dkms linux-headers-amd64
wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc > /dev/null
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftkey-desktop.list'
sudo apt-get update
sudo apt install github-desktop
sudo apt install steam 
sudo apt install mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
sudo apt install winetricks
sudo apt install libxtst6:i386 libxrandr2:i386 libglib2.0-0:i386 libgtk2.0-0:i386 libpulse0:i386 libgdk-pixbuf2.0-0:i386 libcurl4-openssl-dev:i386 libopenal1:i386 libusb-1.0-0:i386 libdbus-glib-1-2:i386 
sudo apt update

