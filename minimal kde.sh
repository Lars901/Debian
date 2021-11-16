#!/bin/bash

set -x;

sudo apt-get update -yq

packages=(
  # can I haz sandwich?
  aspell-en
  hunspell-en-us
  hyphen-en-us

  aspell-pt-br
  hunspell-pt-br
  hyphen-pt-br

  # Apps
  ark
  btrfs-progs
  dolphin
  gwenview
  kate
  kde-spectacle
  kmenuedit
  konsole
  ktorrent
  neofetch
  okular
  qml-module-org-kde-newstuff
  systemsettings
  virt-manager
  virt-viewer
  print-manager
  dialog
  telegram-desktop
 # Build
  gcc
  curl
  wget
  build-essential
  dkms
  linux-headers-$(uname -r)
  # Services
  alsa-utils
  dhcpcd-dbus
  dhcpcd5
  libvulkan1
  libvulkan-dev
  vulkan-tools
  cups
  usbutils
  bluedevil
  khotkeys
  kscreen
  kwalletmanager
  plasma-nm
  plasma-pa
  powerdevil
  polkit-kde-agent-1
  upower

  # DE
  kwin-x11
  plasma-desktop
  plasma-workspace
  sddm
  xorg
  

  # Theming
  breeze-gtk-theme
  kde-config-gtk-style
  kde-config-gtk-style-preview
  sddm-theme-breeze

  # Libs and Plugins
  libqtspell-qt5-0
  qtvirtualkeyboard-plugin
  plasma-browser-integration
  plasma-runners-addons
  pulseaudio-module-bluetooth
  apt-transport-https
  python3-pip
  kde-zeroconf
  # Ark tooling
  unzip

  #Fonts
  fonts-terminus
)

arguments=(
   -y
   -q
  --no-install-recommends
)

sudo apt-get install "${arguments[@]}" "${packages[@]}"
systemctl disable dhcpcd