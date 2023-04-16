#!/usr/bin/env bash
username=$(id -u -n 1000)
builddir=$(pwd)

# Change Debian to SID Branch
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sources.list /etc/apt/sources.list 
sudo apt update -y

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
'handbrake'
'haveged'
'htop'
'nftables'
'inkscape' #Vector Graphics Editor
#'openjdk-17-jdk' # Java 17
#'openjdk-17-jre' #Java 17 jre
'qt5-style-kvantum'
'libavcodec-extra' # Extra codecs
'libdvdread8 ' #Enable dvd playback
'libnewt-dev'
'libtool'
'libdvd-pkg'  #Enable dvd playback
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
    sudo apt -y install nvidia nvidia-xconfig
elif lspci | grep -E "Radeon"; then
    sudo apt -y install xserver-xorg-video-amdgpu firmware-amd-graphics
elif lspci | grep -E "Integrated Graphics Controller"; then
    sudo apt -y install libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils --needed --noconfirm
fi

#Enable Dvd playback
sudo dpkg-reconfigure libdvd-pkg

#Windows Media Codecs
wget http://www.deb-multimedia.org/pool/non-free/w/w64codecs/w64codecs_20071007-dmo2_amd64.deb
sudo dpkg -i w64codecs_20071007-dmo2_amd64.deb

#Flatpak Requirements
sudo apt install -y plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Making .config and Moving config files and background to Pictures/Wallpapers
cd "$builddir" || exit
mkdir -p "/home/$username/.config"
mkdir -p "/home/$username/.fonts"
mkdir -p "/home/$username/Pictures"
mkdir -p "/home/$username/Wallpapers"
mkdir -p /usr/share/sddm/themes
cd /Wallpapers
cp *.jpg /$HOME/$USER/Pictures/Wallpapers
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

# Reloading Font cache
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
cd Layan-cursors || exit
chmod +x ./install.sh
./install.sh
cd "$builddir" || exit
rm -Layan-cursors 

# Download Nordic Theme
cd /usr/share/themes/ || exit
sudo git clone https://github.com/EliverLara/Nordic.git

#___________________________________#
#Flatpaks

#Spotify
flatpak install -y flathub com.spotify.Client
#Dolphin Emu
flatpak install -y flathub org.DolphinEmu.dolphin-emu
cd "/home/$username"
#wget https://downloads.romspedia.com/roms/Legend%20of%20Zelda%2C%20The%20-%20The%20Wind%20Waker%20%28USA%29.7z

#RPCS3 Emu
flatpak install -y flathub net.rpcs3.RPCS3
cd "$builddir" || exit
wget http://dus01.ps3.update.playstation.net/update/ps3/image/us/2023_0228_05fe32f5dc8c78acbcd84d36ee7fdc5b/PS3UPDAT.PUP

#Discord
flatpak install -y flathub com.discordapp.Discord

#Wallpaper downloader
flatpak install -y flathub es.estoes.wallpaperDownloader

#Bible applications
flatpak install -y flathub org.xiphos.Xiphos

#Github Desktop 
flatpak install -y flathub io.github.shiftey.Desktop
#_______________________________________________________________________#

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

#sudo systemctl status libvirtd.service
sudo adduser $User libvirt
sudo adduser $User libvirt-qemu
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# Download Nordic Theme
cd /usr/share/themes/
sudo git clone https://github.com/EliverLara/Nordic.git

sudo dpkg --add-architecture i386
sudo apt update -y
sudo apt install steam -y
sudo apt install -y build-essential dkms linux-headers-amd64
sudo apt install -y mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
sudo apt install -y winetricks
sudo apt install -y libxtst6:i386 libxrandr2:i386 libglib2.0-0:i386 libgtk2.0-0:i386 libpulse0:i386 libgdk-pixbuf2.0-0:i386 libcurl4-openssl-dev:i386 libopenal1:i386 libusb-1.0-0:i386 libdbus-glib-1-2:i386 
sudo apt install -y linux-headers-6.1.0-7-amd64
sudo apt purge -y firefox-esr
sudo apt purge -y konqueror
sudo update-alternatives --config editor