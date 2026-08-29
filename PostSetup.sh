#!/usr/bin/env bash
username=$(id -u -n 1000)
builddir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change Debian to SID Branch
#sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
#sudo cp sources.list /etc/apt/sources.list 
sudo apt update -y

PKGS=(
    'alsa-utils' # ALSA audio utilities
    'ark' # KDE archive manager
    'autoconf' # Build configuration tools
    'automake' # Build automation tools
    'bash-completion' # Bash command completion
    'binutils' # Binary development utilities
    'bison' # Parser generator
    'bluedevil' # KDE Bluetooth integration
    'bluez' # Bluetooth stack
    'breeze' # KDE Breeze theme
    'bridge-utils' # Network bridge utilities for virtual machines
    'btrfs-progs' # Btrfs filesystem utilities
    'cabextract' # Extract Microsoft Cabinet files
    'celluloid' # GTK video player
    'cups' # Common Unix Printing System
    'curl' # Command-line data transfer tool
    'dialog' # Terminal dialog boxes
    'dosfstools' # FAT filesystem utilities
    'firmware-linux-nonfree' # Non-free Linux firmware
    'flameshot' # Screenshot utility
    'flatpak' # Flatpak application framework
    'flex' # Lexical analyzer generator
    'fontforge' # Font editor and converter
    'fonts-terminus' # Terminus fonts
    'fuse3' # Filesystem in Userspace
    'fuseiso' # Mount ISO images using FUSE
    'g++' # GNU C++ compiler
    'gamemode' # Game performance optimization daemon
    'gcc' # GNU C compiler
    'gdebi-core' # Install local DEB packages with dependencies
    'gdisk' # GPT partitioning utility
    'handbrake' # Video transcoder
    'haveged' # Entropy daemon
    'htop' # Interactive process monitor
    'inkscape' # Vector graphics editor
    'kde-zeroconf' # KDE Zeroconf integration
    'kio-audiocd' # KDE Audio CD KIO support
    'ktorrent' # KDE BitTorrent client
    'libalut-dev' # OpenAL utility toolkit development files
    'libavcodec-extra' # Additional multimedia codecs
    'libcupsimage2t64' # CUPS image library
    'libdvd-pkg' # DVD playback support
    'libkf5windowsystem-dev' # KDE WindowSystem development files
    'libnewt-dev' # Newt text UI development files
    'libqt5svg5-dev' # Qt 5 SVG development files
    'libqt5x11extras5-dev' # Qt 5 X11 Extras development files
    'libsdl2-2.0-0' # SDL2 runtime library
    'libsdl2-dev' # SDL2 development files
    'libtool' # Generic library support tools
    'libvirglrenderer1' # VirGL virtual GPU rendering library
    'libvirt-clients' # libvirt command-line tools
    'libvirt-daemon' # libvirt virtualization daemon
    'libvirt-daemon-system' # libvirt system service and configuration
    'libx11-dev' # X11 development files
    'libxext-dev' # X11 extension development files
    'lsof' # List open files
    'lzop' # LZO compression utility
    'm4' # GNU macro processor
    'make' # Build automation tool
    'milou' # KDE search component
    'nala' # APT frontend
    'nano' # Terminal text editor
    'netcat-openbsd' # TCP/UDP networking utility
    'nftables' # Linux firewall framework
    'ntfs-3g' # NTFS filesystem support
    'obs-studio' # Video recording and streaming
    'okular' # KDE document viewer
    'openjdk-21-jre' # Java 21 runtime
    'openjdk-25-jre' # Java 25 runtime
    'os-prober' # Detect other operating systems
    '7zip' # 7-Zip archive utility
    'patch' # Apply source code patches
    'pkgconf' # Package compiler/linker metadata tool
    'print-manager' # KDE printer management
    'python3-pip' # Python package installer

    # QEMU / KVM virtualization
    'qemu-system-x86' # QEMU x86/x86-64 system emulator with KVM support
    'qemu-utils' # QEMU disk image tools such as qemu-img
    'ovmf' # UEFI and Secure Boot firmware for x86-64 virtual machines
    'swtpm' # Software TPM emulator
    'swtpm-tools' # Utilities for configuring virtual TPM devices
    'virtiofsd' # Fast host directory sharing with virtual machines
    'virgl-server' # VirGL vtest server
    'virt-manager' # Graphical virtual machine manager
    'virt-viewer' # Graphical virtual machine console
    'virtinst' # Command-line virtual machine creation tools

    'qt-style-kvantum' # Kvantum Qt theme engine
    'qtbase5-dev' # Qt 5 base development files
    'qttools5-dev-tools' # Qt 5 development tools
    'rsync' # File synchronization utility
    'snapper' # Filesystem snapshot management
    'software-properties-common' # Repository management utilities
    'systemsettings' # KDE System Settings
    'telegram-desktop' # Telegram desktop client
    'traceroute' # Network route diagnostic tool
    'ufw' # Uncomplicated Firewall
    'unrar' # RAR archive extraction
    'unzip' # ZIP archive extraction
    'usbutils' # USB device utilities
    'vulkan-tools' # Vulkan diagnostic utilities
    'wget' # Command-line download utility
    'wireless-regdb' # Wireless regulatory database
    'zip' # ZIP archive creation

    #'kde-baseapps'
    #'lutris'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt -y install "$PKG"
done

# ============================================
# Set Java 25 as default
# ============================================

if [ -x /usr/lib/jvm/java-25-openjdk-amd64/bin/java ]; then
    echo "☕ Setting Java 25 as the default Java runtime..."
    sudo update-alternatives --set java /usr/lib/jvm/java-25-openjdk-amd64/bin/java
    echo "✅ Default Java version:"
    java -version
else
    echo "⚠️ Java 25 runtime was not found."
fi

# ============================================
# Graphics Drivers and Firmware
# ============================================

echo "🔍 Detecting graphics hardware..."

GPU_FOUND=false

if lspci | grep -Eqi 'VGA|3D|Display'; then
    GPU_FOUND=true
fi

# Enable 32-bit architecture once.
# This is useful for Steam, Proton and 32-bit graphics libraries.
if [ "$GPU_FOUND" = true ]; then
    if ! dpkg --print-foreign-architectures | grep -qx i386; then
        echo "➕ Enabling i386 architecture..."
        sudo dpkg --add-architecture i386
        NEED_APT_UPDATE=true
    fi
fi

# Run apt update once if i386 was added.
if [ "${NEED_APT_UPDATE:-false}" = true ]; then
    echo "🔄 Updating package lists..."
    sudo apt update
fi


# ============================================
# AMD Graphics
# ============================================

if lspci | grep -Eqi 'AMD.*(VGA|3D|Display)|ATI.*(VGA|3D|Display)|Radeon'; then
    echo "🎮 AMD graphics detected."
    echo "📦 Installing AMD graphics drivers, firmware and Vulkan support..."

    sudo apt install -y \
        firmware-amd-graphics \
        mesa-vulkan-drivers \
        mesa-vulkan-drivers:i386 \
        mesa-va-drivers \
        mesa-va-drivers:i386 \
        xserver-xorg-video-amdgpu

    echo "✅ AMD graphics support installed."
fi


# ============================================
# NVIDIA Graphics
# ============================================

if lspci | grep -Eqi 'NVIDIA|GeForce'; then
    echo "🎮 NVIDIA graphics detected."

    if dpkg-query -W -f='${Status}' nvidia-driver 2>/dev/null | grep -q "ok installed"; then
        echo "✅ NVIDIA driver is already installed."
    else
        echo "📦 Installing NVIDIA proprietary driver and 32-bit libraries..."

        sudo apt install -y \
            nvidia-driver \
            nvidia-smi \
            nvidia-settings \
            nvidia-driver-libs:i386

        echo "✅ NVIDIA driver installed."
        echo "ℹ️ Do not run nvidia-xconfig on hybrid graphics laptops."
    fi
fi


# ============================================
# Intel Graphics
# ============================================

if lspci | grep -Eqi 'Intel.*(VGA|3D|Display)'; then
    echo "🎮 Intel graphics detected."
    echo "📦 Installing Intel graphics firmware, Vulkan and VA-API support..."

    sudo apt install -y \
        firmware-intel-graphics \
        mesa-vulkan-drivers \
        mesa-vulkan-drivers:i386 \
        mesa-va-drivers \
        mesa-va-drivers:i386 \
        intel-media-va-driver \
        libva-utils

    echo "✅ Intel graphics support installed."
fi


# ============================================
# No Supported GPU Detected
# ============================================

if ! lspci | grep -Eqi \
    'AMD.*(VGA|3D|Display)|ATI.*(VGA|3D|Display)|Radeon|NVIDIA|GeForce|Intel.*(VGA|3D|Display)'; then

    echo "⏭️ No supported AMD, NVIDIA or Intel graphics hardware detected."
fi

#Enable Dvd playback
sudo dpkg-reconfigure libdvd-pkg

#Windows Media Codecs
wget http://www.deb-multimedia.org/pool/non-free/w/w64codecs/w64codecs_20071007-dmo2_amd64.deb
sudo dpkg -i w64codecs_20071007-dmo2_amd64.deb

#Flatpak Requirements
sudo apt install -y plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# ============================================
# User directories and wallpapers
# ============================================
cd "$builddir" || exit
mkdir -p "/home/$username/.config"
mkdir -p "/home/$username/.fonts"
mkdir -p "/home/$username/Pictures/Wallpapers"
sudo mkdir -p /usr/share/sddm/themes

# Copy wallpapers from the Wallpapers directory next to this script.
if [ -d "$builddir/Wallpapers" ]; then
    echo "🖼️ Copying wallpapers..."
    cp -R "$builddir/Wallpapers/." "/home/$username/Pictures/Wallpapers/"
    sudo chown -R "$username:$username" "/home/$username/Pictures/Wallpapers"
    echo "✅ Wallpapers copied."
else
    echo "⚠️ Wallpapers directory not found: $builddir/Wallpapers"
fi

sudo chown -R "$username:$username" "/home/$username/.config" "/home/$username/.fonts" "/home/$username/Pictures"

#Nala
sudo nala fetch
# Installing fonts
cd "$builddir" || exit
git clone https://github.com/SpudGunMan/segoe-ui-linux
sudo nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d "/home/$username/.fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d "/home/$username/.fonts"
mv dotfonts/fontawesome/otfs/*.otf "/home/$username/.fonts/"
sudo chown -R "$username:$username" "/home/$username/.fonts"
sudo nala install fonts-crosextra-carlito fonts-crosextra-caladea -y

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
sudo ./install.sh
cd "$builddir" || exit
rm -rf Layan-cursors

# Download Nordic Theme
cd /usr/share/themes/ || exit
if [ ! -d /usr/share/themes/Nordic ]; then
    sudo git clone https://github.com/EliverLara/Nordic.git
else
    echo "✅ Nordic theme is already installed."
fi

#Enable Backports
sudo add-apt-repository \
  "deb http://deb.debian.org/debian trixie-backports main"
sudo apt update
sudo apt install -t trixie-backports linux-image-amd64 linux-headers-amd64

#________________________________________________________
#AppImg
#SoH
cd "$builddir" || exit
wget https://github.com/HarbourMasters/Shipwright/releases/download/9.1.2/SoH-Copper-Charlie-Linux.zip
unzip -o SoH-Copper-Charlie-Linux.zip
wget https://github.com/HarbourMasters/2ship2harkinian/releases/download/4.0.2/2Ship-Keiichi-Charlie-Linux.zip
unzip -o 2Ship-Keiichi-Charlie-Linux.zip
#wget https://evilgames.eu/files/texture-packs/oot-reloaded-v11.0.0-dolphin-dds-hd.7z
#wget https://evilgames.eu/files/texture-packs/oot-reloaded-v11.0.0-dolphin-dds-4k.7z
wget https://github.com/GhostlyDark/MM-Reloaded-2S2H/releases/download/v11.0.3/mm-reloaded-v11.0.3-2ship-o2r-hd.7z
wget https://github.com/DavidoTek/ProtonUp-Qt/releases/download/v2.15.1/ProtonUp-Qt-2.15.1-x86_64.AppImage
#___________________________________
#Flatpaks

#Flatseal addon
flatpak install -y flathub com.github.tchx84.Flatseal

#KGet Download manager
flatpak install -y flathub org.kde.kget
#Spotify
flatpak install -y flathub com.spotify.Client

#LibreOffice
flatpak install -y flathub org.libreoffice.LibreOffice

#RetroArch
flatpak install -y  --user flathub org.libretro.RetroArch
flatpak update --user org.libretro.RetroArch

#Dolphin Emu
flatpak install -y flathub org.DolphinEmu.dolphin-emu
cd "/home/$username"
wget https://downloads.romspedia.com/roms/Legend%20of%20Zelda%2C%20The%20-%20The%20Wind%20Waker%20%28USA%29.7z
wget https://www.mediafire.com/file/uijj3i3349h8j2j/gba_bios.zip/file

#Ryujinx Emu and fix vm.max_map count for games
flatpak install -y flathub io.github.ryubing.Ryujinx
#wget https://drive.google.com/file/d/1i67zoVVm9AAYRgoKIRsPcPNVETLvseIU/view?usp=sharing
#wget https://drive.google.com/file/d/1HiSTp90tiBFh3ELVbjsX-8SeUkOodxKz/view?usp=sharing
sudo sysctl -w vm.max_map_count=1048576

#Azahar Emu
flatpak install flathub org.azahar_emu.Azahar

#RPCS3 Emu
flatpak install -y flathub net.rpcs3.RPCS3
cd "$builddir" || exit
wget http://dus01.ps3.update.playstation.net/update/ps3/image/us/2023_0228_05fe32f5dc8c78acbcd84d36ee7fdc5b/PS3UPDAT.PUP

#MineCraft
flatpak install -y flathub com.mojang.Minecraft
#Bedrock Edition
flatpak install -y flathub io.mrarm.mcpelauncher

#Discord
flatpak install -y flathub com.discordapp.Discord

#Heroic Games Launcher
flatpak install flathub -y com.heroicgameslauncher.hgl

#Wallpaper downloader
flatpak install -y flathub es.estoes.wallpaperDownloader

#Bible applications
flatpak install -y flathub org.xiphos.Xiphos

#Github Desktop 
flatpak install -y flathub io.github.shiftey.Desktop

#MakeMkv
flatpak install -y flathub com.makemkv.MakeMKV

#Thunderbird Mailclient
flatpak install -y flathub org.mozilla.Thunderbird

#Chatterino
flatpak install -y chatterino

#Taskmanager
flatpak install -y flathub net.nokyan.Resources
#_______________________________________________________________________#

#sudo systemctl status libvirtd.service
sudo adduser "$username" libvirt
sudo adduser "$username" libvirt-qemu
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin


#extra programs
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo nala install codium -y
cd "$builddir" || exit
wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.60.0/fastfetch-linux-amd64.deb
sudo apt install ./fastfetch-linux-amd64.deb -y


#Brave Browser
sudo nala install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo nala install -y brave-browser
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

#Fonts
cd "$builddir"
sudo apt install ttf-mscorefonts-installer -y
#wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.8.1_all.deb
#sudo dpkg -i ttf-mscorefonts-installer_3.8.1_all.deb
# Microsoft Vista / ClearType fonts (Calibri, Cambria, Candara, Consolas, Constantia, Corbel)
# The installer downloads the original PowerPoint Viewer package from the Internet Archive.
VISTA_FONT_INSTALLER="/tmp/vista-fonts-installer.sh"
if curl -fL --retry 3 -o "$VISTA_FONT_INSTALLER" \
    https://raw.githubusercontent.com/metanorma/vista-fonts-installer/master/vista-fonts-installer.sh; then
    chmod +x "$VISTA_FONT_INSTALLER"
    echo "🔤 Starting Microsoft Vista fonts installer..."
    echo "ℹ️ The installer may ask you to accept Microsoft's font EULA."
    sudo "$VISTA_FONT_INSTALLER"
    sudo fc-cache -f -v
    rm -f "$VISTA_FONT_INSTALLER"
    echo "✅ Microsoft Vista fonts installation finished."
else
    echo "⚠️ Could not download the Microsoft Vista fonts installer."
fi

# Multilib architecture is enabled earlier in the graphics section.
sudo apt install -y \
      wine \
      wine32 \
      wine64 \
      libwine \
      libwine:i386 \
      fonts-wine

#sudo apt install steam -y (Black Window CSGO)
sudo nala install -y build-essential dkms linux-headers-amd64
sudo nala install -y mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
sudo nala install -y libxtst6:i386 libxrandr2:i386 libglib2.0-0t64:i386 libgtk2.0-0t64:i386 libpulse0:i386 libgdk-pixbuf-2.0-0:i386 libcurl4-openssl-dev:i386 libopenal1:i386 libusb-1.0-0:i386 libdbus-glib-1-2:i386 
sudo nala install -y linux-headers-$(uname -r)
sudo apt purge -y firefox-esr
sudo apt purge -y konqueror
sudo update-alternatives --config editor

#Minecraft Java Edition Launcher
#wget https://launcher.mojang.com/download/Minecraft.deb
#sudo dpkg -i Minecraft.deb
#Steam Flatpak version
flatpak install -y flathub com.valvesoftware.Steam

#Fix time when dualbooting with Windows 10+
sudo timedatectl set-local-rtc 1
#Unattended upgrades
sudo dpkg-reconfigure unattended-upgrades